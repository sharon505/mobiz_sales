import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../network/api_end_points.dart';
import '../models/user_detail_model.dart';

class UserDetailService {
  Future<UserDetailResponse> getUserDetail({
    required String token,
    required String userId,
  }) async {
    try {
      final uri = ApiEndpoints.getUserDetail().replace(
        queryParameters: {
          'user_id': userId,
        },
      );

      print("========== USER DETAIL API ==========");
      print("Request URL: $uri");
      print("User ID: $userId");

      final response = await http.get(
        uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("===================================");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return UserDetailResponse.fromJson(jsonData);
      } else {
        throw Exception(
          'Failed to fetch user details. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      print("User Detail Error: $e");
      throw Exception(e.toString());
    }
  }
}