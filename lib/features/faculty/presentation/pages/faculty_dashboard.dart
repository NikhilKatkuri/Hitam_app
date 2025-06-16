import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hitam_app/core/routes/app_routes.dart';
import 'package:hitam_app/features/auth/presentation/provider/auth_provider_context.dart';
import 'package:provider/provider.dart';

class FacultyDashboard extends StatefulWidget {
  const FacultyDashboard({super.key});

  @override
  State<FacultyDashboard> createState() => _FacultyDashboardState();
}

class _FacultyDashboardState extends State<FacultyDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text('faculty'),
              GestureDetector(
                onTap: () {
                  // Perform logout logic here
                  Provider.of<AuthProviderContext>(context, listen: false).logout();
                  context.go(AppRoutes.splashRoute);
                },
                child: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
