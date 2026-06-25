 class PropertiesItemModel {
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
  Location? location;
  List<Media>? media;
  List<Deeds>? deeds;
  Owner? owner;
  BrokerProfile? brokerProfile;
  List<PublicationRequests>? publicationRequests;

  PropertiesItemModel(
      {this.propertyId,
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
      this.location,
      this.media,
      this.deeds,
      this.owner,
      this.brokerProfile,
      this.publicationRequests});

  PropertiesItemModel.fromJson(Map<String, dynamic> json) {
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
    details =
        json['details'] != null ? Details.fromJson(json['details']) : null;
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
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media!.add(Media.fromJson(v));
      });
    }
    if (json['deeds'] != null) {
      deeds = <Deeds>[];
      json['deeds'].forEach((v) {
        deeds!.add(Deeds.fromJson(v));
      });
    }
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    brokerProfile = json['brokerProfile'] != null
        ? BrokerProfile.fromJson(json['brokerProfile'])
        : null;
    if (json['publicationRequests'] != null) {
      publicationRequests = <PublicationRequests>[];
      json['publicationRequests'].forEach((v) {
        publicationRequests!.add(PublicationRequests.fromJson(v));
      });
    }
  }
 }

class Details {
  int? bedrooms;
  int? councils;
  int? kitchens;
  bool? maidRoom;
  int? bathrooms;
  String? condition;
  bool? hasGarden;
  bool? driverRoom;
  String? furnishing;
  int? gardenArea;
  int? floorsCount;
  int? livingRooms;
  String? developerName;
  bool? hasTwoEntrances;

  Details(
      {this.bedrooms,
      this.councils,
      this.kitchens,
      this.maidRoom,
      this.bathrooms,
      this.condition,
      this.hasGarden,
      this.driverRoom,
      this.furnishing,
      this.gardenArea,
      this.floorsCount,
      this.livingRooms,
      this.developerName,
      this.hasTwoEntrances});

  Details.fromJson(Map<String, dynamic> json) {
    bedrooms = json['bedrooms'];
    councils = json['councils'];
    kitchens = json['kitchens'];
    maidRoom = json['maidRoom'];
    bathrooms = json['bathrooms'];
    condition = json['condition'];
    hasGarden = json['hasGarden'];
    driverRoom = json['driverRoom'];
    furnishing = json['furnishing'];
    gardenArea = json['gardenArea'];
    floorsCount = json['floorsCount'];
    livingRooms = json['livingRooms'];
    developerName = json['developerName'];
    hasTwoEntrances = json['hasTwoEntrances'];
  }
 }

class Features {
  bool? hasPool;
  bool? hasParking;
  bool? hasSecurity;

  Features({this.hasPool, this.hasParking, this.hasSecurity});

  Features.fromJson(Map<String, dynamic> json) {
    hasPool = json['hasPool'];
    hasParking = json['hasParking'];
    hasSecurity = json['hasSecurity'];
  }
 
}

class Location {
  String? id;
  String? city;
  String? district;
  String? street;
  double? latitude;
  double? longitude;
  List<String>? nearby;
  String? propertyId;

  Location(
      {this.id,
      this.city,
      this.district,
      this.street,
      this.latitude,
      this.longitude,
      this.nearby,
      this.propertyId});

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    city = json['city'];
    district = json['district'];
    street = json['street'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    if (json['nearby'] != null) {
      nearby = <String>[];
      json['nearby'].forEach((v) {
        nearby!.add(v.toString());
      });
    }
    propertyId = json['propertyId'];
  }
 
}

class Media {
  String? id;
  String? propertyId;
  String? type;
  String? url;
  bool? isMain;
  int? order;
  String? createdAt;

  Media(
      {this.id,
      this.propertyId,
      this.type,
      this.url,
      this.isMain,
      this.order,
      this.createdAt});

  Media.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    propertyId = json['propertyId'];
    type = json['type'];
    url = json['url'];
    isMain = json['isMain'];
    order = json['order'];
    createdAt = json['createdAt'];
  }
}
class Deeds {
  String? id;
  String? propertyId;
  String? deedType;
  String? documentNumber;
  String? customTypeName;
  String? fileUrl;
  String? calendarType;
  String? deedDate;
  String? createdAt;

  Deeds(
      {this.id,
      this.propertyId,
      this.deedType,
      this.documentNumber,
      this.customTypeName,
      this.fileUrl,
      this.calendarType,
      this.deedDate,
      this.createdAt});

  Deeds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    propertyId = json['propertyId'];
    deedType = json['deedType'];
    documentNumber = json['documentNumber'];
    customTypeName = json['customTypeName'];
    fileUrl = json['fileUrl'];
    calendarType = json['calendarType'];
    deedDate = json['deedDate'];
    createdAt = json['createdAt'];
  } }

class Owner {
  String? userId;
  String? fullName;

  Owner({this.userId, this.fullName});

  Owner.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    fullName = json['fullName'];
  }
 
}

class BrokerProfile {
  String? id;
  String? status;

  BrokerProfile({this.id, this.status});

  BrokerProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
  }
 
}

class PublicationRequests {
  String? id;
  String? propertyId;
  String? brokerProfileId;
  String? userId;
  String? status;
  double? commissionRate;
  int? commissionAmount;
  String? commissionPayer;
  String? createdAt;
  String? updatedAt;

  PublicationRequests(
      {this.id,
      this.propertyId,
      this.brokerProfileId,
      this.userId,
      this.status,
      this.commissionRate,
      this.commissionAmount,
      this.commissionPayer,
      this.createdAt,
      this.updatedAt});

  PublicationRequests.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    propertyId = json['propertyId'];
    brokerProfileId = json['brokerProfileId'];
    userId = json['userId'];
    status = json['status'];
    commissionRate = json['commissionRate'];
    commissionAmount = json['commissionAmount'];
    commissionPayer = json['commissionPayer'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
 }

class Pagination {
  int? total;
  int? page;
  int? limit;
  int? totalPages;

  Pagination({this.total, this.page, this.limit, this.totalPages});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    page = json['page'];
    limit = json['limit'];
    totalPages = json['totalPages'];
  }
 
}