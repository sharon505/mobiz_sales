import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../auth/view_models/auth_view_model.dart';
import '../../auth/view_models/user_detail_view_model.dart';
import '../viewmodels/InvoiceListViewModel.dart';

class InvoiceListController {
  Future<void> fetchInvoices(BuildContext context) async {
    final auth = Provider.of<AuthViewModel>(context, listen: false);

    final invoiceVM = Provider.of<InvoiceListViewModel>(
      context,
      listen: false,
    );

    final userVM = Provider.of<UserDetailViewModel>(
      context,
      listen: false,
    );

    await invoiceVM.fetchInvoices(
      token: auth.loginResponse!.authorisation.token,
      userId: auth.loginResponse!.user.id.toString(),
      storeId: auth.loginResponse!.user.storeId.toString(),
      vanId: userVM.currentUserDetail!.vanId.toString(),
    );
  }
}