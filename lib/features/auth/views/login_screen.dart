import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../controllers/login_controller.dart';
import '../view_models/auth_view_model.dart';
import '../widgets/email_field.dart';
import '../widgets/login_button.dart';
import '../widgets/login_header.dart';
import '../widgets/password_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController controller = LoginController();

  bool obscurePassword = true;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthViewModel>(
        builder: (context, auth, child) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Form(
                key: controller.formKey,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const LoginHeader(),
                        SizedBox(height: 40.h),

                        EmailField(
                          controller: controller.emailController,
                        ),

                        SizedBox(height: 20.h),

                        PasswordField(
                          controller: controller.passwordController,
                          obscurePassword: obscurePassword,
                          onToggle: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                        ),

                        SizedBox(height: 30.h),

                        LoginButton(
                          isLoading: auth.isLoading,
                          onPressed: () => controller.login(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}