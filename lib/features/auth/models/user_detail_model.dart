class UserDetailResponse {
  final List<UserDetailModel> data;
  final bool success;
  final List<String> messages;

  UserDetailResponse({
    required this.data,
    required this.success,
    required this.messages,
  });

  factory UserDetailResponse.fromJson(Map<String, dynamic> json) {
    return UserDetailResponse(
      data: (json['data'] as List)
          .map((e) => UserDetailModel.fromJson(e))
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

class UserDetailModel {
  final int id;
  final int routeId;
  final int vanId;
  final int userId;
  final String? description;
  final int status;
  final int storeId;
  final String createdAt;
  final String updatedAt;
  final dynamic deletedAt;

  UserDetailModel({
    required this.id,
    required this.routeId,
    required this.vanId,
    required this.userId,
    this.description,
    required this.status,
    required this.storeId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory UserDetailModel.fromJson(Map<String, dynamic> json) {
    return UserDetailModel(
      id: json['id'] ?? 0,
      routeId: json['route_id'] ?? 0,
      vanId: json['van_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      description: json['description'],
      status: json['status'] ?? 0,
      storeId: json['store_id'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      deletedAt: json['deleted_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'route_id': routeId,
      'van_id': vanId,
      'user_id': userId,
      'description': description,
      'status': status,
      'store_id': storeId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }
}