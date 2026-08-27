class NotificationModel {
  String? id;
  String? userId;
  String? type;
  String? title;
  String? body;
  bool? isRead;
  String? createdAt;
  String? bidId;
  String? contractId;
  String? propertyId;

  NotificationModel({
    this.id,
    this.userId,
    this.type,
    this.title,
    this.body,
    this.isRead,
    this.createdAt,
    this.bidId,
    this.contractId,
    this.propertyId,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = _string(json['id']);
    userId = _string(json['userId']);
    type = _string(json['type']);
    title = _string(json['title']);
    body = _string(json['body']);
    isRead = json['isRead'] == true;
    createdAt = _string(json['createdAt']);
    bidId = _string(json['bidId']);
    contractId = _string(json['contractId']);
    propertyId = _string(json['propertyId']);
  }

  bool get isAuctionType {
    final value = (type ?? '').toUpperCase();
    return value.startsWith('AUCTION_');
  }

  NotificationModel copyWith({
    String? id,
    String? userId,
    String? type,
    String? title,
    String? body,
    bool? isRead,
    String? createdAt,
    String? bidId,
    String? contractId,
    String? propertyId,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      title: title ?? this.title,
      body: body ?? this.body,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
      bidId: bidId ?? this.bidId,
      contractId: contractId ?? this.contractId,
      propertyId: propertyId ?? this.propertyId,
    );
  }

  static String? _string(dynamic value) {
    if (value == null) return null;
    final text = value.toString().trim();
    if (text.isEmpty || text == 'null') return null;
    return text;
  }
}
