import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_strings.dart';
import '../../../utils/constants/app_text_styles.dart';
import '../controllers/invoice_controller.dart';
import '../viewmodels/invoice_view_model.dart';
import '../widgets/info_tile.dart';
import '../widgets/quantity_selector.dart';
import '../widgets/submit_invoice_button.dart';
import '../widgets/unit_dropdown.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({super.key});

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  final InvoiceController controller = InvoiceController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initialize(
        context,
            () => setState(() {}),
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.primary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (controller.customer == null || controller.product == null) {
      return Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        body: _buildLoading(),
      );
    }

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
          AppStrings.createInvoice,
          style: AppTextStyles.title.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<InvoiceViewModel>(
        builder: (context, invoiceVM, child) {
          return Container(
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
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  InfoTile(
                    title: AppStrings.customer,
                    value: controller.customer!.name,
                    icon: Icons.person_outline_rounded,
                  ),

                  InfoTile(
                    title: AppStrings.product,
                    value: controller.product!.name,
                    icon: Icons.inventory_2_outlined,
                    highlight: true,
                  ),

                  SizedBox(height: 10.h),

                  UnitDropdown(
                    selectedUnit: controller.selectedUnit,
                    units: controller.product!.units,
                    onChanged: (value) {
                      setState(() {
                        controller.selectedUnit = value;
                      });
                    },
                  ),

                  SizedBox(height: 16.h),

                  QuantitySelector(
                    quantity: controller.quantity,
                    onIncrement: () {
                      setState(() {
                        controller.quantity++;
                      });
                    },
                    onDecrement: controller.quantity > 1
                        ? () {
                      setState(() {
                        controller.quantity--;
                      });
                    }
                        : null,
                  ),

                  SizedBox(height: 24.h),

                  SubmitInvoiceButton(
                    isLoading: invoiceVM.isLoading,
                    onPressed: () {
                      controller.submitInvoice(context);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}