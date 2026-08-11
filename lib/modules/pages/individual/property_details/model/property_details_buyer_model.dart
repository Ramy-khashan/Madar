// class PropertyDetailsModel {
//   String? propertyId;
//   String? title;
//   String? projectName;
//   String? type;
//   String? listingType;
//   int? price;
//   int? totalArea;
//   String? paymentType;
//   String? description;
//   bool? isNegotiable;
//   String? status;
//   String? context;
//   bool? isActive;
//   String? createdAt;
//   Details? details;
//   Features? features;
//   Location? location;
//   List<Media>? media;
//   List<Deeds>? deeds;
//   int? evaluation;
//   Owner? owner;
//   Broker? broker;
//   ParentProperty? parentProperty;
//   List<ChildProperties>? childProperties;
//   String? publicationStatus;
//   List<Contracts>? contracts;
//   List<Expenses>? expenses;
//   FinancialPerformance? financialPerformance;

//   PropertyDetailsModel({
//     this.propertyId,
//     this.title,
//     this.projectName,
//     this.type,
//     this.listingType,
//     this.price,
//     this.totalArea,
//     this.paymentType,
//     this.description,
//     this.isNegotiable,
//     this.status,
//     this.context,
//     this.isActive,
//     this.createdAt,
//     this.details,
//     this.features,
//     this.location,
//     this.media,
//     this.deeds,
//     this.evaluation,
//     this.owner,
//     this.broker,
//     this.parentProperty,
//     this.childProperties,
//     this.publicationStatus,
//     this.contracts,
//     this.expenses,
//     this.financialPerformance,
//   });

//   PropertyDetailsModel.fromJson(Map<String, dynamic> json) {
//     propertyId = json['propertyId'];
//     title = json['title'];
//     projectName = json['projectName'];
//     type = json['type'];
//     listingType = json['listingType'];
//     price = json['price'];
//     totalArea = json['totalArea'];
//     paymentType = json['paymentType'];
//     description = json['description'];
//     isNegotiable = json['isNegotiable'];
//     status = json['status'];
//     context = json['context'];
//     isActive = json['isActive'];
//     createdAt = json['createdAt'];
//     details = json['details'] != null
//         ? Details.fromJson(json['details'])
//         : null;
//     features = json['features'] != null
//         ? Features.fromJson(json['features'])
//         : null;
//     location = json['location'] != null
//         ? Location.fromJson(json['location'])
//         : null;
//     if (json['media'] != null) {
//       media = <Media>[];
//       json['media'].forEach((v) {
//         media!.add(Media.fromJson(v));
//       });
//     }
//     if (json['deeds'] != null) {
//       deeds = <Deeds>[];
//       json['deeds'].forEach((v) {
//         deeds!.add(Deeds.fromJson(v));
//       });
//     }
//     evaluation = json['evaluation'];
//     owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
//     broker = json['broker'] != null ? Broker.fromJson(json['broker']) : null;
//     parentProperty = json['parentProperty'] != null
//         ? ParentProperty.fromJson(json['parentProperty'])
//         : null;
//     if (json['childProperties'] != null) {
//       childProperties = <ChildProperties>[];
//       json['childProperties'].forEach((v) {
//         childProperties!.add(ChildProperties.fromJson(v));
//       });
//     }
//     publicationStatus = json['publicationStatus'];
//     if (json['contracts'] != null) {
//       contracts = <Contracts>[];
//       json['contracts'].forEach((v) {
//         contracts!.add(Contracts.fromJson(v));
//       });
//     }
//     if (json['expenses'] != null) {
//       expenses = <Expenses>[];
//       json['expenses'].forEach((v) {
//         expenses!.add(Expenses.fromJson(v));
//       });
//     }
//     financialPerformance = json['financialPerformance'] != null
//         ? FinancialPerformance.fromJson(json['financialPerformance'])
//         : null;
//   }
//  }

