import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_strings.dart';
import '../../../utils/constants/app_text_styles.dart';
import '../models/product_type_model.dart';

class ProductTypeDropdown extends StatelessWidget {
  final ProductTypeModel? selectedValue;
  final List<ProductTypeModel> productTypes;
  final ValueChanged<ProductTypeModel?> onChanged;

  const ProductTypeDropdown({
    super.key,
    required this.selectedValue,
    required this.productTypes,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<ProductTypeModel>(
      value: selectedValue,
      isExpanded: true,
      icon: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: AppColors.primary,
        size: 24.sp,
      ),
      dropdownColor: Colors.white,
      style: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.textPrimary,
      ),
      decoration: InputDecoration(
        labelText: AppStrings.productType,
        labelStyle: AppTextStyles.bodySmall.copyWith(
          color: AppColors.textSecondary,
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.75),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(
            color: AppColors.inputBorder,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(
            color: AppColors.inputBorder,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(
            color: AppColors.primary,
            width: 1.4,
          ),
        ),
      ),
      items: productTypes.map((type) {
        return DropdownMenuItem<ProductTypeModel>(
          value: type,
          child: Text(
            type.name,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bodyMedium,
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}