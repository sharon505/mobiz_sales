import 'package:flutter/material.dart';

import '../models/customer_model.dart';
import '../services/customer_service.dart';

class CustomerViewModel extends ChangeNotifier {
  final CustomerService _customerService = CustomerService();

  bool _isLoading = false;
  String _errorMessage = '';
  CustomerResponseModel? _customerData;

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  CustomerResponseModel? get customerData => _customerData;

  List<CustomerModel> get customers => _customerData?.data ?? [];

  Future<void> getCustomers({
    required String token,
    required String routeId,
    required String storeId,
  }) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final response = await _customerService.getCustomers(
        token: token,
        routeId: routeId,
        storeId: storeId,
      );

      _customerData = response;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  List<CustomerModel> searchCustomers(String query) {
    if (customers.isEmpty) return [];

    if (query.isEmpty) {
      return customers;
    }

    return customers.where((customer) {
      return customer.name.toLowerCase().contains(query.toLowerCase()) ||
          customer.contactNumber.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  void clearCustomers() {
    _customerData = null;
    _errorMessage = '';
    _isLoading = false;
    notifyListeners();
  }
}