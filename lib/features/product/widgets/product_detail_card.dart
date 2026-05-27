import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../invoice/widgets/quantity_selector.dart';
import '../models/product_detail_model.dart';
import '../models/product_type_model.dart';
import 'invoice_button.dart';
import 'product_type_dropdown.dart';

class ProductDetailCard extends StatelessWidget {
  final ProductDetailModel detail;
  final int quantity;
  final bool vatEnabled;
  final bool invoiceLoading;
  final TextEditingController remarksController;

  final ProductTypeModel? selectedProductType;
  final List<ProductTypeModel> productTypes;

  final ValueChanged<ProductTypeModel?> onProductTypeChanged;
  final VoidCallback onIncrement;
  final VoidCallback? onDecrement;
  final ValueChanged<bool> onVatChanged;
  final VoidCallback onCreateInvoice;

  const ProductDetailCard({
    super.key,
    required this.detail,
    required this.quantity,
    required this.vatEnabled,
    required this.invoiceLoading,
    required this.remarksController,
    required this.selectedProductType,
    required this.productTypes,
    required this.onProductTypeChanged,
    required this.onIncrement,
    required this.onDecrement,
    required this.onVatChanged,
    required this.onCreateInvoice,
  });

  @override
  Widget build(BuildContext context) {
    final unitName = detail.units.isNotEmpty
        ? detail.units.first.name
        : "Unknown";

    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.10),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            unitName,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 8.h),

          Text(
            "Price: ₹ ${detail.price}",
            style: TextStyle(
              fontSize: 14.sp,
            ),
          ),

          SizedBox(height: 4.h),

          Text(
            "Available Qty: ${detail.qty}",
            style: TextStyle(
              fontSize: 14.sp,
            ),
          ),

          SizedBox(height: 4.h),

          Text(
            "Minimum Price: ${detail.minimumPrice ?? 'N/A'}",
            style: TextStyle(
              fontSize: 14.sp,
            ),
          ),

          SizedBox(height: 16.h),

          ProductTypeDropdown(
            selectedValue: selectedProductType,
            productTypes: productTypes,
            onChanged: onProductTypeChanged,
          ),

          SizedBox(height: 16.h),

          QuantitySelector(
            quantity: quantity,
            onIncrement: onIncrement,
            onDecrement: onDecrement,
          ),

          SizedBox(height: 16.h),

          TextField(
            controller: remarksController,
            decoration: const InputDecoration(
              hintText: "Remarks",
              border: OutlineInputBorder(),
            ),
          ),

          SizedBox(height: 12.h),

          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text("Apply VAT"),
            value: vatEnabled,
            onChanged: onVatChanged,
          ),

          SizedBox(height: 12.h),

          InvoiceButton(
            isLoading: invoiceLoading,
            onPressed: onCreateInvoice,
          ),
        ],
      ),
    );
  }
}