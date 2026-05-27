import 'package:flutter/material.dart';

import '../models/create_In_voice_request_model.dart';
import '../services/invoice_service.dart';

class InvoiceViewModel extends ChangeNotifier {
  final InvoiceService _invoiceService = InvoiceService();

  bool _isLoading = false;
  String _errorMessage = '';
  dynamic _invoiceResponse;

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  dynamic get invoiceResponse => _invoiceResponse;

  Future<bool> createInvoice({
    required String token,
    required CreateInvoiceRequestModel request,
  }) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final response = await _invoiceService.createVanSale(
        token: token,
        request: request,
      );

      _invoiceResponse = response;

      _isLoading = false;
      notifyListeners();

      return true;
    } catch (e) {
      _errorMessage = e.toString();

      _isLoading = false;
      notifyListeners();

      return false;
    }
  }

  void clearInvoice() {
    _invoiceResponse = null;
    _errorMessage = '';
    notifyListeners();
  }
}