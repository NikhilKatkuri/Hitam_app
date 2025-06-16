import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:hitam_app/features/auth/presentation/pages/admin_login_page.dart';
import 'package:hitam_app/features/auth/presentation/pages/faculty_login_page.dart';
import 'package:hitam_app/features/auth/presentation/pages/student_login_page.dart';
import 'package:hitam_app/features/auth/presentation/provider/auth_provider_context.dart';
import 'package:hitam_app/features/faculty/presentation/pages/faculty_dashboard.dart';
import 'package:hitam_app/features/splash/presentation/app_splash.dart';
import 'package:hitam_app/features/student/presentation/pages/student_dashboard.dart';
import 'package:hitam_app/features/welcome/presentation/welcome_screen.dart';
import 'package:provider/provider.dart';

class RouteAuth {
  final String title;
  final String route;

  const RouteAuth({required this.title, required this.route});
}

class AppRoutes {
  static const String splashRoute = '/';
  static const String welcomeRoute = '/welcome';
  static const String studentLoginRoute = '/login/student';
  static const String facultyLoginRoute = '/login/faculty';
  static const String adminLoginRoute = '/login/admin';
  static const String facultyDashboardRoute = '/dashboard/faculty';
  static const String studentDashboardRoute = '/dashboard/student';

  static final List<RouteAuth> roleRoutes = [
    RouteAuth(title: "Login as Student", route: studentLoginRoute),
    RouteAuth(title: "Login as Faculty", route: facultyLoginRoute),
    RouteAuth(title: "Login as Admin", route: adminLoginRoute),
  ];

  static final GoRouter router = GoRouter(
    initialLocation: splashRoute,
    redirect: (context, state) {
      final auth = Provider.of<AuthProviderContext>(context, listen: false);
      final isLoggedIn = auth.authStatus == AuthStatus.authenticated;
      final isGoingToLogin = state.uri.toString().startsWith('/login');
      if (isLoggedIn && isGoingToLogin) {
        switch (auth.userRole) {
          case UserRole.student:
            return studentDashboardRoute;
          case UserRole.faculty:
            return facultyDashboardRoute;
          default:
            return welcomeRoute;
        }
      }
      if (!isLoggedIn &&
          (state.uri.toString() == facultyDashboardRoute ||
              state.uri.toString() == studentDashboardRoute)) {
        return welcomeRoute;
      }
      return null;
    },
    routes: [
      GoRoute(path: splashRoute, builder: (context, state) => const AppSplash()),
      GoRoute(path: welcomeRoute, builder: (context, state) => const WelcomeScreen()),
      GoRoute(path: studentLoginRoute, builder: (context, state) => const StudentLoginPage()),
      GoRoute(path: facultyLoginRoute, builder: (context, state) => const FacultyLoginPage()),
      GoRoute(path: adminLoginRoute, builder: (context, state) => const AdminLoginPage()),
      GoRoute(path: facultyDashboardRoute, builder: (context, state) => const FacultyDashboard()),
      GoRoute(path: studentDashboardRoute, builder: (context, state) => const StudentDashboard()),
    ],
    errorBuilder: (context, state) =>
        const Scaffold(body: Center(child: Text('404 - Page Not Found'))),
  );
}
