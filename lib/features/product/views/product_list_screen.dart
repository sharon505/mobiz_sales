import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../auth/view_models/auth_view_model.dart';
import '../../customers/models/customer_model.dart';
import '../models/product_model.dart';
import '../viewmodels/product_view_model.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final TextEditingController searchController = TextEditingController();

  List<ProductModel> filteredProducts = [];
  CustomerModel? selectedCustomer;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args =
      ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      selectedCustomer = args['customer'];

      fetchProducts();
    });
  }

  Future<void> fetchProducts() async {
    final auth = Provider.of<AuthViewModel>(context, listen: false);
    final productVM = Provider.of<ProductViewModel>(context, listen: false);

    await productVM.getProducts(
      token: auth.loginResponse!.authorisation.token,
      storeId: auth.loginResponse!.user.storeId.toString(),
    );

    if (!mounted) return;

    setState(() {
      filteredProducts = productVM.productData?.data.data ?? [];
    });
  }

  void filterProducts(String query) {
    final productVM = Provider.of<ProductViewModel>(
      context,
      listen: false,
    );

    setState(() {
      filteredProducts = productVM.searchProducts(query);
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Widget productCard(ProductModel product) {
    final firstUnit =
    product.units.isNotEmpty ? product.units.first : null;

    return InkWell(
      borderRadius: BorderRadius.circular(16.r),
      onTap: () {
        Navigator.pushNamed(
          context,
          '/product-detail',
          arguments: {
            'customer': selectedCustomer,
            'product': product,
          },
        );
      },
      child: Container(
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
        child: Row(
          children: [
            CircleAvatar(
              radius: 26.r,
              child: Icon(
                Icons.inventory_2_outlined,
                size: 24.sp,
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    "Code: ${product.code ?? 'N/A'}",
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "Price: ₹ ${product.price}",
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (firstUnit != null) ...[
                    SizedBox(height: 4.h),
                    Text(
                      "Unit: ${firstUnit.name}",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 18.sp,
            ),
          ],
        ),
      ),
    );
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

          if (filteredProducts.isEmpty) {
            return const Center(
              child: Text('No products found'),
            );
          }

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.w),
                child: TextField(
                  controller: searchController,
                  onChanged: filterProducts,
                  decoration: InputDecoration(
                    hintText: 'Search products...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: filteredProducts.length,
                  separatorBuilder: (_, __) => SizedBox(height: 12.h),
                  itemBuilder: (context, index) {
                    return productCard(filteredProducts[index]);
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