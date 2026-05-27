class ProductTypeResponse {
  final List<ProductTypeModel> data;
  final bool success;
  final List<String> messages;

  ProductTypeResponse({
    required this.data,
    required this.success,
    required this.messages,
  });

  factory ProductTypeResponse.fromJson(Map<String, dynamic> json) {
    return ProductTypeResponse(
      data: (json['data'] as List)
          .map((e) => ProductTypeModel.fromJson(e))
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

class ProductTypeModel {
  final int id;
  final String name;
  final int status;
  final String createdAt;
  final String updatedAt;

  ProductTypeModel({
    required this.id,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductTypeModel.fromJson(Map<String, dynamic> json) {
    return ProductTypeModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      status: json['status'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}