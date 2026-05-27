import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../auth/view_models/auth_view_model.dart';
import '../../customers/models/customer_model.dart';
import '../../product/models/product_model.dart';
import '../models/create_In_voice_request_model.dart';
import '../viewmodels/invoice_view_model.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({super.key});

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  final TextEditingController remarksController = TextEditingController();

  CustomerModel? customer;
  ProductModel? product;

  int quantity = 1;
  bool vatEnabled = true;
  double discount = 0;

  ProductUnit? selectedUnit;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args =
      ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      customer = args['customer'];
      product = args['product'];

      if (product != null && product!.units.isNotEmpty) {
        selectedUnit = product!.units.first;
      }

      setState(() {});
    });
  }

  double get unitPrice {
    if (product == null) return 0;

    if (selectedUnit == null) {
      return product!.price.toDouble();
    }

    return double.tryParse(selectedUnit!.price) ?? 0;
  }

  double get subtotal => unitPrice * quantity;

  double get tax =>
      product == null
          ? 0
          : vatEnabled
          ? (subtotal * product!.taxPercentage / 100)
          : 0;

  double get grandTotal => subtotal + tax - discount;

  Future<void> submitInvoice() async {
    if (customer == null || product == null) return;

    final auth = Provider.of<AuthViewModel>(context, listen: false);
    final invoiceVM = Provider.of<InvoiceViewModel>(context, listen: false);

    final request = CreateInvoiceRequestModel(
      customerId: customer!.id,
      storeId: auth.loginResponse!.user.storeId,
      userId: auth.loginResponse!.user.id,
      vanId: 0,
      saveMode: "normal",
      orderType: 1,
      discount: discount,
      total: subtotal,
      totalTax: tax,
      grandTotal: grandTotal,
      roundOff: 0,
      ifVat: vatEnabled ? 1 : 0,
      remarks: remarksController.text.trim(),
      itemIds: [product!.id],
      quantities: [quantity],
      mrp: [unitPrice],
      productTypes: [1],
      units: [selectedUnit?.unit ?? 0],
    );

    final success = await invoiceVM.createInvoice(
      token: auth.loginResponse!.authorisation.token,
      request: request,
    );

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invoice created successfully')),
      );

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(invoiceVM.errorMessage)),
      );
    }
  }

  @override
  void dispose() {
    remarksController.dispose();
    super.dispose();
  }

  Widget infoTile(String title, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (customer == null || product == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Invoice"),
        centerTitle: true,
      ),
      body: Consumer<InvoiceViewModel>(
        builder: (context, invoiceVM, child) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                infoTile("Customer", customer!.name),
                infoTile("Product", product!.name),

                DropdownButtonFormField<ProductUnit>(
                  value: selectedUnit,
                  decoration: const InputDecoration(
                    labelText: "Select Unit",
                    border: OutlineInputBorder(),
                  ),
                  items: product!.units.map((unit) {
                    return DropdownMenuItem(
                      value: unit,
                      child: Text("${unit.name} - ${unit.price}"),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedUnit = value;
                    });
                  },
                ),

                SizedBox(height: 16.h),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: quantity > 1
                            ? () {
                          setState(() {
                            quantity--;
                          });
                        }
                            : null,
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
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                        child: const Text("+"),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Discount",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      discount = double.tryParse(value) ?? 0;
                    });
                  },
                ),

                SizedBox(height: 16.h),

                SwitchListTile(
                  value: vatEnabled,
                  title: const Text("Apply VAT"),
                  onChanged: (value) {
                    setState(() {
                      vatEnabled = value;
                    });
                  },
                ),

                SizedBox(height: 16.h),

                TextField(
                  controller: remarksController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: "Remarks",
                    border: OutlineInputBorder(),
                  ),
                ),

                SizedBox(height: 20.h),

                infoTile("Subtotal", subtotal.toStringAsFixed(2)),
                infoTile("Tax", tax.toStringAsFixed(2)),
                infoTile("Grand Total", grandTotal.toStringAsFixed(2)),

                SizedBox(height: 24.h),

                SizedBox(
                  width: double.infinity,
                  height: 55.h,
                  child: ElevatedButton(
                    onPressed: invoiceVM.isLoading ? null : submitInvoice,
                    child: invoiceVM.isLoading
                        ? const CircularProgressIndicator()
                        : const Text("Submit Invoice"),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}