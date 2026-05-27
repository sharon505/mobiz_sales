import 'package:flutter/material.dart';

import '../models/invoice_list_model.dart';
import '../services/invoice_list_service.dart';

class InvoiceListViewModel extends ChangeNotifier {
  final InvoiceListService _invoiceListService = InvoiceListService();

  bool _isLoading = false;
  String _errorMessage = '';
  InvoiceListResponse? _invoiceResponse;

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  InvoiceListResponse? get invoiceResponse => _invoiceResponse;

  List<InvoiceModel> get invoices =>
      _invoiceResponse?.data.data ?? [];

  Future<void> fetchInvoices({
    required String token,
    required String userId,
    required String storeId,
    String vanId = "0",
  }) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final response = await _invoiceListService.getInvoices(
        token: token,
        userId: userId,
        storeId: storeId,
        vanId: vanId,
      );

      _invoiceResponse = response;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearInvoices() {
    _invoiceResponse = null;
    _errorMessage = '';
    notifyListeners();
  }
}