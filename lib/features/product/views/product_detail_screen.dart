import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_strings.dart';
import '../../../utils/constants/app_text_styles.dart';
import '../../invoice/viewmodels/invoice_view_model.dart';
import '../controllers/product_detail_controller.dart';
import '../viewmodels/product_detail_view_model.dart';
import '../viewmodels/product_type_view_model.dart';
import '../widgets/invoice_button.dart';
import '../widgets/product_detail_card.dart';
import '../widgets/product_header_card.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ProductDetailController controller = ProductDetailController();

  final PageController _pageController = PageController(
    viewportFraction: 0.92,
  );

  int currentPage = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      controller.initialize(
        context,
            () => setState(() {}),
      );

      await controller.fetchData(
        context,
            () => setState(() {}),
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
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

  Widget _buildMessage(String message, {Color? color}) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyMedium.copyWith(
            color: color ?? AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (controller.product == null || controller.customer == null) {
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
          AppStrings.productDetail,
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
        child: Consumer3<
            ProductDetailViewModel,
            ProductTypeViewModel,
            InvoiceViewModel>(
          builder: (context, detailVM, typeVM, invoiceVM, child) {
            if (detailVM.isLoading || typeVM.isLoading) {
              return _buildLoading();
            }

            if (detailVM.errorMessage.isNotEmpty) {
              return _buildMessage(
                detailVM.errorMessage,
                color: AppColors.error,
              );
            }

            if (typeVM.errorMessage.isNotEmpty) {
              return _buildMessage(
                typeVM.errorMessage,
                color: AppColors.error,
              );
            }

            if (detailVM.productDetails.isEmpty) {
              return _buildMessage(
                AppStrings.noProductDetailsFound,
              );
            }

            return Column(
              children: [
                ProductHeaderCard(
                  product: controller.product!,
                ),

                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: PageView.builder(
                          controller: _pageController,
                          physics: const BouncingScrollPhysics(),
                          itemCount: detailVM.productDetails.length,
                          onPageChanged: (index) {
                            setState(() {
                              currentPage = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            final detail =
                            detailVM.productDetails[index];

                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 6.w,
                              ),
                              child: ProductDetailCard(
                                detail: detail,
                                quantity:
                                controller.quantities[index] ??
                                    1,
                                vatEnabled:
                                controller.vatEnabledMap[
                                index] ??
                                    true,
                                remarksController:
                                controller.remarksControllers[
                                index]!,
                                selectedProductType:
                                controller
                                    .selectedProductTypes[
                                index],
                                productTypes: typeVM.productTypes,
                                onProductTypeChanged: (value) {
                                  setState(() {
                                    controller.selectedProductTypes[
                                    index] = value;
                                  });
                                },
                                onIncrement: () {
                                  setState(() {
                                    controller.quantities[index] =
                                        (controller
                                            .quantities[
                                        index] ??
                                            1) +
                                            1;
                                  });
                                },
                                onDecrement:
                                (controller.quantities[index] ??
                                    1) >
                                    1
                                    ? () {
                                  setState(() {
                                    controller.quantities[
                                    index] = (controller
                                        .quantities[
                                    index] ??
                                        1) -
                                        1;
                                  });
                                }
                                    : null,
                                onVatChanged: (value) {
                                  setState(() {
                                    controller.vatEnabledMap[
                                    index] = value;
                                  });
                                },
                              ),
                            );
                          },
                        ),
                      ),

                      SizedBox(height: 14.h),

                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: List.generate(
                          detailVM.productDetails.length,
                              (index) {
                            final isActive =
                                currentPage == index;

                            return AnimatedContainer(
                              duration: const Duration(
                                milliseconds: 250,
                              ),
                              margin: EdgeInsets.symmetric(
                                horizontal: 4.w,
                              ),
                              width: isActive ? 22.w : 8.w,
                              height: 8.h,
                              decoration: BoxDecoration(
                                color: isActive
                                    ? AppColors.primary
                                    : AppColors.primary
                                    .withOpacity(0.2),
                                borderRadius:
                                BorderRadius.circular(
                                  20.r,
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      SizedBox(height: 20.h),

                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                        ),
                        child: InvoiceButton(
                          isLoading: invoiceVM.isLoading,
                          onPressed: () {
                            controller.createInvoice(
                              context,
                              detailVM.productDetails[
                              currentPage],
                              currentPage,
                            );
                          },
                        ),
                      ),

                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}