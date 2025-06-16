import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hitam_app/core/constants/app_theme.dart';
import 'package:hitam_app/core/utils/app_images.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  void _submitLogin() {
    if (_formKey.currentState!.validate()) {
      // Proceed with login logic
      debugPrint("Logging in with: ${_emailController.text}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(), // Dismiss keyboard
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
                              FocusScope.of(context).unfocus();
                              await Future.delayed(const Duration(milliseconds: 100));
                              if (!mounted) return;
                              // ignore: use_build_context_synchronously
                              context.pop();
                            },
                            child: const Icon(Icons.arrow_back),
                          ),
                          const SizedBox(height: 8),
                          Center(
                            child: Image.asset(
                              AppImages.adminScreenImage,
                              width: MediaQuery.of(context).size.width - 64,
                            ),
                          ),
                          const SizedBox(height: 30),
                          Text("Login as Admin", style: AppTheme.headerText),
                          const SizedBox(height: 8),
                          Text(
                            "Manage campus operations, users, and system settings securely.",
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          const SizedBox(height: 24),

                          // Email field
                          TextFormField(
                            controller: _emailController,
                            focusNode: _emailFocus,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
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
                            obscureText: true,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: Icon(Icons.visibility_off),
                              labelText: 'Password',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            onFieldSubmitted: (_) => _submitLogin(),
                          ),
                          SizedBox(height: 20),
                          // Login Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _submitLogin,
                              style: AppTheme.primaryButton,
                              child: const Text("Login"),
                            ),
                          ),
                          SizedBox(height: 48),
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
