import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../auth/view_models/auth_view_model.dart';

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
            /// Welcome Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.indigo],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome Back 👋',
                    style: TextStyle(color: Colors.white70, fontSize: 14.sp),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    user?.name ?? 'Sales User',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    user?.email ?? '',
                    style: TextStyle(color: Colors.white70, fontSize: 13.sp),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30.h),

            Text(
              'Quick Actions',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
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
                    onTap: () => Navigator.pushNamed(context, '/customers'),
                  ),
                  DashboardCard(
                    title: 'Products',
                    icon: Icons.inventory_2_outlined,
                    color: Colors.green,
                    onTap: () => Navigator.pushNamed(context, '/products'),
                  ),
                  DashboardCard(
                    title: 'Create Invoice',
                    icon: Icons.receipt_long_outlined,
                    color: Colors.purple,
                    onTap: () {
                      // Navigate to Create Invoice
                    },
                  ),
                  DashboardCard(
                    title: 'Invoice List',
                    icon: Icons.list_alt_outlined,
                    color: Colors.red,
                    onTap: () => Navigator.pushNamed(context, '/invoice-list'),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10.h),

            SizedBox(
              width: double.infinity,
              height: 55.h,
              child: ElevatedButton.icon(
                onPressed: () {
                  auth.logout();

                  Navigator.pop(context);
                },
                icon: const Icon(Icons.logout),
                label: Text('Logout', style: TextStyle(fontSize: 16.sp)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const DashboardCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20.r),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 28.r,
              backgroundColor: color.withOpacity(0.2),
              child: Icon(icon, color: color, size: 28.sp),
            ),
            SizedBox(height: 16.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
