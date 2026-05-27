import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_strings.dart';
import '../../../utils/constants/app_text_styles.dart';
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

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.primary,
      ),
    );
  }

  Widget _buildMessage(
      String message, {
        IconData? icon,
        Color? color,
      }) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon ?? Icons.info_outline_rounded,
              size: 48.sp,
              color: color ?? AppColors.textSecondary,
            ),

            SizedBox(height: 16.h),

            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(
                color: color ?? AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.transparent,
        leading: Center(
          child: InkWell(
            borderRadius: BorderRadius.circular(12.r),
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 38.w,
              height: 38.h,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary,
                AppColors.primaryDark,
              ],
            ),
          ),
        ),
        title: Text(
          AppStrings.invoiceList,
          style: AppTextStyles.title.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primary.withOpacity(0.04),
              AppColors.scaffoldBackground,
              Colors.white,
            ],
          ),
        ),
        child: Consumer<InvoiceListViewModel>(
          builder: (context, invoiceVM, child) {
            if (invoiceVM.isLoading) {
              return _buildLoading();
            }

            if (invoiceVM.errorMessage.isNotEmpty) {
              return _buildMessage(
                invoiceVM.errorMessage,
                icon: Icons.error_outline_rounded,
                color: AppColors.error,
              );
            }

            if (invoiceVM.invoices.isEmpty) {
              return _buildMessage(
                AppStrings.noInvoicesFound,
                icon: Icons.receipt_long_outlined,
              );
            }

            return RefreshIndicator(
              color: AppColors.primary,
              backgroundColor: Colors.white,
              onRefresh: () => controller.fetchInvoices(context),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
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
      ),
    );
  }
}