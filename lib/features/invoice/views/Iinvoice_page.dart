import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../auth/view_models/auth_view_model.dart';
import '../../customers/models/customer_model.dart';
import '../../product/models/product_model.dart';
import '../controllers/invoice_controller.dart';
import '../models/create_In_voice_request_model.dart';
import '../viewmodels/invoice_view_model.dart';
import '../widgets/info_tile.dart';
import '../widgets/quantity_selector.dart';
import '../widgets/submit_invoice_button.dart';
import '../widgets/unit_dropdown.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({super.key});

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

// keep your imports

class _InvoicePageState extends State<InvoicePage> {
  final InvoiceController controller = InvoiceController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initialize(
        context,
            () => setState(() {}),
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller.customer == null || controller.product == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Invoice"),
      ),
      body: Consumer<InvoiceViewModel>(
        builder: (context, invoiceVM, child) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                InfoTile(
                  title: "Customer",
                  value: controller.customer!.name,
                ),
                InfoTile(
                  title: "Product",
                  value: controller.product!.name,
                ),

                UnitDropdown(
                  selectedUnit: controller.selectedUnit,
                  units: controller.product!.units,
                  onChanged: (value) {
                    setState(() {
                      controller.selectedUnit = value;
                    });
                  },
                ),

                SizedBox(height: 16.h),

                QuantitySelector(
                  quantity: controller.quantity,
                  onIncrement: () {
                    setState(() {
                      controller.quantity++;
                    });
                  },
                  onDecrement: controller.quantity > 1
                      ? () {
                    setState(() {
                      controller.quantity--;
                    });
                  }
                      : null,
                ),

                SubmitInvoiceButton(
                  isLoading: invoiceVM.isLoading,
                  onPressed: () {
                    controller.submitInvoice(context);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}