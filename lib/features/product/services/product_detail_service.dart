import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../network/api_end_points.dart';
import '../models/product_detail_model.dart';

class ProductDetailService {
  Future<ProductDetailResponse> getProductDetail({
    required String token,
    required String productId,
  }) async {
    try {
      final uri = ApiEndpoints.getProductDetail().replace(
        queryParameters: {
          'product_id': productId,
        },
      );

      print("========== PRODUCT DETAIL API ==========");
      print("Request URL: $uri");
      print("Product ID: $productId");

      final response = await http.get(
        uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("=======================================");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return ProductDetailResponse.fromJson(jsonData);
      } else {
        throw Exception(
          'Failed to fetch product details. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      print("Product Detail Error: $e");
      throw Exception(e.toString());
    }
  }
}