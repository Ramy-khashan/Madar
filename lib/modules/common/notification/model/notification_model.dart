class NotificationModel {
  String? id;
  String? userId;
  String? type;
  String? title;
  String? body;
  bool? isRead;
  String? createdAt;

  NotificationModel(
      {this.id,
      this.userId,
      this.type,
      this.title,
      this.body,
      this.isRead,
      this.createdAt});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    type = json['type'];
    title = json['title'];
    body = json['body'];
    isRead = json['isRead'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['userId'] = userId;
    data['type'] = type;
    data['title'] = title;
    data['body'] = body;
    data['isRead'] = isRead;
    data['createdAt'] = createdAt;
    return data;
  }
}
