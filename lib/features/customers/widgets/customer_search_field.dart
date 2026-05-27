import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_strings.dart';
import '../../../utils/constants/app_text_styles.dart';

class CustomerSearchField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const CustomerSearchField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.05),
              blurRadius: 14,
              spreadRadius: 1,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: AppStrings.searchCustomer,
            hintStyle: AppTextStyles.bodySmall.copyWith(
              color: AppColors.hintText,
            ),
            prefixIcon: Container(
              padding: EdgeInsets.all(12.w),
              child: Icon(
                Icons.search_rounded,
                color: AppColors.primary,
                size: 22.sp,
              ),
            ),
            suffixIcon: controller.text.isNotEmpty
                ? IconButton(
              onPressed: () {
                controller.clear();
                onChanged('');
              },
              icon: Icon(
                Icons.close_rounded,
                color: AppColors.textSecondary,
                size: 20.sp,
              ),
            )
                : null,
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 18.w,
              vertical: 16.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.r),
              borderSide: BorderSide(
                color: AppColors.inputBorder,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.r),
              borderSide: BorderSide(
                color: AppColors.inputBorder.withOpacity(0.6),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.r),
              borderSide: BorderSide(
                color: AppColors.primary,
                width: 1.4,
              ),
            ),
          ),
        ),
      ),
    );
  }
}