import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/invoice_list_model.dart';
import 'invoice_info_text.dart';

class InvoiceCard extends StatelessWidget {
  final InvoiceModel invoice;

  const InvoiceCard({
    super.key,
    required this.invoice,
  });

  @override
  Widget build(BuildContext context) {
    final customerName = invoice.customer.isNotEmpty
        ? invoice.customer.first.name
        : 'Unknown Customer';

    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.12),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22.r,
                child: Icon(
                  Icons.receipt_long,
                  size: 22.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customerName,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      invoice.invoiceNo,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "₹ ${invoice.grandTotal.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),

          SizedBox(height: 14.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InvoiceInfoText(
                title: "Date",
                value: invoice.inDate,
              ),
              InvoiceInfoText(
                title: "Tax",
                value: "₹ ${invoice.totalTax}",
              ),
            ],
          ),

          SizedBox(height: 10.h),

          if (invoice.remarks != null &&
              invoice.remarks!.isNotEmpty)
            Text(
              "Remarks: ${invoice.remarks}",
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey.shade700,
              ),
            ),
        ],
      ),
    );
  }
}