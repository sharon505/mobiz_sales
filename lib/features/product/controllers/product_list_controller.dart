import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../auth/view_models/auth_view_model.dart';
import '../../customers/models/customer_model.dart';
import '../models/product_model.dart';
import '../viewmodels/product_view_model.dart';

class ProductListController {
  final TextEditingController searchController = TextEditingController();

  List<ProductModel> filteredProducts = [];
  CustomerModel? selectedCustomer;

  void initialize(BuildContext context, VoidCallback refresh) {
    final args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    selectedCustomer = args['customer'];
    refresh();
  }

  Future<void> fetchProducts(
      BuildContext context,
      VoidCallback refresh,
      ) async {
    final auth = Provider.of<AuthViewModel>(context, listen: false);

    final productVM = Provider.of<ProductViewModel>(
      context,
      listen: false,
    );

    await productVM.getProducts(
      token: auth.loginResponse!.authorisation.token,
      storeId: auth.loginResponse!.user.storeId.toString(),
    );

    filteredProducts = productVM.productData?.data.data ?? [];
    refresh();
  }

  void filterProducts(
      BuildContext context,
      String query,
      VoidCallback refresh,
      ) {
    final productVM = Provider.of<ProductViewModel>(
      context,
      listen: false,
    );

    filteredProducts = productVM.searchProducts(query);
    refresh();
  }

  void dispose() {
    searchController.dispose();
  }
}