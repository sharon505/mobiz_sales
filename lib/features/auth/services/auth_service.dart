import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../network/api_end_points.dart';
import '../models/login_response_model.dart';

class AuthService {
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final url = ApiEndpoints.login();

      debugPrint('LOGIN URL: $url');

      final requestBody = {
        "email": email,
        "password": password,
      };

      debugPrint('LOGIN REQUEST BODY: ${jsonEncode(requestBody)}');

      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      debugPrint('STATUS CODE: ${response.statusCode}');
      debugPrint('RESPONSE BODY: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedData = jsonDecode(response.body);
        debugPrint('LOGIN SUCCESS');

        return LoginResponseModel.fromJson(decodedData);
      } else {
        final errorData = jsonDecode(response.body);
        debugPrint('LOGIN FAILED: ${errorData['message']}');

        throw Exception(
          errorData['message'] ?? 'Login failed',
        );
      }
    } catch (e) {
      debugPrint('LOGIN ERROR: $e');
      throw Exception('Error: $e');
    }
  }
}