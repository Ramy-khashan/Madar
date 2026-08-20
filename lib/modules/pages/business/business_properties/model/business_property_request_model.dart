class BusinessPropertyRequestModel {
  String? requestId;
  String? propertyId;
  String? title;
  String? owner;
  String? status;
  String? createdAt;
  String? image;
  String? city;
  String? district;

  BusinessPropertyRequestModel(
      {this.requestId,
      this.propertyId,
      this.title,
      this.owner,
      this.status,
      this.createdAt,
      this.image,
      this.city,
      this.district});

  BusinessPropertyRequestModel.fromJson(Map<String, dynamic> json) {
    requestId = json['requestId'];
    propertyId = json['propertyId'];
    title = json['title'];
    owner = json['owner'];
    status = json['status'];
    createdAt = json['createdAt'];
    image = json['image'];
    city = json['city'];
    district = json['district'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['requestId'] = requestId;
    data['propertyId'] = propertyId;
    data['title'] = title;
    data['owner'] = owner;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['image'] = image;
    data['city'] = city;
    data['district'] = district;
    return data;
  }
}


class BusinessRequestPublishedPropertyModel {
  final String id;
  final String title;
  final String location;
  final String imageUrl;
  final int contractNumber;
  final double occupancyRate;
  final String lastUpdate;
  final String status;

  const BusinessRequestPublishedPropertyModel({
    required this.id,
    required this.title,
    required this.location,
    required this.imageUrl,
    required this.contractNumber,
    required this.occupancyRate,
    required this.lastUpdate,
    required this.status,
  });
}