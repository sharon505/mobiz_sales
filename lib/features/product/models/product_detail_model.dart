class ProductDetailResponse {
  final List<ProductDetailModel> data;
  final bool success;
  final List<String> messages;

  ProductDetailResponse({
    required this.data,
    required this.success,
    required this.messages,
  });

  factory ProductDetailResponse.fromJson(Map<String, dynamic> json) {
    return ProductDetailResponse(
      data: (json['data'] as List)
          .map((e) => ProductDetailModel.fromJson(e))
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

class ProductDetailModel {
  final int id;
  final int productId;
  final int unit;
  final String qty;
  final String price;
  final dynamic minimumPrice;
  final List<UnitModel> units;

  ProductDetailModel({
    required this.id,
    required this.productId,
    required this.unit,
    required this.qty,
    required this.price,
    this.minimumPrice,
    required this.units,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
      id: json['id'] ?? 0,
      productId: json['product_id'] ?? 0,
      unit: json['unit'] ?? 0,
      qty: json['qty'] ?? '',
      price: json['price'] ?? '',
      minimumPrice: json['minimum_price'],
      units: (json['units'] as List)
          .map((e) => UnitModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'unit': unit,
      'qty': qty,
      'price': price,
      'minimum_price': minimumPrice,
      'units': units.map((e) => e.toJson()).toList(),
    };
  }
}

class UnitModel {
  final int id;
  final String name;

  UnitModel({
    required this.id,
    required this.name,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}