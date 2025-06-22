import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hitam_app/core/routes/app_routes.dart';
import 'package:hitam_app/features/auth/presentation/provider/auth_provider_context.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  String email = 'Loading...';
  String userName = '';

  @override
  void initState() {
    super.initState();
    _loadName();
  }

  Future<void> _loadName() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final storedToken = prefs.getString('token');
      final userDataString = prefs.getString('userData');
      if (userDataString != null) {
        final Map<String, dynamic> userData = jsonDecode(userDataString);
        setState(() {
          userName = userData['name'];
        });
      }
      setState(() {
        email = storedToken?.isNotEmpty == true ? storedToken! : 'Guest';
      });
    } catch (e) {
      setState(() {
        email = 'Error Loading Name';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Provider.of<AuthProviderContext>(context, listen: false).logout();
              context.go(AppRoutes.splashRoute);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Center(
            child: Column(
              children: [
                Text(
                  'Welcome, $email $userName',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
