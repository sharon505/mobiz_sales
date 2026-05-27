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

  final Map<int, TextEditingController> remarksControllers = {};
  final Map<int, int> quantities = {};
  final Map<int, bool> vatEnabledMap = {};
  final Map<int, ProductTypeModel?> selectedProductTypes = {};

  void initialize(BuildContext context, VoidCallback refresh) {
    final args =
    ModalRoute.of(context)!.settings.arguments
    as Map<String, dynamic>;

    customer = args['customer'];
    product = args['product'];

    refresh();
  }

  Future<void> fetchData(
      BuildContext context,
      VoidCallback refresh,
      ) async {
    final auth = Provider.of<AuthViewModel>(
      context,
      listen: false,
    );

    final detailVM = Provider.of<ProductDetailViewModel>(
      context,
      listen: false,
    );

    final typeVM = Provider.of<ProductTypeViewModel>(
      context,
      listen: false,
    );

    await detailVM.fetchProductDetail(
      token: auth.loginResponse!.authorisation.token,
      productId: product!.id.toString(),
    );

    await typeVM.fetchProductTypes(
      token: auth.loginResponse!.authorisation.token,
    );

    for (int i = 0; i < detailVM.productDetails.length; i++) {
      quantities[i] = 1;
      vatEnabledMap[i] = true;
      remarksControllers[i] = TextEditingController();

      if (typeVM.productTypes.isNotEmpty) {
        selectedProductTypes[i] = typeVM.productTypes.first;
      }
    }

    refresh();
  }

  Future<void> createInvoice(
      BuildContext context,
      ProductDetailModel detail,
      int index,
      ) async {
    final auth = Provider.of<AuthViewModel>(
      context,
      listen: false,
    );

    final invoiceVM = Provider.of<InvoiceViewModel>(
      context,
      listen: false,
    );

    final quantity = quantities[index] ?? 1;
    final vatEnabled = vatEnabledMap[index] ?? true;
    final remarks =
        remarksControllers[index]?.text.trim() ?? '';
    final selectedType = selectedProductTypes[index];

    final price = double.tryParse(detail.price) ?? 0.0;
    final subtotal = price * quantity;

    final tax = vatEnabled
        ? (subtotal * product!.taxPercentage / 100)
        : 0.0;

    final grandTotal = subtotal + tax;

    final request = CreateInvoiceRequestModel(
      customerId: customer!.id,
      storeId: auth.loginResponse!.user.storeId,
      userId: auth.loginResponse!.user.id,
      vanId: 0,
      saveMode: "normal",
      orderType: 1,
      discount: 0,
      total: subtotal,
      totalTax: tax,
      grandTotal: grandTotal,
      roundOff: 0,
      ifVat: vatEnabled ? 1 : 0,
      remarks: remarks,
      itemIds: [product!.id],
      quantities: [quantity],
      mrp: [price],
      productTypes: [selectedType?.id ?? 1],
      units: [detail.unit],
    );

    final success = await invoiceVM.createInvoice(
      token: auth.loginResponse!.authorisation.token,
      request: request,
    );

    if (!context.mounted) return;

    if (success) {
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            contentPadding: const EdgeInsets.all(24),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle_rounded,
                    color: Colors.green,
                    size: 42,
                  ),
                ),

                const SizedBox(height: 18),

                const Text(
                  'Invoice Created!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Your invoice has been created successfully.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                      ),
                    ),
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );

      if (!context.mounted) return;

      Navigator.pop(context);
    }
  }

  void dispose() {
    for (final controller in remarksControllers.values) {
      controller.dispose();
    }
  }
}