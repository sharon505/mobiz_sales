import 'package:flutter/material.dart';

class InvoiceButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const InvoiceButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const CircularProgressIndicator()
            : const Text("Create Invoice"),
      ),
    );
  }
}