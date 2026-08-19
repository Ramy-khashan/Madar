// class WishlistModel {
//   String? id;
//   String? userId;
//   String? propertyId;
//   String? createdAt;
//   Property? property;

//   WishlistModel(
//       {this.id, this.userId, this.propertyId, this.createdAt, this.property});

//   WishlistModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['userId'];
//     propertyId = json['propertyId'];
//     createdAt = json['createdAt'];
//     property = json['property'] != null
//         ? new Property.fromJson(json['property'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['userId'] = this.userId;
//     data['propertyId'] = this.propertyId;
//     data['createdAt'] = this.createdAt;
//     if (this.property != null) {
//       data['property'] = this.property!.toJson();
//     }
//     return data;
//   }
// }

// class Property {
//   String? propertyId;
//   String? projectName;
//   int? price;
//   Null? propertyNo;
//   String? description;
//   bool? isActive;
//   String? ownerId;
//   String? createdAt;
//   String? updatedAt;
//   String? status;
//   String? brokerProfileId;
//   Details? details;
//   Features? features;
//   bool? isNegotiable;
//   String? listingType;
//   String? title;
//   int? totalArea;
//   String? facadeDirection;
//   int? streetsCount;
//   int? streetWidth;
//   String? type;
//   String? paymentType;
//   String? context;
//   String? adLicenseNumber;
//   String? propertyAge;

//   Property(
//       {this.propertyId,
//       this.projectName,
//       this.price,
//       this.propertyNo,
//       this.description,
//       this.isActive,
//       this.ownerId,
//       this.createdAt,
//       this.updatedAt,
//       this.status,
//       this.brokerProfileId,
//       this.details,
//       this.features,
//       this.isNegotiable,
//       this.listingType,
//       this.title,
//       this.totalArea,
//       this.facadeDirection,
//       this.streetsCount,
//       this.streetWidth,
//       this.type,
//       this.paymentType,
//       this.context,
//       this.adLicenseNumber,
//       this.propertyAge});

//   Property.fromJson(Map<String, dynamic> json) {
//     propertyId = json['property_id'];
//     projectName = json['projectName'];
//     price = json['price'];
//     propertyNo = json['propertyNo'];
//     description = json['description'];
//     isActive = json['isActive'];
//     ownerId = json['ownerId'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     status = json['status'];
//     brokerProfileId = json['brokerProfileId'];
//     details =
//         json['details'] != null ? new Details.fromJson(json['details']) : null;
//     features = json['features'] != null
//         ? new Features.fromJson(json['features'])
//         : null;
//     isNegotiable = json['isNegotiable'];
//     listingType = json['listingType'];
//     title = json['title'];
//     totalArea = json['totalArea'];
//     facadeDirection = json['facadeDirection'];
//     streetsCount = json['streetsCount'];
//     streetWidth = json['streetWidth'];
//     type = json['type'];
//     paymentType = json['paymentType'];
//     context = json['context'];
//     adLicenseNumber = json['adLicenseNumber'];
//     propertyAge = json['propertyAge'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['property_id'] = this.propertyId;
//     data['projectName'] = this.projectName;
//     data['price'] = this.price;
//     data['propertyNo'] = this.propertyNo;
//     data['description'] = this.description;
//     data['isActive'] = this.isActive;
//     data['ownerId'] = this.ownerId;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['status'] = this.status;
//     data['brokerProfileId'] = this.brokerProfileId;
//     if (this.details != null) {
//       data['details'] = this.details!.toJson();
//     }
//     if (this.features != null) {
//       data['features'] = this.features!.toJson();
//     }
//     data['isNegotiable'] = this.isNegotiable;
//     data['listingType'] = this.listingType;
//     data['title'] = this.title;
//     data['totalArea'] = this.totalArea;
//     data['facadeDirection'] = this.facadeDirection;
//     data['streetsCount'] = this.streetsCount;
//     data['streetWidth'] = this.streetWidth;
//     data['type'] = this.type;
//     data['paymentType'] = this.paymentType;
//     data['context'] = this.context;
//     data['adLicenseNumber'] = this.adLicenseNumber;
//     data['propertyAge'] = this.propertyAge;
//     return data;
//   }
// }

// class Details {
//   bool? hasFence;
//   String? soilType;
//   int? builtArea;
//   int? totalArea;
//   int? wellDepth;
//   int? wellsCount;
//   bool? hasRestHouse;
//   List<String>? waterSources;
//   int? distanceToCity;
//   bool? hasElectricity;
//   int? palmTreesCount;
//   bool? hasLivestockSheds;

//   Details(
//       {this.hasFence,
//       this.soilType,
//       this.builtArea,
//       this.totalArea,
//       this.wellDepth,
//       this.wellsCount,
//       this.hasRestHouse,
//       this.waterSources,
//       this.distanceToCity,
//       this.hasElectricity,
//       this.palmTreesCount,
//       this.hasLivestockSheds});

//   Details.fromJson(Map<String, dynamic> json) {
//     hasFence = json['hasFence'];
//     soilType = json['soilType'];
//     builtArea = json['builtArea'];
//     totalArea = json['totalArea'];
//     wellDepth = json['wellDepth'];
//     wellsCount = json['wellsCount'];
//     hasRestHouse = json['hasRestHouse'];
//     waterSources = json['waterSources'].cast<String>();
//     distanceToCity = json['distanceToCity'];
//     hasElectricity = json['hasElectricity'];
//     palmTreesCount = json['palmTreesCount'];
//     hasLivestockSheds = json['hasLivestockSheds'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['hasFence'] = this.hasFence;
//     data['soilType'] = this.soilType;
//     data['builtArea'] = this.builtArea;
//     data['totalArea'] = this.totalArea;
//     data['wellDepth'] = this.wellDepth;
//     data['wellsCount'] = this.wellsCount;
//     data['hasRestHouse'] = this.hasRestHouse;
//     data['waterSources'] = this.waterSources;
//     data['distanceToCity'] = this.distanceToCity;
//     data['hasElectricity'] = this.hasElectricity;
//     data['palmTreesCount'] = this.palmTreesCount;
//     data['hasLivestockSheds'] = this.hasLivestockSheds;
//     return data;
//   }
// }

// class Features {
//   bool? hasFence;
//   bool? hasIrrigation;
//   bool? hasElectricity;

//   Features({this.hasFence, this.hasIrrigation, this.hasElectricity});

//   Features.fromJson(Map<String, dynamic> json) {
//     hasFence = json['hasFence'];
//     hasIrrigation = json['hasIrrigation'];
//     hasElectricity = json['hasElectricity'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['hasFence'] = this.hasFence;
//     data['hasIrrigation'] = this.hasIrrigation;
//     data['hasElectricity'] = this.hasElectricity;
//     return data;
//   }
// }
