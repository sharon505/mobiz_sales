class ApiEndpoints {
  ApiEndpoints._();

  // ---------------------------BASE URL----------------------------------------

  static const String baseUrl = "http://142.93.214.133:3641/api";

  static Uri _u(String path) => Uri.parse('$baseUrl/$path');

  // ---------------------------AUTH--------------------------------------------

  static Uri login() => _u('login');                                ///completed

  static Uri getUserDetail() => _u('get_user_detail');              ///completed

  // --------------------------CUSTOMER-----------------------------------------

  static Uri getCustomer() => _u('get_customer');                   ///completed

  // --------------------------PRODUCT------------------------------------------

  static Uri getProduct() => _u('get_product');                     ///completed

  static Uri getProductType() => _u('get_product_type');            ///completed

  static Uri getProductDetail() => _u('get_product_detail');        ///completed

  // --------------------------VAN SALES----------------------------------------

  static Uri createVanSale() => _u('vansale.store');                ///completed

  static Uri vanSaleList() => _u('vansale.index');                  ///completed
}