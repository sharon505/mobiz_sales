import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_strings.dart';
import '../../../utils/constants/app_text_styles.dart';
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
          AppStrings.products,
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
        child: Consumer<ProductViewModel>(
          builder: (context, productVM, child) {
            if (productVM.isLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              );
            }

            if (productVM.errorMessage.isNotEmpty) {
              return Center(
                child: Text(
                  productVM.errorMessage,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.error,
                  ),
                ),
              );
            }

            if (controller.filteredProducts.isEmpty) {
              return Center(
                child: Text(
                  AppStrings.noProductsFound,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
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

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Product Catalog',
                        style: AppTextStyles.title.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          '${controller.filteredProducts.length} Products',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16.h),

                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
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
      ),
    );
  }
}