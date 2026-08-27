class ContractModel {
  String? id;
  String? contractNo;
  String? listingTitle;
  String? propertyId;
  String? location;
  String? buyerId;
  String? sellerId;
  String? brokerId;
  String? type;
  String? typeLabel;
  String? subLabel;
  String? status;
  String? statusLabel;
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
    this.listingTitle,
    this.propertyId,
    this.location,
    this.buyerId,
    this.sellerId,
    this.brokerId,
    this.type,
    this.typeLabel,
    this.subLabel,
    this.status,
    this.statusLabel,
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

  String get title =>
      (listingTitle ?? '').trim().isNotEmpty
          ? listingTitle!
          : (contractNo ?? '');
  String get propertyName =>
      (location ?? '').trim().isNotEmpty
          ? location!
          : (property?.title ?? property?.projectName ?? '');
  String get date {
    final raw = createdAt ?? startDate ?? '';
    final parsed = DateTime.tryParse(raw);
    if (parsed == null) return raw;
    final local = parsed.toLocal();
    final y = local.year.toString().padLeft(4, '0');
    final m = local.month.toString().padLeft(2, '0');
    final d = local.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  double get amount => (price ?? 0).toDouble();

  ContractModel.fromJson(Map<String, dynamic> json) {
    final propertyMap = json['property'] is Map
        ? Map<String, dynamic>.from(json['property'] as Map)
        : null;
    id = _text(json['contractId'] ?? json['id']);
    contractNo = _text(json['contractNo']);
    listingTitle = _text(json['title']);
    propertyId = _text(
      json['propertyId'] ?? json['property_id'] ?? propertyMap?['property_id'],
    );
    location = _locationFrom(json['location'] ?? propertyMap?['location']);
    buyerId = _text(json['buyerId']);
    sellerId = _text(json['sellerId']);
    brokerId = _text(json['brokerId']);
    type = _text(json['type']);
    typeLabel = _text(json['typeLabel'] ?? json['subLabel']);
    subLabel = _text(json['subLabel']);
    status = _text(json['status']);
    statusLabel = _text(json['statusLabel']);
    price = _asInt(json['price'] ?? propertyMap?['price']);
    startDate = _text(json['startDate']);
    endDate = _text(json['endDate']);
    createdAt = _text(json['date'] ?? json['createdAt']);
    commissionAmount = _asInt(json['commissionAmount']);
    buyer = json['buyer'] is Map
        ? Buyer.fromJson(Map<String, dynamic>.from(json['buyer'] as Map))
        : null;
    seller = json['seller'] is Map
        ? Buyer.fromJson(Map<String, dynamic>.from(json['seller'] as Map))
        : null;
    final brokerRaw = json['broker'];
    if (brokerRaw is Map) {
      broker = _text(brokerRaw['fullName']);
    } else {
      broker = _text(brokerRaw);
    }
    property = propertyMap == null ? null : Property.fromJson(propertyMap);
  }

  static String? _text(dynamic value) {
    if (value == null) return null;
    final text = value.toString().trim();
    if (text.isEmpty || text == 'null') return null;
    return text;
  }

  static int? _asInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '');
  }

  static String? _locationFrom(dynamic value) {
    if (value == null) return null;
    if (value is String) return _text(value);
    if (value is Map) {
      final map = Map<String, dynamic>.from(value);
      final parts = [
        _text(map['district']),
        _text(map['city']),
      ].whereType<String>().where((e) => e.isNotEmpty);
      final joined = parts.join('، ');
      return joined.isEmpty ? null : joined;
    }
    return null;
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