// class Details {
//   String? condition;
//   int? shopsCount;
//   int? floorsCount;
//   bool? hasElevator;
//   int? parkingSpots;
//   String? developerName;
//   int? occupancyRate;
//   String? classification;
//   int? estimatedIncome;
//   int? totalApartments;

//   Details({
//     this.condition,
//     this.shopsCount,
//     this.floorsCount,
//     this.hasElevator,
//     this.parkingSpots,
//     this.developerName,
//     this.occupancyRate,
//     this.classification,
//     this.estimatedIncome,
//     this.totalApartments,
//   });

//   Details.fromJson(Map<String, dynamic> json) {
//     condition = json['condition'];
//     shopsCount = json['shopsCount'];
//     floorsCount = json['floorsCount'];
//     hasElevator = json['hasElevator'];
//     parkingSpots = json['parkingSpots'];
//     developerName = json['developerName'];
//     occupancyRate = json['occupancyRate'];
//     classification = json['classification'];
//     estimatedIncome = json['estimatedIncome'];
//     totalApartments = json['totalApartments'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['condition'] = condition;
//     data['shopsCount'] = shopsCount;
//     data['floorsCount'] = floorsCount;
//     data['hasElevator'] = hasElevator;
//     data['parkingSpots'] = parkingSpots;
//     data['developerName'] = developerName;
//     data['occupancyRate'] = occupancyRate;
//     data['classification'] = classification;
//     data['estimatedIncome'] = estimatedIncome;
//     data['totalApartments'] = totalApartments;
//     return data;
//   }
// }

// class Features {
//   bool? hasParking;
//   bool? hasGenerator;
//   bool? hasWaterTank;

//   Features({this.hasParking, this.hasGenerator, this.hasWaterTank});

//   Features.fromJson(Map<String, dynamic> json) {
//     hasParking = json['hasParking'];
//     hasGenerator = json['hasGenerator'];
//     hasWaterTank = json['hasWaterTank'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['hasParking'] = hasParking;
//     data['hasGenerator'] = hasGenerator;
//     data['hasWaterTank'] = hasWaterTank;
//     return data;
//   }
// }

// class Location {
//   String? id;
//   String? city;
//   String? district;
//   String? street;
//   double? latitude;
//   double? longitude;
//   List<Nearby>? nearby;
//   String? propertyId;

//   Location({
//     this.id,
//     this.city,
//     this.district,
//     this.street,
//     this.latitude,
//     this.longitude,
//     this.nearby,
//     this.propertyId,
//   });

//   Location.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     city = json['city'];
//     district = json['district'];
//     street = json['street'];
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//     if (json['nearby'] != null) {
//       nearby = <Nearby>[];
//       json['nearby'].forEach((v) {
//         nearby!.add(Nearby.fromJson(v));
//       });
//     }
//     propertyId = json['propertyId'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['city'] = city;
//     data['district'] = district;
//     data['street'] = street;
//     data['latitude'] = latitude;
//     data['longitude'] = longitude;
//     if (nearby != null) {
//       data['nearby'] = nearby!.map((v) => v.toJson()).toList();
//     }
//     data['propertyId'] = propertyId;
//     return data;
//   }
// }

// class Nearby {
//   String? title;
//   double? lat;
//   double? long;

//   Nearby({this.title, this.lat, this.long});

//   Nearby.fromJson(Map<String, dynamic> json) {
//     title = json['title'];
//     lat = json['lat'];
//     long = json['long'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['title'] = title;
//     data['lat'] = lat;
//     data['long'] = long;
//     return data;
//   }
// }

// class Media {
//   String? id;
//   String? propertyId;
//   String? type;
//   String? url;
//   bool? isMain;
//   int? order;
//   String? createdAt;

//   Media({
//     this.id,
//     this.propertyId,
//     this.type,
//     this.url,
//     this.isMain,
//     this.order,
//     this.createdAt,
//   });

