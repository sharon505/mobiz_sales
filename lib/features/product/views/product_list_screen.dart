import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../controllers/product_list_controller.dart';
import '../viewmodels/product_view_model.dart';
import '../widgets/product_card.dart';
import '../widgets/product_search_field.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ProductListController controller = ProductListController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      controller.initialize(
        context,
            () => setState(() {}),
      );

      await controller.fetchProducts(
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        centerTitle: true,
      ),
      body: Consumer<ProductViewModel>(
        builder: (context, productVM, child) {
          if (productVM.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (productVM.errorMessage.isNotEmpty) {
            return Center(
              child: Text(productVM.errorMessage),
            );
          }

          if (controller.filteredProducts.isEmpty) {
            return const Center(
              child: Text('No products found'),
            );
          }

          return Column(
            children: [
              ProductSearchField(
                controller: controller.searchController,
                onChanged: (value) {
                  controller.filterProducts(
                    context,
                    value,
                        () => setState(() {}),
                  );
                },
              ),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: controller.filteredProducts.length,
                  separatorBuilder: (_, __) =>
                      SizedBox(height: 12.h),
                  itemBuilder: (context, index) {
                    return ProductCard(
                      product: controller.filteredProducts[index],
                      customer: controller.selectedCustomer,
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