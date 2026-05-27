import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../auth/view_models/auth_view_model.dart';
import '../../customers/models/customer_model.dart';
import '../../invoice/models/create_In_voice_request_model.dart';
import '../../invoice/viewmodels/invoice_view_model.dart';
import '../models/product_detail_model.dart';
import '../models/product_model.dart';
import '../models/product_type_model.dart';
import '../viewmodels/product_detail_view_model.dart';
import '../viewmodels/product_type_view_model.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  ProductModel? product;
  CustomerModel? customer;

  final TextEditingController remarksController = TextEditingController();

  int quantity = 1;
  bool vatEnabled = true;
  double discount = 0;

  ProductTypeModel? selectedProductType;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args =
      ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      setState(() {
        customer = args['customer'];
        product = args['product'];
      });

      fetchData();
    });
  }

  Future<void> fetchData() async {
    final auth = Provider.of<AuthViewModel>(context, listen: false);

    final detailVM = Provider.of<ProductDetailViewModel>(
      context,
      listen: false,
    );

    final typeVM = Provider.of<ProductTypeViewModel>(
      context,
      listen: false,
    );

    await detailVM.fetchProductDetail(
      token: auth.loginResponse!.authorisation.token,
      productId: product!.id.toString(),
    );

    await typeVM.fetchProductTypes(
      token: auth.loginResponse!.authorisation.token,
    );

    if (typeVM.productTypes.isNotEmpty) {
      setState(() {
        selectedProductType = typeVM.productTypes.first;
      });
    }
  }

  Future<void> createInvoice(ProductDetailModel detail) async {
    final auth = Provider.of<AuthViewModel>(context, listen: false);

    final invoiceVM = Provider.of<InvoiceViewModel>(
      context,
      listen: false,
    );

    final price = double.tryParse(detail.price) ?? 0.0;

    final double subtotal = price * quantity;

    final double tax = vatEnabled
        ? (subtotal * product!.taxPercentage / 100).toDouble()
        : 0.0;

    final double grandTotal = subtotal + tax - discount;

    final request = CreateInvoiceRequestModel(
      customerId: customer!.id,
      storeId: auth.loginResponse!.user.storeId,
      userId: auth.loginResponse!.user.id,
      vanId: 0,
      saveMode: "normal",
      orderType: 1,
      discount: discount,
      total: subtotal,
      totalTax: tax,
      grandTotal: grandTotal,
      roundOff: 0,
      ifVat: vatEnabled ? 1 : 0,
      remarks: remarksController.text.trim(),
      itemIds: [product!.id],
      quantities: [quantity],
      mrp: [price],
      productTypes: [selectedProductType?.id ?? 1],
      units: [detail.unit],
    );

    final success = await invoiceVM.createInvoice(
      token: auth.loginResponse!.authorisation.token,
      request: request,
    );

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invoice created successfully'),
        ),
      );

      Navigator.pushNamedAndRemoveUntil(
        context,
        '/invoice-list',
            (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(invoiceVM.errorMessage),
        ),
      );
    }
  }

  @override
  void dispose() {
    remarksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (product == null || customer == null) {
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
      body: Consumer3<ProductDetailViewModel, ProductTypeViewModel,
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
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(16.w),
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.12),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 35.r,
                      child: Icon(
                        Icons.inventory_2_outlined,
                        size: 30.sp,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      product!.name,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Base Price: ₹ ${product!.price}",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "Tax: ${product!.taxPercentage}%",
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: detailVM.productDetails.length,
                  itemBuilder: (context, index) {
                    final detail = detailVM.productDetails[index];

                    final unitName = detail.units.isNotEmpty
                        ? detail.units.first.name
                        : "Unknown";

                    return Container(
                      margin: EdgeInsets.only(bottom: 14.h),
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.10),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            unitName,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text("Price: ₹ ${detail.price}"),
                          SizedBox(height: 4.h),
                          Text("Available Qty: ${detail.qty}"),
                          SizedBox(height: 4.h),
                          Text(
                            "Minimum Price: ${detail.minimumPrice ?? 'N/A'}",
                          ),

                          SizedBox(height: 16.h),

                          DropdownButtonFormField<ProductTypeModel>(
                            value: selectedProductType,
                            decoration: const InputDecoration(
                              labelText: "Product Type",
                              border: OutlineInputBorder(),
                            ),
                            items: typeVM.productTypes.map((type) {
                              return DropdownMenuItem(
                                value: type,
                                child: Text(type.name),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedProductType = value;
                              });
                            },
                          ),

                          SizedBox(height: 16.h),

                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: quantity > 1
                                      ? () {
                                    setState(() {
                                      quantity--;
                                    });
                                  }
                                      : null,
                                  child: const Text("-"),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                quantity.toString(),
                                style: TextStyle(fontSize: 18.sp),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      quantity++;
                                    });
                                  },
                                  child: const Text("+"),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 16.h),

                          TextField(
                            controller: remarksController,
                            decoration: const InputDecoration(
                              hintText: "Remarks",
                              border: OutlineInputBorder(),
                            ),
                          ),

                          SizedBox(height: 12.h),

                          SwitchListTile(
                            contentPadding: EdgeInsets.zero,
                            title: const Text("Apply VAT"),
                            value: vatEnabled,
                            onChanged: (value) {
                              setState(() {
                                vatEnabled = value;
                              });
                            },
                          ),

                          SizedBox(height: 12.h),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: invoiceVM.isLoading
                                  ? null
                                  : () => createInvoice(detail),
                              child: invoiceVM.isLoading
                                  ? const CircularProgressIndicator()
                                  : const Text("Create Invoice"),
                            ),
                          ),
                        ],
                      ),
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