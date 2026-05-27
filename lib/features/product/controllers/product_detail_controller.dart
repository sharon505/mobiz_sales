import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../auth/view_models/auth_view_model.dart';
import '../../customers/models/customer_model.dart';
import '../../invoice/models/create_In_voice_request_model.dart';
import '../../invoice/viewmodels/invoice_view_model.dart';
import '../models/product_detail_model.dart';
import '../models/product_model.dart';
import '../models/product_type_model.dart';
import '../viewmodels/product_detail_view_model.dart';
import '../viewmodels/product_type_view_model.dart';

class ProductDetailController {
  ProductModel? product;
  CustomerModel? customer;

  final TextEditingController remarksController = TextEditingController();

  int quantity = 1;
  bool vatEnabled = true;
  double discount = 0;

  ProductTypeModel? selectedProductType;

  void initialize(BuildContext context, VoidCallback refresh) {
    final args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    customer = args['customer'];
    product = args['product'];

    refresh();
  }

  Future<void> fetchData(
      BuildContext context,
      VoidCallback refresh,
      ) async {
    final auth = Provider.of<AuthViewModel>(context, listen: false);

    final detailVM =
    Provider.of<ProductDetailViewModel>(context, listen: false);

    final typeVM =
    Provider.of<ProductTypeViewModel>(context, listen: false);

    await detailVM.fetchProductDetail(
      token: auth.loginResponse!.authorisation.token,
      productId: product!.id.toString(),
    );

    await typeVM.fetchProductTypes(
      token: auth.loginResponse!.authorisation.token,
    );

    if (typeVM.productTypes.isNotEmpty) {
      selectedProductType = typeVM.productTypes.first;
      refresh();
    }
  }

  Future<void> createInvoice(
      BuildContext context,
      ProductDetailModel detail,
      ) async {
    final auth = Provider.of<AuthViewModel>(context, listen: false);

    final invoiceVM =
    Provider.of<InvoiceViewModel>(context, listen: false);

    final price = double.tryParse(detail.price) ?? 0.0;
    final subtotal = price * quantity;

    final tax = vatEnabled
        ? (subtotal * product!.taxPercentage / 100)
        : 0.0;

    final grandTotal = subtotal + tax - discount;

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
      mrp: [price],
      productTypes: [selectedProductType?.id ?? 1],
      units: [detail.unit],
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

      Navigator.pushNamedAndRemoveUntil(
        context,
        '/invoice-list',
            (route) => false,
      );
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