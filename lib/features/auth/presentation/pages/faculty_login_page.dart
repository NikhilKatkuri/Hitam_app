import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hitam_app/core/constants/app_theme.dart';
import 'package:hitam_app/core/routes/app_routes.dart';
import 'package:hitam_app/core/utils/app_images.dart';
import 'package:hitam_app/features/auth/presentation/provider/auth_provider_context.dart';

import 'package:provider/provider.dart';

class FacultyLoginPage extends StatefulWidget {
  const FacultyLoginPage({super.key});

  @override
  State<FacultyLoginPage> createState() => _FacultyLoginPageState();
}

class _FacultyLoginPageState extends State<FacultyLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  bool _isLoading = false;
  bool passwordView = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  Future<void> _submitLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      try {
        await Provider.of<AuthProviderContext>(
          context,
          listen: false,
        ).loginUsingRole(email, password, 'faculty');

        if (!mounted) return;
        context.go(AppRoutes.splashRoute);
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              if (mounted) {
                                FocusScope.of(context).unfocus();
                                await Future.delayed(const Duration(milliseconds: 100));
                                // ignore: use_build_context_synchronously
                                context.go(AppRoutes.welcomeRoute);
                              }
                            },
                            child: const Icon(Icons.arrow_back),
                          ),
                          const SizedBox(height: 8),
                          Image.asset(AppImages.facultyScreenImage, scale: .6),
                          const SizedBox(height: 40),
                          Text("Login as Faculty", style: AppTheme.headerText),
                          const SizedBox(height: 8),
                          Text(
                            "Welcome back! Let's get you connected to your campus.",
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          const SizedBox(height: 24),

                          // Email field
                          TextFormField(
                            controller: _emailController,
                            focusNode: _emailFocus,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(_passwordFocus);
                            },
                          ),
                          const SizedBox(height: 16),

                          // Password field
                          TextFormField(
                            controller: _passwordController,
                            focusNode: _passwordFocus,
                            textInputAction: TextInputAction.done,
                            obscureText: !passwordView,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    passwordView = !passwordView;
                                  });
                                },
                                child: Icon(passwordView ? Icons.visibility : Icons.visibility_off),
                              ),
                              labelText: 'Password',
                              border: const OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            onFieldSubmitted: (_) => _submitLogin(),
                          ),
                          const SizedBox(height: 20),

                          // Login Button or Loader
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _submitLogin,
                              style: AppTheme.primaryButton,
                              child: _isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    )
                                  : const Text("Login"),
                            ),
                          ),

                          const SizedBox(height: 48),
                          Center(
                            child: Text(
                              "HITAM Connect © 2025 | Powered by HITAM",
                              style: AppTheme.footerText,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
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
