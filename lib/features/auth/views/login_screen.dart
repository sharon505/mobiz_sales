import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_strings.dart';
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

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final LoginController controller = LoginController();

  bool obscurePassword = true;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthViewModel>(
        builder: (context, auth, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.primary.withOpacity(0.08),
                  AppColors.scaffoldBackground,
                  Colors.white,
                ],
              ),
            ),
            child: SafeArea(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 20.h,
                    ),
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 20.h),

                          const LoginHeader(),

                          SizedBox(height: 40.h),

                          Container(
                            padding: EdgeInsets.all(24.w),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.92),
                              borderRadius: BorderRadius.circular(24.r),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                  AppColors.primary.withOpacity(0.08),
                                  blurRadius: 25,
                                  spreadRadius: 4,
                                ),
                              ],
                              border: Border.all(
                                color:
                                AppColors.inputBorder.withOpacity(0.3),
                              ),
                            ),
                            child: Column(
                              children: [
                                EmailField(
                                  controller:
                                  controller.emailController,
                                ),

                                SizedBox(height: 20.h),

                                PasswordField(
                                  controller:
                                  controller.passwordController,
                                  obscurePassword: obscurePassword,
                                  onToggle: () {
                                    setState(() {
                                      obscurePassword =
                                      !obscurePassword;
                                    });
                                  },
                                ),


                                SizedBox(height: 20.h),

                                LoginButton(
                                  isLoading: auth.isLoading,
                                  onPressed: () =>
                                      controller.login(context),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 24.h),

                          Text(
                            AppStrings.appVersion,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColors.textSecondary.withOpacity(0.7),
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
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