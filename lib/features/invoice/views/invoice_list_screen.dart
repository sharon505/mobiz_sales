import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../controllers/invoice_list_controller.dart';
import '../viewmodels/InvoiceListViewModel.dart';
import '../widgets/invoice_card.dart';

class InvoiceListScreen extends StatefulWidget {
  const InvoiceListScreen({super.key});

  @override
  State<InvoiceListScreen> createState() => _InvoiceListScreenState();
}

class _InvoiceListScreenState extends State<InvoiceListScreen> {
  final InvoiceListController controller = InvoiceListController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchInvoices(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoice List'),
        centerTitle: true,
      ),
      body: Consumer<InvoiceListViewModel>(
        builder: (context, invoiceVM, child) {
          if (invoiceVM.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (invoiceVM.errorMessage.isNotEmpty) {
            return Center(
              child: Text(invoiceVM.errorMessage),
            );
          }

          if (invoiceVM.invoices.isEmpty) {
            return Center(
              child: Text(
                'No invoices found',
                style: TextStyle(fontSize: 16.sp),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => controller.fetchInvoices(context),
            child: ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: invoiceVM.invoices.length,
              itemBuilder: (context, index) {
                return InvoiceCard(
                  invoice: invoiceVM.invoices[index],
                );
              },
            ),
          );
        },
      ),
    );
  }
}