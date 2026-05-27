import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppPadding {
  AppPadding._();

  // All sides
  static EdgeInsets get xs => EdgeInsets.all(4.w);
  static EdgeInsets get sm => EdgeInsets.all(8.w);
  static EdgeInsets get md => EdgeInsets.all(16.w);
  static EdgeInsets get lg => EdgeInsets.all(24.w);
  static EdgeInsets get xl => EdgeInsets.all(32.w);

  // Horizontal
  static EdgeInsets get horizontalSm =>
      EdgeInsets.symmetric(horizontal: 8.w);

  static EdgeInsets get horizontalMd =>
      EdgeInsets.symmetric(horizontal: 16.w);

  static EdgeInsets get horizontalLg =>
      EdgeInsets.symmetric(horizontal: 24.w);

  // Vertical
  static EdgeInsets get verticalSm =>
      EdgeInsets.symmetric(vertical: 8.h);

  static EdgeInsets get verticalMd =>
      EdgeInsets.symmetric(vertical: 16.h);

  static EdgeInsets get verticalLg =>
      EdgeInsets.symmetric(vertical: 24.h);

  // Screen Padding
  static EdgeInsets get screen => EdgeInsets.symmetric(
    horizontal: 16.w,
    vertical: 16.h,
  );

  // Card
  static EdgeInsets get card => EdgeInsets.all(16.w);

  // Input
  static EdgeInsets get input => EdgeInsets.symmetric(
    horizontal: 16.w,
    vertical: 12.h,
  );

  // Button
  static EdgeInsets get button => EdgeInsets.symmetric(
    horizontal: 20.w,
    vertical: 14.h,
  );
}