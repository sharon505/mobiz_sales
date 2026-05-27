import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/product_model.dart';

class ProductHeaderCard extends StatelessWidget {
  final ProductModel product;

  const ProductHeaderCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 35.r,
            child: Icon(
              Icons.inventory_2_outlined,
              size: 30.sp,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            product.name,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "Base Price: ₹ ${product.price}",
          ),
          Text(
            "Tax: ${product.taxPercentage}%",
          ),
        ],
      ),
    );
  }
}