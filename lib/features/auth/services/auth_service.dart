import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../network/api_end_points.dart';
import '../models/login_response_model.dart';

class AuthService {
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        ApiEndpoints.login(),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedData = jsonDecode(response.body);
        return LoginResponseModel.fromJson(decodedData);
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['message'] ?? 'Login failed');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}