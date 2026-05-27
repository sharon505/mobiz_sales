import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_strings.dart';
import '../../../utils/constants/app_text_styles.dart';
import '../../invoice/widgets/quantity_selector.dart';
import '../models/product_detail_model.dart';
import '../models/product_type_model.dart';
import 'product_type_dropdown.dart';

class ProductDetailCard extends StatelessWidget {
  final ProductDetailModel detail;
  final int quantity;
  final bool vatEnabled;
  final TextEditingController remarksController;
  final ProductTypeModel? selectedProductType;
  final List<ProductTypeModel> productTypes;
  final ValueChanged<ProductTypeModel?> onProductTypeChanged;
  final VoidCallback onIncrement;
  final VoidCallback? onDecrement;
  final ValueChanged<bool> onVatChanged;

  const ProductDetailCard({
    super.key,
    required this.detail,
    required this.quantity,
    required this.vatEnabled,
    required this.remarksController,
    required this.selectedProductType,
    required this.productTypes,
    required this.onProductTypeChanged,
    required this.onIncrement,
    required this.onDecrement,
    required this.onVatChanged,
  });

  Widget _miniInfo({
    required String label,
    required String value,
    bool highlight = false,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          color: highlight
              ? AppColors.primary.withOpacity(0.08)
              : Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: highlight
                ? AppColors.primary.withOpacity(0.15)
                : Colors.white.withOpacity(0.35),
          ),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 10.sp,
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              value,
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: highlight
                    ? AppColors.primary
                    : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final unitName = detail.units.isNotEmpty
        ? detail.units.first.name
        : AppStrings.unknown;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 8,
          sigmaY: 8,
        ),
        child: Container(
          margin: EdgeInsets.only(bottom: 12.h),
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
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  unitName,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 14.sp,
                  ),
                ),
              ),

              SizedBox(height: 12.h),

              Row(
                children: [
                  _miniInfo(
                    label: AppStrings.price,
                    value: '₹ ${detail.price}',
                    highlight: true,
                  ),
                  SizedBox(width: 8.w),
                  _miniInfo(
                    label: AppStrings.availableQty,
                    value: detail.qty.toString(),
                  ),
                  SizedBox(width: 8.w),
                  _miniInfo(
                    label: AppStrings.minimumPrice,
                    value:
                    detail.minimumPrice?.toString() ?? 'N/A',
                  ),
                ],
              ),

              SizedBox(height: 14.h),

              Row(
                children: [
                  Expanded(
                    child: ProductTypeDropdown(
                      selectedValue: selectedProductType,
                      productTypes: productTypes,
                      onChanged: onProductTypeChanged,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  SizedBox(
                    width: 115.w,
                    child: QuantitySelector(
                      quantity: quantity,
                      onIncrement: onIncrement,
                      onDecrement: onDecrement,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 14.h),

              TextField(
                controller: remarksController,
                style: AppTextStyles.bodySmall,
                decoration: InputDecoration(
                  hintText: AppStrings.remarks,
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.75),
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 12.h,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
              ),

              SizedBox(height: 12.h),

              Row(
                children: [
                  Text(
                    AppStrings.applyVat,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Switch(
                    value: vatEnabled,
                    activeColor: AppColors.primary,
                    onChanged: onVatChanged,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}