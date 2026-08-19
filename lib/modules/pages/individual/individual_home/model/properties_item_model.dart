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
  });

  PropertiesItemModel.fromJson(Map<String, dynamic> json) {
    propertyId = json['property_id'] ?? json['propertyId'];
    type = json['type'];
    status = json['status'];
    title = json['title'];
    price = json['price'];
    listingType = json['listingType'];
    totalArea = json['totalArea'];
    bedrooms = json['bedrooms'];
    bathrooms = json['bathrooms'];
    city = json['city'] ?? json['location']['city'] ?? '';
    district = json['district'] ?? json['location']['district'] ?? '';
    image = json['image'] ?? json['mainImage'];
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
    return data;
  }
}
