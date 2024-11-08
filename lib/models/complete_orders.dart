class CompletedOrders {
  final bool success;
  final List<CompletedOrder> orders;

  CompletedOrders({
    required this.success,
    required this.orders,
  });

  factory CompletedOrders.fromJson(Map<String, dynamic> json) {
    return CompletedOrders(
      success: json['success'],
      orders: (json['orders'] as List)
          .map((orderJson) => CompletedOrder.fromJson(orderJson))
          .toList(),
    );
  }
}

class CompletedOrder {
  final int id;
  final int clientId;
  final int clientRoomId;
  final int? staffId;
  final int status;
  final String? clientComment;
  final String? staffComment;
  final List<CompletedOption>? options;
  final int serviceId;
  final DateTime? acceptedAt;
  final DateTime? finishedAt;
  final bool isPaid;
  final String? canceledBy;
  final String? clientFinishComment;
  final double? rating;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String price;
  final String currency;
  final bool refund;
  final CompletedRoom room;
  final CompletedService service;

  CompletedOrder({
    required this.id,
    required this.clientId,
    required this.clientRoomId,
    this.staffId,
    required this.status,
    this.clientComment,
    this.staffComment,
    this.options,
    required this.serviceId,
    this.acceptedAt,
    this.finishedAt,
    required this.isPaid,
    this.canceledBy,
    this.clientFinishComment,
    this.rating,
    required this.createdAt,
    required this.updatedAt,
    required this.price,
    required this.currency,
    required this.refund,
    required this.room,
    required this.service,
  });

  factory CompletedOrder.fromJson(Map<String, dynamic> json) {
    return CompletedOrder(
      id: json['id'] ?? 0,
      clientId: json['client_id'] ?? 0,
      clientRoomId: json['client_room_id'] ?? 0,
      staffId: json['staff_id'] ?? 0,
      status: json['status'] ?? 0,
      clientComment: json['client_comment'],
      staffComment: json['staff_comment'],
      options: (json['options'] as List?)
              ?.map((option) => CompletedOption.fromJson(option))
              .toList() ??
          [],
      serviceId: json['service_id'],
      acceptedAt: json['accepted_at'] != null
          ? DateTime.parse(json['accepted_at'])
          : null,
      finishedAt: json['finished_at'] != null
          ? DateTime.parse(json['finished_at'])
          : null,
      isPaid: json['is_paid'],
      canceledBy: json['canceled_by'],
      clientFinishComment: json['client_finish_comment'],
      rating: json['rating'] != null
          ? double.tryParse(json['rating'].toString())
          : null,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      price: json['price'] ?? '0.0',
      currency: json['currency'] ?? 'USD',
      refund: json['refund'],
      room: CompletedRoom.fromJson(json['room']),
      service: CompletedService.fromJson(json['service']),
    );
  }
}

class CompletedRoom {
  final int id;
  final int organizationId;
  final String name;
  final String? description;
  final String qrCode;
  final bool isActive;
  final List<dynamic> gallery;

  CompletedRoom({
    required this.id,
    required this.organizationId,
    required this.name,
    this.description,
    required this.qrCode,
    required this.isActive,
    required this.gallery,
  });

  factory CompletedRoom.fromJson(Map<String, dynamic> json) {
    return CompletedRoom(
      id: json['id'] ?? 0,
      organizationId: json['organization_id'],
      name: json['name'],
      description: json['description'],
      qrCode: json['qr_code'],
      isActive: json['is_active'],
      gallery:
          json['gallery'] != null ? List<dynamic>.from(json['gallery']) : [],
    );
  }
}

class CompletedService {
  final int id;
  final int organizationId;
  final int staffCategoryId;
  final String price;
  final String currency;
  final String description;
  final String availableFrom;
  final String availableTo;
  final bool isActive;
  final String name;
  final List<CompletedOption> options;
  final String icon;

  CompletedService({
    required this.id,
    required this.organizationId,
    required this.staffCategoryId,
    required this.price,
    required this.currency,
    required this.description,
    required this.availableFrom,
    required this.availableTo,
    required this.isActive,
    required this.name,
    required this.options,
    required this.icon,
  });

  factory CompletedService.fromJson(Map<String, dynamic> json) {
    return CompletedService(
      id: json['id'] ?? 0,
      organizationId: json['organization_id'] ?? 0,
      staffCategoryId: json['staff_category_id'] ?? 0,
      price: json['price'] ?? 0,
      currency: json['currency'] ?? 0,
      description: json['description'],
      availableFrom: json['available_from'] ?? 0,
      availableTo: json['available_to'] ?? 0,
      isActive: json['is_active'],
      name: json['name'],
      options: (json['options'] as List?)
              ?.map((optionJson) => CompletedOption.fromJson(optionJson))
              .toList() ??
          [],
      icon: json['icon'],
    );
  }
}

class CompletedOption {
  final int? type;
  final String name;
  final String? values;

  CompletedOption({
    required this.type,
    required this.name,
    required this.values,
  });

  factory CompletedOption.fromJson(Map<String, dynamic> json) {
    return CompletedOption(
      type: json['type'] ?? 0,
      name: json['name'],
      values: json['values'],
    );
  }
}
