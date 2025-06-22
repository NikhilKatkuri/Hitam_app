import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hitam_app/core/constants/app_theme.dart';
import 'package:hitam_app/core/routes/app_routes.dart';
import 'package:hitam_app/features/auth/presentation/provider/auth_provider_context.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => AuthProviderContext()..isAuth(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRoutes.router,
      debugShowCheckedModeBanner: false,
      title: AppTheme.title,
      theme: AppTheme.lightTheme,
    );
  }
}
