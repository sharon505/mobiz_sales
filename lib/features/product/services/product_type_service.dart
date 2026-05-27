import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../network/api_end_points.dart';
import '../models/product_type_model.dart';

class ProductTypeService {
  Future<ProductTypeResponse> getProductTypes({
    required String token,
  }) async {
    try {
      final uri = ApiEndpoints.getProductType();

      print("========== PRODUCT TYPE API ==========");
      print("Request URL: $uri");

      final response = await http.get(
        uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("=====================================");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return ProductTypeResponse.fromJson(jsonData);
      } else {
        throw Exception(
          'Failed to fetch product types. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      print("Product Type Error: $e");
      throw Exception(e.toString());
    }
  }
}