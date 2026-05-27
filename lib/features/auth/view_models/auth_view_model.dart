import 'package:flutter/material.dart';
import '../models/login_response_model.dart';
import '../services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  String _errorMessage = '';
  LoginResponseModel? _loginResponse;

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  LoginResponseModel? get loginResponse => _loginResponse;

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final response = await _authService.login(
        email: email,
        password: password,
      );

      _loginResponse = response;

      _isLoading = false;
      notifyListeners();

      return true;
    } catch (e) {
      _errorMessage = e.toString();

      _isLoading = false;
      notifyListeners();

      return false;
    }
  }

  void clearError() {
    _errorMessage = '';
    notifyListeners();
  }

  void logout() {
    _loginResponse = null;
    _errorMessage = '';
    notifyListeners();
  }
}