import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

enum UserRole { none, student, faculty, admin }

class AuthProviderContext with ChangeNotifier {
  AuthStatus _authStatus = AuthStatus.unknown;
  AuthStatus get authStatus => _authStatus;
  UserRole _userRole = UserRole.none;
  UserRole get userRole => _userRole;

  Map<String, dynamic>? _user;
  Map<String, dynamic>? get user => _user;

  // return role
  UserRole _getRole(String role) {
    switch (role.toLowerCase()) {
      case 'student':
        return UserRole.student;
      case 'faculty':
        return UserRole.faculty;
      case 'admin':
        return UserRole.admin;
      default:
        return UserRole.none;
    }
  }

  // to check is authenticated
  Future<bool> isAuth() async {
    final prefs = await SharedPreferences.getInstance();

    final authenticated = prefs.getBool('authenticated') ?? false;
    final token = prefs.getString('token');
    final userRole = prefs.getString('userRole');
    final userData = prefs.getString('userData');

    if (authenticated && token != null && userRole != null && userData != null) {
      _userRole = _getRole(userRole);
      _authStatus = AuthStatus.authenticated;
      _user = jsonDecode(userData);
    } else {
      _authStatus = AuthStatus.unauthenticated;
      _userRole = UserRole.none;
      _user = null;
    }

    notifyListeners();
    return authenticated;
  }

  //  login based on roles
  Future<void> loginUsingRole(String email, String password, String role) async {
    final url = Uri.parse('https://testusers.onrender.com/api/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'collegeEmail': email, 'password': password, 'role': role.toLowerCase()}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('authenticated', true);
        await prefs.setString('token', data['user']['collegeEmail']);
        await prefs.setString('userRole', role);
        await prefs.setString('userData', jsonEncode(data['user']));

        _authStatus = AuthStatus.authenticated;
        _userRole = _getRole(role);
        _user = data['user'];
      } else {
        throw Exception(data['message'] ?? 'Login failed');
      }
    } catch (e) {
      _authStatus = AuthStatus.unauthenticated;
      _userRole = UserRole.none;
      _user = null;
      notifyListeners();
      rethrow;
    }

    notifyListeners();
  }

  // logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('authenticated', false);
    await prefs.remove('token');
    await prefs.remove('userRole');
    await prefs.remove('userData');

    _authStatus = AuthStatus.unauthenticated;
    _userRole = UserRole.none;
    _user = null;
    notifyListeners();
  }
}
