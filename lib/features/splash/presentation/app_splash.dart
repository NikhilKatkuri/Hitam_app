import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hitam_app/core/utils/app_images.dart';
import 'package:hitam_app/features/auth/presentation/provider/auth_provider_context.dart';
import 'package:provider/provider.dart';
import 'package:hitam_app/core/routes/app_routes.dart';

class AppSplash extends StatefulWidget {
  const AppSplash({super.key});

  @override
  State<AppSplash> createState() => _AppSplashState();
}

class _AppSplashState extends State<AppSplash> {
  @override
  void initState() {
    super.initState();

    // Set status bar style
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    // Wait and then navigate based on auth status
    Future.delayed(const Duration(seconds: 2), _checkAndRedirect);
  }

  void _checkAndRedirect() async {
    final auth = Provider.of<AuthProviderContext>(context, listen: false);

    // Give a short splash delay
    await Future.delayed(const Duration(seconds: 2));

    final isAuthenticated = await auth.isAuth();

    if (!mounted) return;

    if (isAuthenticated) {
      switch (auth.userRole) {
        case UserRole.faculty:
          context.go(AppRoutes.facultyDashboardRoute);
          break;
        case UserRole.student:
          context.go(AppRoutes.studentDashboardRoute);
          break;
        case UserRole.admin:
          context.go(AppRoutes.welcomeRoute);
          break;
        default:
          context.go(AppRoutes.welcomeRoute);
      }
    } else {
      context.go(AppRoutes.welcomeRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset(AppImages.hitamTree, height: 160, width: 160),
              const Spacer(),
              const Text(
                'HITAM',
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
