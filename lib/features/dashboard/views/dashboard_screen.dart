import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_strings.dart';
import '../../../utils/constants/app_text_styles.dart';
import '../../auth/view_models/auth_view_model.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/logout_button.dart';
import '../widgets/welcome_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthViewModel>(context);
    final user = auth.loginResponse?.user;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.transparent,
        leading: Center(
          child: Container(
            width: 38.w,
            height: 38.h,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
              ),
            ),
            child: Icon(
              Icons.dashboard_customize_rounded,
              color: Colors.white,
              size: 21.sp,
            ),
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary,
                AppColors.primaryDark,
              ],
            ),
          ),
        ),
        title: Text(
          AppStrings.appName,
          style: AppTextStyles.title.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          LogoutActionButton(auth: auth),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primary.withOpacity(0.05),
              AppColors.scaffoldBackground,
              Colors.white,
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WelcomeCard(user: user),

              SizedBox(height: 28.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.quickActions,
                    style: AppTextStyles.title.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      '4 Modules',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 2,
                  separatorBuilder: (context, index) => SizedBox(height: 14.h),
                  itemBuilder: (context, index) {
                    final items = [
                      {
                        'title': AppStrings.customers,
                        'subtitle': 'Manage customer records',
                        'icon': Icons.people_alt_outlined,
                        'route': '/customers',
                      },
                      // {
                      //   'title': AppStrings.products,
                      //   'subtitle': 'Browse product catalog',
                      //   'icon': Icons.inventory_2_outlined,
                      //   'route': '/products',
                      // },
                      // {
                      //   'title': AppStrings.createInvoice,
                      //   'subtitle': 'Generate new invoices',
                      //   'icon': Icons.receipt_long_outlined,
                      //   'route': '/create-invoice',
                      // },
                      {
                        'title': AppStrings.invoiceList,
                        'subtitle': 'View all invoices',
                        'icon': Icons.list_alt_outlined,
                        'route': '/invoice-list',
                      },
                    ];

                    final item = items[index];

                    return DashboardCard(
                      title: item['title'] as String,
                      subtitle: item['subtitle'] as String,
                      icon: item['icon'] as IconData,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          item['route'] as String,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}