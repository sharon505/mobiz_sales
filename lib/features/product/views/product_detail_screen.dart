import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

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
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller.product == null || controller.customer == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Detail"),
        centerTitle: true,
      ),
      body: Consumer3<
          ProductDetailViewModel,
          ProductTypeViewModel,
          InvoiceViewModel>(
        builder: (context, detailVM, typeVM, invoiceVM, child) {
          if (detailVM.isLoading || typeVM.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (detailVM.errorMessage.isNotEmpty) {
            return Center(
              child: Text(detailVM.errorMessage),
            );
          }

          if (typeVM.errorMessage.isNotEmpty) {
            return Center(
              child: Text(typeVM.errorMessage),
            );
          }

          if (detailVM.productDetails.isEmpty) {
            return const Center(
              child: Text("No product details found"),
            );
          }

          return Column(
            children: [
              ProductHeaderCard(
                product: controller.product!,
              ),

              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: detailVM.productDetails.length,
                  itemBuilder: (context, index) {
                    final detail = detailVM.productDetails[index];

                    return ProductDetailCard(
                      detail: detail,
                      quantity: controller.quantity,
                      vatEnabled: controller.vatEnabled,
                      remarksController:
                      controller.remarksController,
                      selectedProductType:
                      controller.selectedProductType,
                      productTypes: typeVM.productTypes,
                      invoiceLoading: invoiceVM.isLoading,

                      onProductTypeChanged: (value) {
                        setState(() {
                          controller.selectedProductType = value;
                        });
                      },

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

                      onVatChanged: (value) {
                        setState(() {
                          controller.vatEnabled = value;
                        });
                      },

                      onCreateInvoice: () {
                        controller.createInvoice(
                          context,
                          detail,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}