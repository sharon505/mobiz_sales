import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/auth_view_model.dart';
import '../view_models/user_detail_view_model.dart';

class LoginController {
  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController(
    text: 'sales@shop.com',
  );

  final TextEditingController passwordController = TextEditingController(
    text: '12345678',
  );

  Future<void> login(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    final authProvider =
    Provider.of<AuthViewModel>(context, listen: false);

    final success = await authProvider.login(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    if (!context.mounted) return;

    if (success) {
      final userDetailVM =
      Provider.of<UserDetailViewModel>(context, listen: false);

      await userDetailVM.fetchUserDetail(
        token: authProvider.loginResponse!.authorisation.token,
        userId: authProvider.loginResponse!.user.id.toString(),
      );

      if (!context.mounted) return;

      Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(authProvider.errorMessage)),
      );
    }
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}