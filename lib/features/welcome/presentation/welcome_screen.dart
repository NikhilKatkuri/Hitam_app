import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hitam_app/core/constants/app_theme.dart';
import 'package:hitam_app/core/routes/app_routes.dart';
import 'package:hitam_app/core/utils/app_images.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 64),
                Image.asset(AppImages.welcomeScreenImage),
                const SizedBox(height: 56),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome to HITAM", style: AppTheme.headerText),
                    const Text("Your role-based gateway to the campus"),
                  ],
                ),

                const SizedBox(height: 36),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: AppRoutes.roleRoutes.map((routeAuth) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              context.go(routeAuth.route);
                            },
                            style: AppTheme.primaryButton,
                            child: Text(routeAuth.title),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  }).toList(),
                ),

                const SizedBox(height: 60),
                Center(
                  child: Text(
                    "HITAM Connect © 2025 | Powered by HITAM",
                    style: AppTheme.footerText, // Assuming AppTheme.footerText is a TextStyle
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
