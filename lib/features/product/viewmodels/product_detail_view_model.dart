import 'package:flutter/material.dart';

import '../models/product_detail_model.dart';
import '../services/product_detail_service.dart';

class ProductDetailViewModel extends ChangeNotifier {
  final ProductDetailService _productDetailService = ProductDetailService();

  bool _isLoading = false;
  String _errorMessage = '';
  ProductDetailResponse? _productDetailResponse;

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  ProductDetailResponse? get productDetailResponse => _productDetailResponse;

  List<ProductDetailModel> get productDetails =>
      _productDetailResponse?.data ?? [];

  Future<void> fetchProductDetail({
    required String token,
    required String productId,
  }) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final response = await _productDetailService.getProductDetail(
        token: token,
        productId: productId,
      );

      _productDetailResponse = response;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearProductDetails() {
    _productDetailResponse = null;
    _errorMessage = '';
    notifyListeners();
  }
}