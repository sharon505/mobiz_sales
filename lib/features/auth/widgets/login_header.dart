import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_strings.dart';
import '../../../utils/constants/app_text_styles.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(

          borderRadius: BorderRadius.circular(100.r),
          child: Image.asset(
            'lib/assets/logomob.png',
            width: 220.w,
            height: 240.h,
            fit: BoxFit.contain,
          ),
        ),

        SizedBox(height: 2.h),

        Text(
          AppStrings.appName,
          style: AppTextStyles.heading2.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w800,
            letterSpacing: 1,
          ),
        ),

        SizedBox(height: 4.h),

        Text(
          AppStrings.loginToContinue,
          style: AppTextStyles.subtitle.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}