//   Media.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     propertyId = json['propertyId'];
//     type = json['type'];
//     url = json['url'];
//     isMain = json['isMain'];
//     order = json['order'];
//     createdAt = json['createdAt'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['propertyId'] = propertyId;
//     data['type'] = type;
//     data['url'] = url;
//     data['isMain'] = isMain;
//     data['order'] = order;
//     data['createdAt'] = createdAt;
//     return data;
//   }
// }

// class Deeds {
//   String? title;
//   String? data;

//   Deeds({this.title, this.data});

//   Deeds.fromJson(Map<String, dynamic> json) {
//     title = json['title'];
//     data = json['data'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['title'] = title;
//     data['data'] = this.data;
//     return data;
//   }
// }

// class Owner {
//   String? userId;
//   String? fullName;
//   String? role;

//   Owner({this.userId, this.fullName, this.role});

//   Owner.fromJson(Map<String, dynamic> json) {
//     userId = json['user_id'];
//     fullName = json['fullName'];
//     role = json['role'];
//   }

   
// }
// class Broker {
//   String? userId;
//   String? fullName;
//   String? role;
//   String? falLicenseNumber;
//   String? adLicenseNumber;
//   int? totalProperties;
//   bool? isVerified;

//   Broker({this.userId, this.fullName, this.role, this.falLicenseNumber, this.adLicenseNumber, this.totalProperties, this.isVerified});

//   Broker.fromJson(Map<String, dynamic> json) {
//     userId = json['user_id'];
//     fullName = json['fullName'];
//     role = json['role'];
//     falLicenseNumber = json['fal_license_number'];
//     adLicenseNumber = json['ad_license_number'];
//     totalProperties = json['total_properties'];
//     isVerified = json['is_verified'];
//   }

   
// }

// class ParentProperty {
//   String? title;

//   ParentProperty({this.title});

//   ParentProperty.fromJson(Map<String, dynamic> json) {
//     title = json['title'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['title'] = title;
//     return data;
//   }
// }

// class ChildProperties {
//   String? propertyId;
//   String? title;
//   String? type;
//   String? status;
//   String? listingType;
//   int? price;
//   bool? isActive;
//   String? mainImage;

//   ChildProperties({
//     this.propertyId,
//     this.title,
//     this.type,
//     this.status,
//     this.listingType,
//     this.price,
//     this.isActive,
//     this.mainImage,
//   });

//   ChildProperties.fromJson(Map<String, dynamic> json) {
//     propertyId = json['propertyId'];
//     title = json['title'];
//     type = json['type'];
//     status = json['status'];
//     listingType = json['listingType'];
//     price = json['price'];
//     isActive = json['isActive'];
//     mainImage = json['mainImage'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['propertyId'] = propertyId;
//     data['title'] = title;
//     data['type'] = type;
//     data['status'] = status;
//     data['listingType'] = listingType;
//     data['price'] = price;
//     data['isActive'] = isActive;
//     data['mainImage'] = mainImage;
//     return data;
//   }
// }

// class Contracts {
//   String? title;
//   String? info;

//   Contracts({this.title, this.info});

//   Contracts.fromJson(Map<String, dynamic> json) {
//     title = json['title'];
//     info = json['info'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['title'] = title;
//     data['info'] = info;
//     return data;
//   }
// }

// class Expenses {
//   String? title;
//   String? details;

//   Expenses({this.title, this.details});

//   Expenses.fromJson(Map<String, dynamic> json) {
//     title = json['title'];
//     details = json['details'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['title'] = title;
//     data['details'] = details;
//     return data;
//   }
// }

// class FinancialPerformance {
//   int? totalChildUnits;

//   FinancialPerformance({this.totalChildUnits});

//   FinancialPerformance.fromJson(Map<String, dynamic> json) {
//     totalChildUnits = json['totalChildUnits'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['totalChildUnits'] = totalChildUnits;
//     return data;
//   }
// }
