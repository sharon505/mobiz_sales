import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../auth/view_models/auth_view_model.dart';
import '../../auth/view_models/user_detail_view_model.dart';
import '../models/customer_model.dart';
import '../viewmodels/customer_view_model.dart';

class CustomerListScreen extends StatefulWidget {
  const CustomerListScreen({super.key});

  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  final TextEditingController searchController = TextEditingController();

  List<CustomerModel> filteredCustomers = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchCustomers();
    });
  }

  Future<void> fetchCustomers() async {
    final auth = Provider.of<AuthViewModel>(context, listen: false);

    final userVM = Provider.of<UserDetailViewModel>(
      context,
      listen: false,
    );

    final customerVM = Provider.of<CustomerViewModel>(
      context,
      listen: false,
    );

    if (userVM.currentUserDetail == null) {
      print("User detail is null");
      return;
    }

    await customerVM.getCustomers(
      token: auth.loginResponse!.authorisation.token,
      routeId: userVM.currentUserDetail!.routeId.toString(),
      storeId: auth.loginResponse!.user.storeId.toString(),
    );

    if (!mounted) return;

    setState(() {
      filteredCustomers = customerVM.customers;
    });
  }

  void filterCustomers(String query) {
    final customerVM = Provider.of<CustomerViewModel>(
      context,
      listen: false,
    );

    setState(() {
      if (query.isEmpty) {
        filteredCustomers = customerVM.customers;
      } else {
        filteredCustomers = customerVM.searchCustomers(query);
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Widget customerCard(CustomerModel customer) {
    return InkWell(
      borderRadius: BorderRadius.circular(16.r),
      onTap: () {
        Navigator.pushNamed(
          context,
          '/products',
          arguments: {
            'customer': customer,
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
                Icons.person,
                size: 24.sp,
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    customer.name,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    customer.contactNumber.isEmpty
                        ? 'No contact number'
                        : customer.contactNumber,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    customer.address ?? 'No address',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey.shade600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
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
        title: const Text('Customers'),
        centerTitle: true,
      ),
      body: Consumer<CustomerViewModel>(
        builder: (context, customerVM, child) {
          if (customerVM.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (customerVM.errorMessage.isNotEmpty) {
            return Center(
              child: Text(customerVM.errorMessage),
            );
          }

          if (filteredCustomers.isEmpty &&
              customerVM.customers.isNotEmpty) {
            filteredCustomers = customerVM.customers;
          }

          if (filteredCustomers.isEmpty) {
            return const Center(
              child: Text('No customers found'),
            );
          }

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.w),
                child: TextField(
                  controller: searchController,
                  onChanged: filterCustomers,
                  decoration: InputDecoration(
                    hintText: 'Search customer...',
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
                  itemCount: filteredCustomers.length,
                  separatorBuilder: (_, __) => SizedBox(height: 12.h),
                  itemBuilder: (context, index) {
                    return customerCard(filteredCustomers[index]);
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