import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../auth/view_models/auth_view_model.dart';
import 'logout_dialog.dart';

class LogoutActionButton extends StatelessWidget {
  final AuthViewModel auth;

  const LogoutActionButton({
    super.key,
    required this.auth,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 12.w),
      child: InkWell(
        borderRadius: BorderRadius.circular(14.r),
        onTap: () {
          LogoutDialog.show(context, auth);
        },
        child: Container(
          width: 42.w,
          height: 42.h,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          child: Icon(
            Icons.logout_rounded,
            color: Colors.white,
            size: 20.sp,
          ),
        ),
      ),
    );
  }
}