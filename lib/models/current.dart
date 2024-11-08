class CurrentOrders {
  final bool success;
  final List<CurrentOrder> orders;

  CurrentOrders({
    required this.success,
    required this.orders,
  });

  factory CurrentOrders.fromJson(Map<String, dynamic> json) {
    return CurrentOrders(
      success: json['success'],
      orders: (json['orders'] as List)
          .map((orderJson) => CurrentOrder.fromJson(orderJson))
          .toList(),
    );
  }
}

class CurrentOrder {
  final int id;
  final int clientId;
  final int clientRoomId;
  final int? staffId;
  final int status;
  final String? clientComment;
  final String? staffComment;
  final List<CurrentOption>? options;
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
  final CurrentRoom room;
  final CurrentService service;

  CurrentOrder({
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

  factory CurrentOrder.fromJson(Map<String, dynamic> json) {
    return CurrentOrder(
      id: json['id'] ?? 0,
      clientId: json['client_id'] ?? 0,
      clientRoomId: json['client_room_id'] ?? 0,
      staffId: json['staff_id'] ?? 0,
      status: json['status'] ?? 0,
      clientComment: json['client_comment'],
      staffComment: json['staff_comment'],
      options: (json['options'] as List?)
              ?.map((option) => CurrentOption.fromJson(option))
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
      room: CurrentRoom.fromJson(json['room']),
      service: CurrentService.fromJson(json['service']),
    );
  }
}

class CurrentRoom {
  final int id;
  final int organizationId;
  final String name;
  final String? description;
  final String qrCode;
  final bool isActive;
  final List<dynamic> gallery;

  CurrentRoom({
    required this.id,
    required this.organizationId,
    required this.name,
    this.description,
    required this.qrCode,
    required this.isActive,
    required this.gallery,
  });

  factory CurrentRoom.fromJson(Map<String, dynamic> json) {
    return CurrentRoom(
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

class CurrentService {
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
  final List<CurrentOption> options;
  final String icon;

  CurrentService({
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

  factory CurrentService.fromJson(Map<String, dynamic> json) {
    return CurrentService(
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
              ?.map((optionJson) => CurrentOption.fromJson(optionJson))
              .toList() ??
          [],
      icon: json['icon'],
    );
  }
}

class CurrentOption {
  final int? type;
  final String name;
  final String? values;

  CurrentOption({
    required this.type,
    required this.name,
    required this.values,
  });

  factory CurrentOption.fromJson(Map<String, dynamic> json) {
    return CurrentOption(
      type: json['type'] ?? 0,
      name: json['name'],
      values: json['values'],
    );
  }
}
