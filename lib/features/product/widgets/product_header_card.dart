import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_strings.dart';
import '../../../utils/constants/app_text_styles.dart';
import '../models/product_model.dart';

class ProductHeaderCard extends StatelessWidget {
  final ProductModel product;

  const ProductHeaderCard({
    super.key,
    required this.product,
  });

  Widget _infoChip({
    required IconData icon,
    required String text,
    bool highlight = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 6.h,
      ),
      decoration: BoxDecoration(
        color: highlight
            ? AppColors.primary.withOpacity(0.08)
            : Colors.white.withOpacity(0.45),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: highlight
              ? AppColors.primary.withOpacity(0.15)
              : Colors.white.withOpacity(0.35),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14.sp,
            color: highlight
                ? AppColors.primary
                : AppColors.textSecondary,
          ),
          SizedBox(width: 6.w),
          Text(
            text,
            style: AppTextStyles.bodySmall.copyWith(
              color: highlight
                  ? AppColors.primary
                  : AppColors.textSecondary,
              fontWeight:
              highlight ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10,
          sigmaY: 10,
        ),
        child: Container(
          margin: EdgeInsets.all(16.w),
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.65),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: Colors.white.withOpacity(0.35),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.06),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 56.w,
                height: 56.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.primaryDark,
                    ],
                  ),
                ),
                child: Icon(
                  Icons.inventory_2_outlined,
                  color: Colors.white,
                  size: 26.sp,
                ),
              ),

              SizedBox(width: 14.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),

                    SizedBox(height: 10.h),

                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: [
                        _infoChip(
                          icon: Icons.currency_rupee_rounded,
                          text:
                          '${AppStrings.basePrice}: ${product.price}',
                          highlight: true,
                        ),
                        _infoChip(
                          icon: Icons.percent_rounded,
                          text:
                          '${AppStrings.tax}: ${product.taxPercentage}%',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}