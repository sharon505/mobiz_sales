import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_text_styles.dart';
import '../../customers/models/customer_model.dart';
import '../models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final CustomerModel? customer;

  const ProductCard({
    super.key,
    required this.product,
    required this.customer,
  });

  @override
  Widget build(BuildContext context) {
    final firstUnit =
    product.units.isNotEmpty ? product.units.first : null;

    return InkWell(
      borderRadius: BorderRadius.circular(22.r),
      onTap: () {
        Navigator.pushNamed(
          context,
          '/invoice',
          arguments: {
            'customer': customer,
            'product': product,
          },
        );
        // Navigator.pushNamed(
        //   context,
        //   '/product-detail',
        //   arguments: {
        //     'customer': customer,
        //     'product': product,
        //   },
        // );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 10,
            sigmaY: 10,
          ),
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22.r),
              color: Colors.white.withOpacity(0.65),
              border: Border.all(
                color: Colors.white.withOpacity(0.35),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.08),
                  blurRadius: 18,
                  spreadRadius: 2,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 58.w,
                  height: 58.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.r),
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary,
                        AppColors.primaryDark,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.25),
                        blurRadius: 14,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.inventory_2_outlined,
                    color: Colors.white,
                    size: 28.sp,
                  ),
                ),

                SizedBox(width: 14.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      SizedBox(height: 10.h),

                      Wrap(
                        spacing: 8.w,
                        runSpacing: 8.h,
                        children: [
                          _infoChip(
                            icon: Icons.qr_code_rounded,
                            text: product.code ?? 'N/A',
                          ),

                          _infoChip(
                            icon: Icons.currency_rupee_rounded,
                            text: product.price.toString(),
                            highlight: true,
                          ),

                          if (firstUnit != null)
                            _infoChip(
                              icon: Icons.straighten_rounded,
                              text: firstUnit.name,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 12.w),

                Container(
                  width: 42.w,
                  height: 42.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.r),
                    color: Colors.white.withOpacity(0.4),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.35),
                    ),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16.sp,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoChip({
    required IconData icon,
    required String text,
    bool highlight = false,
  }) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: 160.w,
      ),
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
            size: 13.sp,
            color: highlight
                ? AppColors.primary
                : AppColors.textSecondary,
          ),
          SizedBox(width: 6.w),
          Flexible(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bodySmall.copyWith(
                color: highlight
                    ? AppColors.primary
                    : AppColors.textSecondary,
                fontWeight:
                highlight ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}