class LoginResponseModel {
  final String status;
  final User user;
  final Settings settings;
  final Authorisation authorisation;

  LoginResponseModel({
    required this.status,
    required this.user,
    required this.settings,
    required this.authorisation,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      status: json['status'] ?? '',
      user: User.fromJson(json['user'] ?? {}),
      settings: Settings.fromJson(json['settings'] ?? {}),
      authorisation: Authorisation.fromJson(json['authorisation'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'user': user.toJson(),
      'settings': settings.toJson(),
      'authorisation': authorisation.toJson(),
    };
  }
}

class User {
  final int id;
  final String name;
  final String email;
  final dynamic emailVerifiedAt;
  final dynamic isSuperAdmin;
  final dynamic isShopAdmin;
  final String isStaff;
  final int departmentId;
  final int designationId;
  final int storeId;
  final int rolId;
  final dynamic productionStore;
  final int glId;
  final dynamic commissionType;
  final dynamic token;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    this.isSuperAdmin,
    this.isShopAdmin,
    required this.isStaff,
    required this.departmentId,
    required this.designationId,
    required this.storeId,
    required this.rolId,
    this.productionStore,
    required this.glId,
    this.commissionType,
    this.token,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      emailVerifiedAt: json['email_verified_at'],
      isSuperAdmin: json['is_super_admin'],
      isShopAdmin: json['is_shop_admin'],
      isStaff: json['is_staff'] ?? '',
      departmentId: json['department_id'] ?? 0,
      designationId: json['designation_id'] ?? 0,
      storeId: json['store_id'] ?? 0,
      rolId: json['rol_id'] ?? 0,
      productionStore: json['production_store'],
      glId: json['gl_id'] ?? 0,
      commissionType: json['commission_type'],
      token: json['token'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'is_super_admin': isSuperAdmin,
      'is_shop_admin': isShopAdmin,
      'is_staff': isStaff,
      'department_id': departmentId,
      'designation_id': designationId,
      'store_id': storeId,
      'rol_id': rolId,
      'production_store': productionStore,
      'gl_id': glId,
      'commission_type': commissionType,
      'token': token,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class Settings {
  final int id;
  final int storeId;
  final String vatNoVat;
  final String soRate;
  final String salesRate;
  final String attendance;
  final String discount;
  final String validateQtyInSo;
  final String validateQtyInSales;
  final String integrationType;
  final String soIntegration;
  final String invoiceIntegration;
  final String autoOffloadForReturn;
  final String salesPercentageSummary;
  final String printer;
  final String barcodeInInvoice;
  final String salesSummary;
  final String salesmanWiseSales;
  final String recentSales;
  final String salesOrderPercentageSummary;
  final String salesOrderSummary;
  final String salesmanWiseSalesOrder;
  final String recentSalesOrder;
  final String multibranch;
  final String accountPosting;
  final String allowNewProduct;
  final String allowBackDate;
  final dynamic routeApplicable;
  final String createdAt;
  final String updatedAt;

  Settings({
    required this.id,
    required this.storeId,
    required this.vatNoVat,
    required this.soRate,
    required this.salesRate,
    required this.attendance,
    required this.discount,
    required this.validateQtyInSo,
    required this.validateQtyInSales,
    required this.integrationType,
    required this.soIntegration,
    required this.invoiceIntegration,
    required this.autoOffloadForReturn,
    required this.salesPercentageSummary,
    required this.printer,
    required this.barcodeInInvoice,
    required this.salesSummary,
    required this.salesmanWiseSales,
    required this.recentSales,
    required this.salesOrderPercentageSummary,
    required this.salesOrderSummary,
    required this.salesmanWiseSalesOrder,
    required this.recentSalesOrder,
    required this.multibranch,
    required this.accountPosting,
    required this.allowNewProduct,
    required this.allowBackDate,
    this.routeApplicable,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      id: json['id'] ?? 0,
      storeId: json['store_id'] ?? 0,
      vatNoVat: json['vat_no_vat'] ?? '',
      soRate: json['so_rate'] ?? '',
      salesRate: json['sales_rate'] ?? '',
      attendance: json['attendance'] ?? '',
      discount: json['discount'] ?? '',
      validateQtyInSo: json['validate_qty_in_so'] ?? '',
      validateQtyInSales: json['validate_qty_in_sales'] ?? '',
      integrationType: json['integration_type'] ?? '',
      soIntegration: json['so_integration'] ?? '',
      invoiceIntegration: json['invoice_integration'] ?? '',
      autoOffloadForReturn: json['auto_offload_for_return'] ?? '',
      salesPercentageSummary: json['sales_percentage_summary'] ?? '',
      printer: json['printer'] ?? '',
      barcodeInInvoice: json['barcode_in_invoice'] ?? '',
      salesSummary: json['sales_summary'] ?? '',
      salesmanWiseSales: json['salesman_wise_sales'] ?? '',
      recentSales: json['recent_sales'] ?? '',
      salesOrderPercentageSummary:
      json['sales_order_percentage_summary'] ?? '',
      salesOrderSummary: json['sales_order_summary'] ?? '',
      salesmanWiseSalesOrder: json['salesman_wise_sales_order'] ?? '',
      recentSalesOrder: json['recent_sales_order'] ?? '',
      multibranch: json['multibranch'] ?? '',
      accountPosting: json['account_posting'] ?? '',
      allowNewProduct: json['allow_new_product'] ?? '',
      allowBackDate: json['allow_back_date'] ?? '',
      routeApplicable: json['route_applicable'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'store_id': storeId,
      'vat_no_vat': vatNoVat,
      'so_rate': soRate,
      'sales_rate': salesRate,
      'attendance': attendance,
      'discount': discount,
      'validate_qty_in_so': validateQtyInSo,
      'validate_qty_in_sales': validateQtyInSales,
      'integration_type': integrationType,
      'so_integration': soIntegration,
      'invoice_integration': invoiceIntegration,
      'auto_offload_for_return': autoOffloadForReturn,
      'sales_percentage_summary': salesPercentageSummary,
      'printer': printer,
      'barcode_in_invoice': barcodeInInvoice,
      'sales_summary': salesSummary,
      'salesman_wise_sales': salesmanWiseSales,
      'recent_sales': recentSales,
      'sales_order_percentage_summary': salesOrderPercentageSummary,
      'sales_order_summary': salesOrderSummary,
      'salesman_wise_sales_order': salesmanWiseSalesOrder,
      'recent_sales_order': recentSalesOrder,
      'multibranch': multibranch,
      'account_posting': accountPosting,
      'allow_new_product': allowNewProduct,
      'allow_back_date': allowBackDate,
      'route_applicable': routeApplicable,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class Authorisation {
  final String token;
  final String type;

  Authorisation({
    required this.token,
    required this.type,
  });

  factory Authorisation.fromJson(Map<String, dynamic> json) {
    return Authorisation(
      token: json['token'] ?? '',
      type: json['type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'type': type,
    };
  }
}