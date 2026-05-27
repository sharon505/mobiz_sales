class CustomerResponseModel {
  final List<CustomerModel> data;
  final bool success;
  final List<String> messages;

  CustomerResponseModel({
    required this.data,
    required this.success,
    required this.messages,
  });

  factory CustomerResponseModel.fromJson(Map<String, dynamic> json) {
    return CustomerResponseModel(
      data: (json['data'] as List)
          .map((e) => CustomerModel.fromJson(e))
          .toList(),
      success: json['success'] ?? false,
      messages: List<String>.from(json['messages'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((e) => e.toJson()).toList(),
      'success': success,
      'messages': messages,
    };
  }
}

class CustomerModel {
  final int id;
  final String name;
  final String code;
  final String? address;
  final String? building;
  final String? flatNo;
  final String contactNumber;
  final String? whatsappNumber;
  final String? email;
  final String? trn;
  final String custImage;
  final String paymentTerms;
  final int creditLimit;
  final int creditDays;
  final String? location;
  final int routeId;
  final int provinceId;
  final int countryId;
  final int storeId;
  final int status;
  final String createdAt;
  final String updatedAt;
  final dynamic deletedAt;
  final dynamic erpCustomerCode;
  final int priceGroupId;
  final dynamic accountId;
  final String isCustomer;
  final String isSupplier;
  final dynamic receivableGlId;
  final dynamic payableGlId;
  final dynamic salesmanId;

  CustomerModel({
    required this.id,
    required this.name,
    required this.code,
    this.address,
    this.building,
    this.flatNo,
    required this.contactNumber,
    this.whatsappNumber,
    this.email,
    this.trn,
    required this.custImage,
    required this.paymentTerms,
    required this.creditLimit,
    required this.creditDays,
    this.location,
    required this.routeId,
    required this.provinceId,
    required this.countryId,
    required this.storeId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.erpCustomerCode,
    required this.priceGroupId,
    this.accountId,
    required this.isCustomer,
    required this.isSupplier,
    this.receivableGlId,
    this.payableGlId,
    this.salesmanId,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      code: json['code'] ?? '',
      address: json['address'],
      building: json['Building'],
      flatNo: json['Flat_no'],
      contactNumber: json['contact_number'] ?? '',
      whatsappNumber: json['whatsapp_number'],
      email: json['email'],
      trn: json['trn'],
      custImage: json['cust_image'] ?? '',
      paymentTerms: json['payment_terms'] ?? '',
      creditLimit: json['credit_limit'] ?? 0,
      creditDays: json['credit_days'] ?? 0,
      location: json['location'],
      routeId: json['route_id'] ?? 0,
      provinceId: json['province_id'] ?? 0,
      countryId: json['country_id'] ?? 0,
      storeId: json['store_id'] ?? 0,
      status: json['status'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      deletedAt: json['deleted_at'],
      erpCustomerCode: json['erp_customer_code'],
      priceGroupId: json['price_group_id'] ?? 0,
      accountId: json['account_id'],
      isCustomer: json['is_customer'] ?? '',
      isSupplier: json['is_supplier'] ?? '',
      receivableGlId: json['receivable_gl_id'],
      payableGlId: json['payable_gl_id'],
      salesmanId: json['salesman_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'address': address,
      'Building': building,
      'Flat_no': flatNo,
      'contact_number': contactNumber,
      'whatsapp_number': whatsappNumber,
      'email': email,
      'trn': trn,
      'cust_image': custImage,
      'payment_terms': paymentTerms,
      'credit_limit': creditLimit,
      'credit_days': creditDays,
      'location': location,
      'route_id': routeId,
      'province_id': provinceId,
      'country_id': countryId,
      'store_id': storeId,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
      'erp_customer_code': erpCustomerCode,
      'price_group_id': priceGroupId,
      'account_id': accountId,
      'is_customer': isCustomer,
      'is_supplier': isSupplier,
      'receivable_gl_id': receivableGlId,
      'payable_gl_id': payableGlId,
      'salesman_id': salesmanId,
    };
  }
}