import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../network/api_end_points.dart';
import '../models/invoice_list_model.dart';

class InvoiceListService {
  Future<InvoiceListResponse> getInvoices({
    required String token,
    required String userId,
    required String storeId,
    required String vanId,
  }) async {
    try {
      final uri = ApiEndpoints.vanSaleList().replace(
        queryParameters: {
          'user_id': userId,
          'store_id': storeId,
          'van_id': vanId,
        },
      );

      print("========== INVOICE LIST ==========");
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
      print("=================================");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return InvoiceListResponse.fromJson(jsonData);
      } else {
        throw Exception(
          'Failed to fetch invoices. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      print("Invoice List Error: $e");
      throw Exception(e.toString());
    }
  }
}