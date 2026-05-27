import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

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
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WelcomeCard(user: user),

            SizedBox(height: 30.h),

            Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20.h),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 16.h,
                childAspectRatio: 1.1,
                children: [
                  DashboardCard(
                    title: 'Customers',
                    icon: Icons.people_alt_outlined,
                    color: Colors.orange,
                    onTap: () {
                      Navigator.pushNamed(context, '/customers');
                    },
                  ),
                  DashboardCard(
                    title: 'Products',
                    icon: Icons.inventory_2_outlined,
                    color: Colors.green,
                    onTap: () {
                      Navigator.pushNamed(context, '/products');
                    },
                  ),
                  DashboardCard(
                    title: 'Create Invoice',
                    icon: Icons.receipt_long_outlined,
                    color: Colors.purple,
                    onTap: () {},
                  ),
                  DashboardCard(
                    title: 'Invoice List',
                    icon: Icons.list_alt_outlined,
                    color: Colors.red,
                    onTap: () {
                      Navigator.pushNamed(context, '/invoice-list');
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 10.h),

            LogoutButton(auth: auth),
          ],
        ),
      ),
    );
  }
}