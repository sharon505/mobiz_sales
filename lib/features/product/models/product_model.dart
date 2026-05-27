class ProductResponseModel {
  final ProductPagination data;
  final bool success;
  final List<dynamic> messages;

  ProductResponseModel({
    required this.data,
    required this.success,
    required this.messages,
  });

  factory ProductResponseModel.fromJson(Map<String, dynamic> json) {
    return ProductResponseModel(
      data: ProductPagination.fromJson(json['data']),
      success: json['success'] ?? false,
      messages: json['messages'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.toJson(),
      'success': success,
      'messages': messages,
    };
  }
}

class ProductPagination {
  final int currentPage;
  final List<ProductModel> data;
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  final String? nextPageUrl;
  final String path;
  final int perPage;
  final String? prevPageUrl;
  final int to;
  final int total;

  ProductPagination({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory ProductPagination.fromJson(Map<String, dynamic> json) {
    return ProductPagination(
      currentPage: json['current_page'] ?? 0,
      data: (json['data'] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList(),
      firstPageUrl: json['first_page_url'] ?? '',
      from: json['from'] ?? 0,
      lastPage: json['last_page'] ?? 0,
      lastPageUrl: json['last_page_url'] ?? '',
      nextPageUrl: json['next_page_url'],
      path: json['path'] ?? '',
      perPage: int.tryParse(json['per_page'].toString()) ?? 0,
      prevPageUrl: json['prev_page_url'],
      to: json['to'] ?? 0,
      total: json['total'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'data': data.map((e) => e.toJson()).toList(),
      'first_page_url': firstPageUrl,
      'from': from,
      'last_page': lastPage,
      'last_page_url': lastPageUrl,
      'next_page_url': nextPageUrl,
      'path': path,
      'per_page': perPage,
      'prev_page_url': prevPageUrl,
      'to': to,
      'total': total,
    };
  }
}

class ProductModel {
  final int id;
  final dynamic code;
  final String name;
  final String proImage;
  final int taxPercentage;
  final int price;
  final int storeId;
  final int status;
  final List<ProductUnit> units;

  ProductModel({
    required this.id,
    this.code,
    required this.name,
    required this.proImage,
    required this.taxPercentage,
    required this.price,
    required this.storeId,
    required this.status,
    required this.units,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      code: json['code'],
      name: json['name'] ?? '',
      proImage: json['pro_image'] ?? '',
      taxPercentage: json['tax_percentage'] ?? 0,
      price: json['price'] ?? 0,
      storeId: json['store_id'] ?? 0,
      status: json['status'] ?? 0,
      units: (json['units'] as List)
          .map((e) => ProductUnit.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'pro_image': proImage,
      'tax_percentage': taxPercentage,
      'price': price,
      'store_id': storeId,
      'status': status,
      'units': units.map((e) => e.toJson()).toList(),
    };
  }
}

class ProductUnit {
  final int unit;
  final int id;
  final String name;
  final String price;
  final dynamic minPrice;
  final int stock;

  ProductUnit({
    required this.unit,
    required this.id,
    required this.name,
    required this.price,
    this.minPrice,
    required this.stock,
  });

  factory ProductUnit.fromJson(Map<String, dynamic> json) {
    return ProductUnit(
      unit: json['unit'] ?? 0,
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      price: json['price'] ?? '',
      minPrice: json['min_price'],
      stock: json['stock'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'unit': unit,
      'id': id,
      'name': name,
      'price': price,
      'min_price': minPrice,
      'stock': stock,
    };
  }
}