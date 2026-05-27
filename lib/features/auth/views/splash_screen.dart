import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _shineController;

  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _floatAnimation;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();

    _mainController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _shineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.6,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: Curves.easeOutBack,
      ),
    );

    _floatAnimation = Tween<double>(
      begin: -8,
      end: 8,
    ).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: Curves.easeInOut,
      ),
    );

    _progressAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: Curves.linear,
      ),
    );

    _mainController.forward();

    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/Login');
      }
    });
  }

  @override
  void dispose() {
    _mainController.dispose();
    _shineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: AnimatedBuilder(
        animation: Listenable.merge([
          _mainController,
          _shineController,
        ]),
        builder: (context, child) {
          return Stack(
            children: [
              Center(
                child: Transform.translate(
                  offset: Offset(0, _floatAnimation.value),
                  child: Opacity(
                    opacity: _fadeAnimation.value,
                    child: Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 190.w,
                                height: 190.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                      AppColors.primary.withOpacity(0.15),
                                      blurRadius: 40,
                                      spreadRadius: 8,
                                    ),
                                  ],
                                ),
                              ),

                              ClipRRect(
                                borderRadius: BorderRadius.circular(100.r),
                                child: Stack(
                                  children: [
                                    Image.asset(
                                      'lib/assets/logomob.png',
                                      width: 170.w,
                                      height: 170.h,
                                    ),

                                    Positioned(
                                      left: (-100.w) +
                                          (_shineController.value * 300.w),
                                      top: 0,
                                      bottom: 0,
                                      child: Transform.rotate(
                                        angle: 0.3,
                                        child: Container(
                                          width: 50.w,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.white.withOpacity(0),
                                                Colors.white.withOpacity(0.35),
                                                Colors.white.withOpacity(0),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 28.h),

                          Transform.translate(
                            offset: Offset(
                              0,
                              20 * (1 - _fadeAnimation.value),
                            ),
                            child: Opacity(
                              opacity: _fadeAnimation.value,
                              child: Column(
                                children: [
                                  Text(
                                    'MobizSales',
                                    style: TextStyle(
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.primary,
                                      letterSpacing: 1.2,
                                    ),
                                  ),

                                  SizedBox(height: 8.h),

                                  Text(
                                    'Accelerate Your Sales Growth',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textSecondary,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Positioned(
              //   left: 30.w,
              //   right: 30.w,
              //   bottom: 60.h,
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.circular(20.r),
              //     child: LinearProgressIndicator(
              //       value: _progressAnimation.value,
              //       minHeight: 6.h,
              //       backgroundColor:
              //       AppColors.inputBorder.withOpacity(0.3),
              //       valueColor: AlwaysStoppedAnimation(
              //         AppColors.primary,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          );
        },
      ),
    );
  }
}