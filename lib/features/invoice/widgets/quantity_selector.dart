import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback? onDecrement;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onDecrement,
            child: const Text("-"),
          ),
        ),
        SizedBox(width: 12.w),
        Text(
          quantity.toString(),
          style: TextStyle(fontSize: 20.sp),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: ElevatedButton(
            onPressed: onIncrement,
            child: const Text("+"),
          ),
        ),
      ],
    );
  }
}