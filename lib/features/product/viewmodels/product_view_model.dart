import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../services/product_service.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductService _productService = ProductService();

  bool _isLoading = false;
  String _errorMessage = '';
  ProductResponseModel? _productData;

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  ProductResponseModel? get productData => _productData;

  Future<void> getProducts({
    required String token,
    required String storeId,
  }) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final response = await _productService.getProducts(
        token: token,
        storeId: storeId,
      );

      _productData = response;

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();

      _isLoading = false;
      notifyListeners();
    }
  }

  List<ProductModel> searchProducts(String query) {
    if (_productData == null) return [];

    final products = _productData!.data.data;

    if (query.isEmpty) {
      return products;
    }

    return products.where((product) {
      return product.name.toLowerCase().contains(query.toLowerCase()) ||
          (product.code?.toString().toLowerCase().contains(
            query.toLowerCase(),
          ) ??
              false);
    }).toList();
  }

  void clearProducts() {
    _productData = null;
    _errorMessage = '';
    notifyListeners();
  }
}