import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../auth/view_models/auth_view_model.dart';
import '../../customers/models/customer_model.dart';
import '../../product/models/product_model.dart';
import '../models/create_In_voice_request_model.dart';
import '../viewmodels/invoice_view_model.dart';

class InvoiceController {
  final TextEditingController remarksController = TextEditingController();

  CustomerModel? customer;
  ProductModel? product;
  ProductUnit? selectedUnit;

  int quantity = 1;
  bool vatEnabled = true;
  double discount = 0;

  void initialize(BuildContext context, VoidCallback refresh) {
    final args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    customer = args['customer'];
    product = args['product'];

    if (product != null && product!.units.isNotEmpty) {
      selectedUnit = product!.units.first;
    }

    refresh();
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

  Future<void> submitInvoice(BuildContext context) async {
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

    if (!context.mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invoice created successfully'),
        ),
      );

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(invoiceVM.errorMessage),
        ),
      );
    }
  }

  void dispose() {
    remarksController.dispose();
  }
}