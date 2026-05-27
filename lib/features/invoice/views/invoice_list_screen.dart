import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../auth/view_models/auth_view_model.dart';
import '../../auth/view_models/user_detail_view_model.dart';
import '../models/invoice_list_model.dart';
import '../viewmodels/InvoiceListViewModel.dart';

class InvoiceListScreen extends StatefulWidget {
  const InvoiceListScreen({super.key});

  @override
  State<InvoiceListScreen> createState() => _InvoiceListScreenState();
}

class _InvoiceListScreenState extends State<InvoiceListScreen> {
  @override
  void initState() {
    super.initState();
    fetchInvoices();
  }

  Future<void> fetchInvoices() async {
    final auth = Provider.of<AuthViewModel>(context, listen: false);
    final invoiceVM =
    Provider.of<InvoiceListViewModel>(context, listen: false);

    final userVM =
    Provider.of<UserDetailViewModel>(context, listen: false);

    await invoiceVM.fetchInvoices(
      token: auth.loginResponse!.authorisation.token,
      userId: auth.loginResponse!.user.id.toString(),
      storeId: auth.loginResponse!.user.storeId.toString(),
      vanId: userVM.currentUserDetail!.vanId.toString(),
    );
  }

  Widget invoiceCard(InvoiceModel invoice) {
    final customerName = invoice.customer.isNotEmpty
        ? invoice.customer.first.name
        : 'Unknown Customer';

    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.12),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22.r,
                child: Icon(
                  Icons.receipt_long,
                  size: 22.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customerName,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      invoice.invoiceNo,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "₹ ${invoice.grandTotal.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),

          SizedBox(height: 14.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              infoText("Date", invoice.inDate),
              infoText("Tax", "₹ ${invoice.totalTax}"),
            ],
          ),

          SizedBox(height: 10.h),

          if (invoice.remarks != null &&
              invoice.remarks!.isNotEmpty)
            Text(
              "Remarks: ${invoice.remarks}",
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey.shade700,
              ),
            ),
        ],
      ),
    );
  }

  Widget infoText(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 11.sp,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
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
            onRefresh: fetchInvoices,
            child: ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: invoiceVM.invoices.length,
              itemBuilder: (context, index) {
                return invoiceCard(invoiceVM.invoices[index]);
              },
            ),
          );
        },
      ),
    );
  }
}