import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'features/auth/view_models/auth_view_model.dart';
import 'features/auth/view_models/user_detail_view_model.dart';
import 'features/auth/views/login_screen.dart';
import 'features/auth/views/splash_screen.dart';
import 'features/customers/viewmodels/customer_view_model.dart';
import 'features/customers/views/customer_list_screen.dart';
import 'features/dashboard/views/dashboard_screen.dart';
import 'features/invoice/viewmodels/InvoiceListViewModel.dart';
import 'features/invoice/viewmodels/invoice_view_model.dart';
import 'features/invoice/views/Iinvoice_page.dart';
import 'features/invoice/views/invoice_list_screen.dart';
import 'features/product/viewmodels/product_detail_view_model.dart';
import 'features/product/viewmodels/product_type_view_model.dart';
import 'features/product/viewmodels/product_view_model.dart';
import 'features/product/views/product_detail_screen.dart';
import 'features/product/views/product_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Phoenix(child: const MyApp()),
  );
}

List<SingleChildWidget> providers = [
  // ---------------------------AUTH--------------------------------------------
  ChangeNotifierProvider(create: (_) => AuthViewModel()),
  ChangeNotifierProvider(create: (_) => UserDetailViewModel()),
  // --------------------------CUSTOMER-----------------------------------------
  ChangeNotifierProvider(create: (_) => CustomerViewModel()),
  // --------------------------PRODUCT------------------------------------------
  ChangeNotifierProvider(create: (_) => ProductViewModel()),
  ChangeNotifierProvider(create: (_) => ProductDetailViewModel()),
  ChangeNotifierProvider(create: (_) => ProductTypeViewModel()),
  // --------------------------VAN SALES----------------------------------------
  ChangeNotifierProvider(create: (_) => InvoiceViewModel()),
  ChangeNotifierProvider(create: (_) => InvoiceListViewModel()),
];

Map<String, Widget Function(BuildContext)> routes = <String, WidgetBuilder>{
  '/':                    (context) => const SplashScreen(),
  '/Login':               (context) => const LoginScreen(),
  '/dashboard':           (context) => const DashboardScreen(),
  '/customers':           (context) => const CustomerListScreen(),
  '/products':            (context) => const ProductListScreen(),
  '/invoice':             (context) => const InvoicePage(),
  '/invoice-list':        (context) => const InvoiceListScreen(),
  '/product-detail':      (context) => const ProductDetailScreen(),
};

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Size getDesignSize(BuildContext context) {
      final width = MediaQuery.of(context).size.width;

      if (width >= 900) {
        // 💻 10-inch tablet
        return const Size(800, 1280);
      } else if (width >= 600) {
        // 📲 7-inch tablet
        return const Size(600, 1024);
      } else {
        // 📱 Mobile
        return const Size(375, 812);
      }
    }
    return MultiProvider(
      providers:providers,
      child: ScreenUtilInit(
        designSize: getDesignSize(context),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            routes: routes,
            initialRoute: '/',
            debugShowCheckedModeBanner: false,
            title: 'Mobiz Sales',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              scaffoldBackgroundColor: Colors.white,
              useMaterial3: true,
            ),
          );
        },
      ),
    );
  }
}