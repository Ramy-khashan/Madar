class PropertiesItemModel {
  String? propertyId;
  String? type;
  String? status;
  String? title;
  int? price;
  String? listingType;
  int? totalArea;
  int? bedrooms;
  int? bathrooms;
  String? city;
  String? district;
  String? image;
      String?   publisherId ;
      String?  publisherName ;
    String?   publisherPhone;
  PropertiesItemModel({
    this.propertyId,
    this.type,
    this.status,
    this.title,
    this.price,
    this.listingType,
    this.totalArea,
    this.bedrooms,
    this.bathrooms,
    this.city,
    this.district,
    this.image,
    this.publisherId,
    this.publisherName,
    this.publisherPhone,
  });

  PropertiesItemModel.fromJson(Map<String, dynamic> json) {
    propertyId = json['property_id'] ?? json['propertyId'];
    type = json['type'];
    status = json['status'];
    title = json['title'];
    price = json['price'] is num
        ? (json['price'] as num).toInt()
        : int.tryParse('${json['price'] ?? ''}');
    listingType = json['listingType'];
    totalArea = json['totalArea'];
    bedrooms = json['bedrooms'];
    bathrooms = json['bathrooms'];
    final location = json['location'] is Map
        ? Map<String, dynamic>.from(json['location'] as Map)
        : <String, dynamic>{};
    city = (json['city'] ?? location['city'] ?? '').toString();
    district = (json['district'] ?? location['district'] ?? '').toString();
    image = json['image'] ?? json['mainImage'];
    publisherId = json['publisherId'] ?? '';
    publisherName = json['publisherName'] ?? '';
    publisherPhone = json['publisherPhone'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['property_id'] = propertyId;
    data['type'] = type;
    data['status'] = status;
    data['title'] = title;
    data['price'] = price;
    data['listingType'] = listingType;
    data['totalArea'] = totalArea;
    data['bedrooms'] = bedrooms;
    data['bathrooms'] = bathrooms;
    data['city'] = city;
    data['district'] = district;
    data['image'] = image;
    data['publisherId'] = publisherId;
    data['publisherName'] = publisherName;
    data['publisherPhone'] = publisherPhone;
    return data;
  }
}
