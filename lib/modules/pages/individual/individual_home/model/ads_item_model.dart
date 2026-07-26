class AdsItemModel {
  String? id;
  String? title;
  String? description;
  String? mediaUrl;
  String? targetUrl;
  String? type;
  String? status;
  int? priority;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;

  AdsItemModel({
    this.id,
    this.title,
    this.description,
    this.mediaUrl,
    this.targetUrl,
    this.type,
    this.status,
    this.priority,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  AdsItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    mediaUrl = json['mediaUrl'];
    targetUrl = json['targetUrl'];
    type = json['type'];
    status = json['status'];
    priority = json['priority'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['mediaUrl'] = mediaUrl;
    data['targetUrl'] = targetUrl;
    data['type'] = type;
    data['status'] = status;
    data['priority'] = priority;
    data['isDeleted'] = isDeleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
