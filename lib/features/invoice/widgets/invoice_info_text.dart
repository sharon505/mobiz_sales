import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_text_styles.dart';

class InvoiceInfoText extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final bool highlight;

  const InvoiceInfoText({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
        color: highlight
            ? AppColors.primary.withOpacity(0.08)
            : Colors.white.withOpacity(0.65),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: highlight
              ? AppColors.primary.withOpacity(0.12)
              : AppColors.inputBorder.withOpacity(0.35),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.h,
            decoration: BoxDecoration(
              color: highlight
                  ? AppColors.primary.withOpacity(0.12)
                  : AppColors.inputFill,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              icon,
              size: 18.sp,
              color: highlight
                  ? AppColors.primary
                  : AppColors.textSecondary,
            ),
          ),

          SizedBox(width: 10.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: 10.sp,
                    color: AppColors.textSecondary,
                  ),
                ),

                SizedBox(height: 4.h),

                Text(
                  value,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 13.sp,
                    color: highlight
                        ? AppColors.primary
                        : AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}