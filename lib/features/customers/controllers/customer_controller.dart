import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../auth/view_models/auth_view_model.dart';
import '../../auth/view_models/user_detail_view_model.dart';
import '../models/customer_model.dart';
import '../viewmodels/customer_view_model.dart';

class CustomerController {
  final TextEditingController searchController = TextEditingController();

  List<CustomerModel> filteredCustomers = [];

  Future<void> fetchCustomers(BuildContext context) async {
    final auth = Provider.of<AuthViewModel>(context, listen: false);

    final userVM = Provider.of<UserDetailViewModel>(
      context,
      listen: false,
    );

    final customerVM = Provider.of<CustomerViewModel>(
      context,
      listen: false,
    );

    if (userVM.currentUserDetail == null) {
      return;
    }

    await customerVM.getCustomers(
      token: auth.loginResponse!.authorisation.token,
      routeId: userVM.currentUserDetail!.routeId.toString(),
      storeId: auth.loginResponse!.user.storeId.toString(),
    );

    filteredCustomers = customerVM.customers;
  }

  void filterCustomers(
      BuildContext context,
      String query,
      VoidCallback refresh,
      ) {
    final customerVM = Provider.of<CustomerViewModel>(
      context,
      listen: false,
    );

    if (query.isEmpty) {
      filteredCustomers = customerVM.customers;
    } else {
      filteredCustomers = customerVM.searchCustomers(query);
    }

    refresh();
  }

  void dispose() {
    searchController.dispose();
  }
}