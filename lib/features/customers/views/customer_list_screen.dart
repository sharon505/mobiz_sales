import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/customer_controller.dart';
import '../viewmodels/customer_view_model.dart';
import '../widgets/customer_card.dart';
import '../widgets/customer_search_field.dart';

class CustomerListScreen extends StatefulWidget {
  const CustomerListScreen({super.key});

  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  final CustomerController controller = CustomerController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.fetchCustomers(context);

      if (!mounted) return;

      setState(() {});
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

          if (controller.filteredCustomers.isEmpty &&
              customerVM.customers.isNotEmpty) {
            controller.filteredCustomers = customerVM.customers;
          }

          if (controller.filteredCustomers.isEmpty) {
            return const Center(
              child: Text('No customers found'),
            );
          }

          return Column(
            children: [
              CustomerSearchField(
                controller: controller.searchController,
                onChanged: (value) {
                  controller.filterCustomers(
                    context,
                    value,
                        () => setState(() {}),
                  );
                },
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: controller.filteredCustomers.length,
                  separatorBuilder: (_, __) =>
                  const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return CustomerCard(
                      customer: controller.filteredCustomers[index],
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