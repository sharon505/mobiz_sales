import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../network/api_end_points.dart';
import '../models/product_model.dart';

class ProductService {
  Future<ProductResponseModel> getProducts({
    required String token,
    required String storeId,
  }) async {
    try {
      final uri = ApiEndpoints.getProduct().replace(
        queryParameters: {
          "store_id": storeId,
        },
      );

      print("========== PRODUCT API ==========");
      print("Request URL: $uri");
      print("Store ID: $storeId");

      final response = await http.get(
        uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("================================");

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        return ProductResponseModel.fromJson(decodedData);
      } else {
        throw Exception(
          'Failed to fetch products. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      print("Product API Error: $e");
      throw Exception(e.toString());
    }
  }
}