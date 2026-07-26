class ContractModel {
  String? id;
  String? contractNo;
  String? propertyId;
  String? buyerId;
  String? sellerId;
  String? brokerId;
  String? type;
  String? status;
  int? price;
  String? startDate;
  String? endDate;
  String? createdAt;
  int? commissionAmount;
  Buyer? buyer;
  Buyer? seller;
  String? broker;
  Property? property;

  ContractModel({
    this.id,
    this.contractNo,
    this.propertyId,
    this.buyerId,
    this.sellerId,
    this.brokerId,
    this.type,
    this.status,
    this.price,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.commissionAmount,
    this.buyer,
    this.seller,
    this.broker,
    this.property,
  });

  String get title => contractNo ?? '';
  String get propertyName => property?.title ?? property?.projectName ?? '';
  String get date => startDate ?? createdAt ?? '';
  double get amount => (price ?? 0).toDouble();

  ContractModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contractNo = json['contractNo'];
    propertyId = json['propertyId'];
    buyerId = json['buyerId'];
    sellerId = json['sellerId'];
    brokerId = json['brokerId'];
    type = json['type'];
    status = json['status'];
    price = json['price'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    createdAt = json['createdAt'];
    commissionAmount = json['commissionAmount'];
    buyer = json['buyer'] != null ? Buyer.fromJson(json['buyer']) : null;
    seller = json['seller'] != null ? Buyer.fromJson(json['seller']) : null;
    broker = json['broker'];
    property = json['property'] != null
        ? Property.fromJson(json['property'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['contractNo'] = contractNo;
    data['propertyId'] = propertyId;
    data['buyerId'] = buyerId;
    data['sellerId'] = sellerId;
    data['brokerId'] = brokerId;
    data['type'] = type;
    data['status'] = status;
    data['price'] = price;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['createdAt'] = createdAt;
    data['commissionAmount'] = commissionAmount;
    if (buyer != null) {
      data['buyer'] = buyer!.toJson();
    }
    if (seller != null) {
      data['seller'] = seller!.toJson();
    }
    data['broker'] = broker;
    if (property != null) {
      data['property'] = property!.toJson();
    }
    return data;
  }
}

class Buyer {
  String? userId;
  String? fullName;
  String? role;

  Buyer({this.userId, this.fullName, this.role});

  Buyer.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    fullName = json['fullName'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['fullName'] = fullName;
    data['role'] = role;
    return data;
  }
}

class Property {
  String? propertyId;
  String? projectName;
  int? price;
  String? propertyNo;
  String? description;
  bool? isActive;
  String? ownerId;
  String? brokerId;
  String? createdAt;
  String? updatedAt;
  String? status;
  String? brokerProfileId;
  String? propertyAge;
  Details? details;
  Features? features;
  bool? isNegotiable;
  String? listingType;
  String? title;
  int? totalArea;
  String? type;
  String? paymentType;
  String? context;
  String? propertyParentId;
  String? adLicenseNumber;

  Property({
    this.propertyId,
    this.projectName,
    this.price,
    this.propertyNo,
    this.description,
    this.isActive,
    this.ownerId,
    this.brokerId,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.brokerProfileId,
    this.propertyAge,
    this.details,
    this.features,
    this.isNegotiable,
    this.listingType,
    this.title,
    this.totalArea,
    this.type,
    this.paymentType,
    this.context,
    this.propertyParentId,
    this.adLicenseNumber,
  });

  Property.fromJson(Map<String, dynamic> json) {
    propertyId = json['property_id'];
    projectName = json['projectName'];
    price = json['price'];
    propertyNo = json['propertyNo'];
    description = json['description'];
    isActive = json['isActive'];
    ownerId = json['ownerId'];
    brokerId = json['brokerId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    status = json['status'];
    brokerProfileId = json['brokerProfileId'];
    propertyAge = json['propertyAge'];
    details = json['details'] != null
        ? Details.fromJson(json['details'])
        : null;
    features = json['features'] != null
        ? Features.fromJson(json['features'])
        : null;
    isNegotiable = json['isNegotiable'];
    listingType = json['listingType'];
    title = json['title'];
    totalArea = json['totalArea'];
    type = json['type'];
    paymentType = json['paymentType'];
    context = json['context'];
    propertyParentId = json['propertyParentId'];
    adLicenseNumber = json['adLicenseNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['property_id'] = propertyId;
    data['projectName'] = projectName;
    data['price'] = price;
    data['propertyNo'] = propertyNo;
    data['description'] = description;
    data['isActive'] = isActive;
    data['ownerId'] = ownerId;
    data['brokerId'] = brokerId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['status'] = status;
    data['brokerProfileId'] = brokerProfileId;
    data['propertyAge'] = propertyAge;
    if (details != null) {
      data['details'] = details!.toJson();
    }
    if (features != null) {
      data['features'] = features!.toJson();
    }
    data['isNegotiable'] = isNegotiable;
    data['listingType'] = listingType;
    data['title'] = title;
    data['totalArea'] = totalArea;
    data['type'] = type;
    data['paymentType'] = paymentType;
    data['context'] = context;
    data['propertyParentId'] = propertyParentId;
    data['adLicenseNumber'] = adLicenseNumber;
    return data;
  }
}

class Details {
  int? floor;
  int? bedrooms;
  int? bathrooms;
  String? condition;
  String? furnishing;

  Details({
    this.floor,
    this.bedrooms,
    this.bathrooms,
    this.condition,
    this.furnishing,
  });

  Details.fromJson(Map<String, dynamic> json) {
    floor = json['floor'];
    bedrooms = json['bedrooms'];
    bathrooms = json['bathrooms'];
    condition = json['condition'];
    furnishing = json['furnishing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['floor'] = floor;
    data['bedrooms'] = bedrooms;
    data['bathrooms'] = bathrooms;
    data['condition'] = condition;
    data['furnishing'] = furnishing;
    return data;
  }
}

class Features {
  bool? hasParking;
  bool? hasElevator;

  Features({this.hasParking, this.hasElevator});

  Features.fromJson(Map<String, dynamic> json) {
    hasParking = json['hasParking'];
    hasElevator = json['hasElevator'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hasParking'] = hasParking;
    data['hasElevator'] = hasElevator;
    return data;
  }
}
