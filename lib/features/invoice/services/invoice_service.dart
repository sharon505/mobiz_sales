import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../network/api_end_points.dart';
import '../models/create_In_voice_request_model.dart';

class InvoiceService {
  Future<dynamic> createVanSale({
    required String token,
    required CreateInvoiceRequestModel request,
  }) async {
    try {
      print("========== CREATE VAN SALE ==========");
      print("Request URL: ${ApiEndpoints.createVanSale()}");
      print("Request Body: ${jsonEncode(request.toJson())}");

      final response = await http.post(
        ApiEndpoints.createVanSale(),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("====================================");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
          'Invoice creation failed. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      print("Invoice API Error: $e");
      throw Exception(e.toString());
    }
  }
}