import 'package:flutter/material.dart';

import '../models/product_type_model.dart';
import '../services/product_type_service.dart';

class ProductTypeViewModel extends ChangeNotifier {
  final ProductTypeService _productTypeService = ProductTypeService();

  bool _isLoading = false;
  String _errorMessage = '';
  ProductTypeResponse? _productTypeResponse;

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  ProductTypeResponse? get productTypeResponse => _productTypeResponse;

  List<ProductTypeModel> get productTypes =>
      _productTypeResponse?.data ?? [];

  Future<void> fetchProductTypes({
    required String token,
  }) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final response = await _productTypeService.getProductTypes(
        token: token,
      );

      _productTypeResponse = response;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  ProductTypeModel? getProductTypeById(int id) {
    try {
      return productTypes.firstWhere((type) => type.id == id);
    } catch (e) {
      return null;
    }
  }

  void clearProductTypes() {
    _productTypeResponse = null;
    _errorMessage = '';
    _isLoading = false;
    notifyListeners();
  }
}