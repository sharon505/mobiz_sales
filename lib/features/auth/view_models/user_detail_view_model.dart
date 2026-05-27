import 'package:flutter/material.dart';

import '../models/user_detail_model.dart';
import '../services/user_detail_service.dart';

class UserDetailViewModel extends ChangeNotifier {
  final UserDetailService _userDetailService = UserDetailService();

  bool _isLoading = false;
  String _errorMessage = '';
  UserDetailResponse? _userDetailResponse;

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  UserDetailResponse? get userDetailResponse => _userDetailResponse;

  List<UserDetailModel> get userDetails =>
      _userDetailResponse?.data ?? [];

  UserDetailModel? get currentUserDetail =>
      userDetails.isNotEmpty ? userDetails.first : null;

  Future<void> fetchUserDetail({
    required String token,
    required String userId,
  }) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final response = await _userDetailService.getUserDetail(
        token: token,
        userId: userId,
      );

      _userDetailResponse = response;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearUserDetail() {
    _userDetailResponse = null;
    _errorMessage = '';
    _isLoading = false;
    notifyListeners();
  }
}