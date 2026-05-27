import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../auth/view_models/auth_view_model.dart';

class LogoutButton extends StatelessWidget {
  final AuthViewModel auth;

  const LogoutButton({
    super.key,
    required this.auth,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55.h,
      child: ElevatedButton.icon(
        onPressed: () {
          auth.logout();
          Navigator.pop(context);
        },
        icon: const Icon(Icons.logout),
        label: Text(
          'Logout',
          style: TextStyle(fontSize: 16.sp),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black87,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
        ),
      ),
    );
  }
}