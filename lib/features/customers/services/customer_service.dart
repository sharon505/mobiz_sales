import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../network/api_end_points.dart';
import '../models/customer_model.dart';

class CustomerService {
  Future<CustomerResponseModel> getCustomers({
    required String token,
    required String routeId,
    required String storeId,
  }) async {
    try {
      final uri = ApiEndpoints.getCustomer().replace(
        queryParameters: {
          "route_id": routeId,
          "store_id": storeId,
        },
      );

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

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        return CustomerResponseModel.fromJson(decodedData);
      } else {
        throw Exception('Failed to fetch customers');
      }
    } catch (e) {
      print("Customer API Error: $e");
      throw Exception(e.toString());
    }
  }
}