/// Unified Property Details Model
/// Handles all property types: Apartment, Villa, Floor, Farm
class PropertyDetailsModel {
  String? propertyId;
  String? title;
  String? projectName;
  String? type;
  String? listingType;
  int? price;
  int? totalArea;
  String? facadeDirection; // Not used in Apartment
  dynamic streetsCount; // String in some models, int in others
  dynamic streetWidth; // String in some models, int in others
  String? paymentType;
  String? description;
  bool? isNegotiable;
  String? status;
  String? context;
  bool? isActive;
  String? createdAt;
  PropertyDetails? details;
  PropertyFeatures? features;
  PropertyLocation? location;
  List<PropertyMedia>? media;
  List<PropertyDeeds>? deeds;
  PropertyEvaluation? evaluation;
  PropertyOwner? owner;
  Publisher? publisher;
  ParentProperty? parentProperty;
  List<ChildProperty>? childProperties;
  String? publicationStatus;
  List<PropertyContract>? contracts;
  List<PropertyExpense>? expenses;
  FinancialPerformance? financialPerformance;

  PropertyDetailsModel({
    this.propertyId,
    this.title,
    this.projectName,
    this.type,
     this.listingType,
    this.price,
    this.totalArea,
    this.facadeDirection,
    this.streetsCount,
    this.streetWidth,
    this.paymentType,
    this.description,
    this.isNegotiable,
    this.status,
    this.context,
    this.isActive,
    this.createdAt,
    this.details,
    this.features,
    this.location,
    this.media,
    this.deeds,
    this.evaluation,
    this.owner,
    this.publisher,
    this.parentProperty,
    this.childProperties,
    this.publicationStatus,
    this.contracts,
    this.expenses,
    this.financialPerformance,
  });

  factory PropertyDetailsModel.fromJson(Map<String, dynamic> json) {
    // Handle Apartment wrapper structure (success + data)
    if (json.containsKey('success') && json.containsKey('data')) {
      json = json['data'] ?? {};
    }

    return PropertyDetailsModel(
      propertyId: json['propertyId'],
      title: json['title'],
      projectName: json['projectName'],
      type: json['type'],
      listingType: json['listingType'],
      price: json['price'],
      totalArea: json['totalArea'],
      facadeDirection: json['facadeDirection'],
      streetsCount: json['streetsCount'],
      streetWidth: json['streetWidth'],
      paymentType: json['paymentType'],
      description: json['description'],
      isNegotiable: json['isNegotiable'],
      status: json['status'],
      context: json['context'],
      isActive: json['isActive'],
      createdAt: json['createdAt'],
      details: json['details'] != null
          ? PropertyDetails.fromJson(json['details'])
          : null,
      features: json['features'] != null
          ? PropertyFeatures.fromJson(json['features'])
          : null,
      location: json['location'] != null
          ? PropertyLocation.fromJson(json['location'])
          : null,
      media: json['media'] != null
          ? (json['media'] as List)
                .map((v) => PropertyMedia.fromJson(v))
                .toList()
          : null,
      deeds: json['deeds'] != null
          ? (json['deeds'] as List)
                .map((v) => PropertyDeeds.fromJson(v))
                .toList()
          : null,
      evaluation: json['evaluation'] != null
          ? PropertyEvaluation.fromJson(json['evaluation'])
          : null,
      owner: json['owner'] != null
          ? PropertyOwner.fromJson(json['owner'])
          : null,
      publisher: json['publisher'] != null
          ? Publisher.fromJson(json['publisher'])
          : null,
      parentProperty: json['parentProperty'] != null
          ? ParentProperty.fromJson(json['parentProperty'])
          : null,
      childProperties: json['childProperties'] != null
          ? (json['childProperties'] as List)
                .map((v) => ChildProperty.fromJson(v))
                .toList()
          : null,
      publicationStatus: json['publicationStatus'],
      contracts: json['contracts'] != null
          ? (json['contracts'] as List)
                .map((v) => PropertyContract.fromJson(v))
                .toList()
          : null,
      expenses: json['expenses'] != null
          ? (json['expenses'] as List)
                .map((v) => PropertyExpense.fromJson(v))
                .toList()
          : null,
      financialPerformance: json['financialPerformance'] != null
          ? FinancialPerformance.fromJson(json['financialPerformance'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['propertyId'] = propertyId;
    data['title'] = title;
    data['projectName'] = projectName;
    data['type'] = type;
    data['listingType'] = listingType;
    data['price'] = price;
    data['totalArea'] = totalArea;
    if (facadeDirection != null) data['facadeDirection'] = facadeDirection;
    if (streetsCount != null) data['streetsCount'] = streetsCount;
    if (streetWidth != null) data['streetWidth'] = streetWidth;
    data['paymentType'] = paymentType;
    data['description'] = description;
    data['isNegotiable'] = isNegotiable;
    data['status'] = status;
    data['context'] = context;
    data['isActive'] = isActive;
    data['createdAt'] = createdAt;
    if (details != null) data['details'] = details!.toJson();
    if (features != null) data['features'] = features!.features;
    if (location != null) data['location'] = location!.toJson();
    if (media != null) data['media'] = media!.map((v) => v.toJson()).toList();
    if (deeds != null) data['deeds'] = deeds!.map((v) => v.toJson()).toList();
    if (evaluation != null) data['evaluation'] = evaluation!.toJson();
    if (owner != null) data['owner'] = owner!.toJson();
    if (publisher != null) data['publisher'] = publisher!.toJson();
    if (parentProperty != null) {
      data['parentProperty'] = parentProperty!.toJson();
    }
    if (childProperties != null) {
      data['childProperties'] = childProperties!
          .map((v) => v.toJson())
          .toList();
    }
    data['publicationStatus'] = publicationStatus;
    if (contracts != null) {
      data['contracts'] = contracts!.map((v) => v.toJson()).toList();
    }
    if (expenses != null) {
      data['expenses'] = expenses!.map((v) => v.toJson()).toList();
    }
    if (financialPerformance != null) {
      data['financialPerformance'] = financialPerformance!.toJson();
    }
    return data;
  }
}

/// Unified Details class that handles all property types
class PropertyDetails {
  int? area;
  int? totalArea;
  int? builtArea;
  int? height;
  int? bedrooms;
  int? bathrooms;
  int? councils;
  int? kitchens;
  int? livingRooms;
  int? roomsCount;
  bool? maidRoom;
  bool? driverRoom;
  int? floor;
  int? floorsCount;
  int? allowedFloors;
  String? condition;
  String? classification;
  String? furnishing;
  bool? hasGarden;
  int? gardenArea;
  bool? hasPrivateGarden;
  bool? hasTwoEntrances;
  bool? hasPantry;
  bool? hasReception;
  bool? hasMeetingRoom;
  bool? furnishedOffice;
  bool? hasElevator;
  bool? hasCentralAC;
  bool? hasAC;
  int? parkingSpots;
  String? doorType;
  int? doorsCount;
  String? truckAccess;
  String? floorType;
  bool? hasOffice;
  bool? hasYard;
  int? yardArea;
  String? coolingType;
  int? electricityKW;
  String? mallName;
  List<String>? activities;
  String? locationType;
  int? frontWidth;
  bool? hasStorage;
  bool? hasBathroom;
  bool? hasWaterMeter;
  bool? hasElectricMeter;
  bool? hasPrivateEntrance;
  bool? hasRoof;
  String? soilType;
  bool? hasFence;
  int? wellDepth;
  int? wellsCount;
  bool? hasRestHouse;
  List<String>? waterSources;
  int? distanceToCity;
  bool? hasElectricity;
  int? palmTreesCount;
  bool? hasLivestockSheds;
  String? name;
  List<String>? views;
  List<String>? amenities;
  List<String>? facilities;
  int? yearBuilt;
  int? totalUnits;
  int? totalParking;
  int? parkingFloors;
  int? elevatorsCount;
  String? developerName;
  String? compoundName;
  List<String>? services;
  Dimensions? dimensions;
  String? planNumber;
  String? plotNumber;
  int? buildingRatio;
  int? shopsCount;
  int? occupancyRate;
  int? estimatedIncome;
  int? totalApartments;
  int? serviceFee;
  int? electricityKWShop;

  PropertyDetails({
    this.area,
    this.totalArea,
    this.builtArea,
    this.height,
    this.bedrooms,
    this.bathrooms,
    this.councils,
    this.kitchens,
    this.livingRooms,
    this.roomsCount,
    this.maidRoom,
    this.driverRoom,
    this.floor,
    this.floorsCount,
    this.allowedFloors,
    this.condition,
    this.classification,
    this.furnishing,
    this.hasGarden,
    this.gardenArea,
    this.hasPrivateGarden,
    this.hasTwoEntrances,
    this.hasPantry,
    this.hasReception,
    this.hasMeetingRoom,
    this.furnishedOffice,
    this.hasElevator,
    this.hasCentralAC,
    this.hasAC,
    this.parkingSpots,
    this.doorType,
    this.doorsCount,
    this.truckAccess,
    this.floorType,
    this.hasOffice,
    this.hasYard,
    this.yardArea,
    this.coolingType,
    this.electricityKW,
    this.mallName,
    this.activities,
    this.locationType,
    this.frontWidth,
    this.hasStorage,
    this.hasBathroom,
    this.hasWaterMeter,
    this.hasElectricMeter,
    this.hasPrivateEntrance,
    this.hasRoof,
    this.soilType,
    this.hasFence,
    this.wellDepth,
    this.wellsCount,
    this.hasRestHouse,
    this.waterSources,
    this.distanceToCity,
    this.hasElectricity,
    this.palmTreesCount,
    this.hasLivestockSheds,
    this.name,
    this.views,
    this.amenities,
    this.facilities,
    this.yearBuilt,
    this.totalUnits,
    this.totalParking,
    this.parkingFloors,
    this.elevatorsCount,
    this.developerName,
    this.compoundName,
    this.services,
    this.dimensions,
    this.planNumber,
    this.plotNumber,
    this.buildingRatio,
    this.shopsCount,
    this.occupancyRate,
    this.estimatedIncome,
    this.totalApartments,
    this.serviceFee,
    this.electricityKWShop,
  });

  PropertyDetails.fromJson(Map<String, dynamic> json) {
    area = json['area'];
    totalArea = json['totalArea'];
    builtArea = json['builtArea'];
    height = json['height'];
    bedrooms = json['bedrooms'];
    bathrooms = json['bathrooms'];
    councils = json['councils'];
    kitchens = json['kitchens'];
    livingRooms = json['livingRooms'];
    roomsCount = json['roomsCount'];
    maidRoom = json['maidRoom'];
    driverRoom = json['driverRoom'];
    floor = json['floor'];
    floorsCount = json['floorsCount'];
    allowedFloors = json['allowedFloors'];
    condition = json['condition'];
    classification = json['classification'];
    furnishing = json['furnishing'];
    hasGarden = json['hasGarden'];
    gardenArea = json['gardenArea'];
    hasPrivateGarden = json['hasPrivateGarden'];
    hasTwoEntrances = json['hasTwoEntrances'];
    hasPantry = json['hasPantry'];
    hasReception = json['hasReception'];
    hasMeetingRoom = json['hasMeetingRoom'];
    furnishedOffice = json['furnishedOffice'];
    hasElevator = json['hasElevator'];
    hasCentralAC = json['hasCentralAC'];
    hasAC = json['hasAC'];
    parkingSpots = json['parkingSpots'];
    doorType = json['doorType'];
    doorsCount = json['doorsCount'];
    truckAccess = json['truckAccess'];
    floorType = json['floorType'];
    hasOffice = json['hasOffice'];
    hasYard = json['hasYard'];
    yardArea = json['yardArea'];
    coolingType = json['coolingType'];
    electricityKW = json['electricityKW'];
    hasBathroom = json['hasBathroom'];
    hasWaterMeter = json['hasWaterMeter'];
    hasElectricMeter = json['hasElectricMeter'];
    hasPrivateEntrance = json['hasPrivateEntrance'];
    hasRoof = json['hasRoof'];
    mallName = json['mallName'];
    activities = (json['activities'] ?? []).cast<String>();
    locationType = json['locationType'];
    frontWidth = json['frontWidth'];
    hasStorage = json['hasStorage'];
    soilType = json['soilType'];
    hasFence = json['hasFence'];
    wellDepth = json['wellDepth'];
    wellsCount = json['wellsCount'];
    hasRestHouse = json['hasRestHouse'];
    waterSources = (json['waterSources'] ?? []).cast<String>();
    distanceToCity = json['distanceToCity'];
    hasElectricity = json['hasElectricity'];
    palmTreesCount = json['palmTreesCount'];
    hasLivestockSheds = json['hasLivestockSheds'];
    name = json['name'];
    views = (json['views'] ?? []).cast<String>();
    amenities = (json['amenities'] ?? []).cast<String>();
    facilities = (json['facilities'] ?? []).cast<String>();
    yearBuilt = json['yearBuilt'];
    totalUnits = json['totalUnits'];
    totalParking = json['totalParking'];
    parkingFloors = json['parkingFloors'];
    elevatorsCount = json['elevatorsCount'];
    developerName = json['developerName'];
    compoundName = json['compoundName'];
    services = (json['services'] ?? []).cast<String>();
    dimensions = json['dimensions'] != null
        ? Dimensions.fromJson(json['dimensions'])
        : null;
    planNumber = json['planNumber'];
    plotNumber = json['plotNumber'];
    buildingRatio = json['buildingRatio'];
    shopsCount = json['shopsCount'];
    occupancyRate = json['occupancyRate'];
    estimatedIncome = json['estimatedIncome'];
    totalApartments = json['totalApartments'];
    serviceFee = json['serviceFee'];
    electricityKWShop = json['electricityKWShop'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (area != null) data['area'] = area;
    if (totalArea != null) data['totalArea'] = totalArea;
    if (builtArea != null) data['builtArea'] = builtArea;
    if (height != null) data['height'] = height;
    if (bedrooms != null) data['bedrooms'] = bedrooms;
    if (bathrooms != null) data['bathrooms'] = bathrooms;
    if (councils != null) data['councils'] = councils;
    if (kitchens != null) data['kitchens'] = kitchens;
    if (livingRooms != null) data['livingRooms'] = livingRooms;
    if (roomsCount != null) data['roomsCount'] = roomsCount;
    if (maidRoom != null) data['maidRoom'] = maidRoom;
    if (driverRoom != null) data['driverRoom'] = driverRoom;
    if (floor != null) data['floor'] = floor;
    if (floorsCount != null) data['floorsCount'] = floorsCount;
    if (allowedFloors != null) data['allowedFloors'] = allowedFloors;
    if (condition != null) data['condition'] = condition;
    if (classification != null) data['classification'] = classification;
    if (furnishing != null) data['furnishing'] = furnishing;
    if (hasGarden != null) data['hasGarden'] = hasGarden;
    if (gardenArea != null) data['gardenArea'] = gardenArea;
    if (hasPrivateGarden != null) data['hasPrivateGarden'] = hasPrivateGarden;
    if (hasTwoEntrances != null) data['hasTwoEntrances'] = hasTwoEntrances;
    if (hasPantry != null) data['hasPantry'] = hasPantry;
    if (hasReception != null) data['hasReception'] = hasReception;
    if (hasMeetingRoom != null) data['hasMeetingRoom'] = hasMeetingRoom;
    if (furnishedOffice != null) data['furnishedOffice'] = furnishedOffice;
    if (hasElevator != null) data['hasElevator'] = hasElevator;
    if (hasCentralAC != null) data['hasCentralAC'] = hasCentralAC;
    if (hasAC != null) data['hasAC'] = hasAC;
    if (parkingSpots != null) data['parkingSpots'] = parkingSpots;
    if (doorType != null) data['doorType'] = doorType;
    if (doorsCount != null) data['doorsCount'] = doorsCount;
    if (truckAccess != null) data['truckAccess'] = truckAccess;
    if (floorType != null) data['floorType'] = floorType;
    if (hasOffice != null) data['hasOffice'] = hasOffice;
    if (hasYard != null) data['hasYard'] = hasYard;
    if (yardArea != null) data['yardArea'] = yardArea;
    if (coolingType != null) data['coolingType'] = coolingType;
    if (electricityKW != null) data['electricityKW'] = electricityKW;
    if (mallName != null) data['mallName'] = mallName;
    if (activities != null) data['activities'] = activities;
    if (locationType != null) data['locationType'] = locationType;
    if (frontWidth != null) data['frontWidth'] = frontWidth;
    if (hasStorage != null) data['hasStorage'] = hasStorage;
    if (hasBathroom != null) data['hasBathroom'] = hasBathroom;
    if (hasWaterMeter != null) data['hasWaterMeter'] = hasWaterMeter;
    if (hasElectricMeter != null) data['hasElectricMeter'] = hasElectricMeter;
    if (hasPrivateEntrance != null) {
      data['hasPrivateEntrance'] = hasPrivateEntrance;
    }
    if (hasRoof != null) data['hasRoof'] = hasRoof;
    if (soilType != null) data['soilType'] = soilType;
    if (hasFence != null) data['hasFence'] = hasFence;
    if (wellDepth != null) data['wellDepth'] = wellDepth;
    if (wellsCount != null) data['wellsCount'] = wellsCount;
    if (hasRestHouse != null) data['hasRestHouse'] = hasRestHouse;
    if (waterSources != null) data['waterSources'] = waterSources;
    if (distanceToCity != null) data['distanceToCity'] = distanceToCity;
    if (hasElectricity != null) data['hasElectricity'] = hasElectricity;
    if (palmTreesCount != null) data['palmTreesCount'] = palmTreesCount;
    if (hasLivestockSheds != null) {
      data['hasLivestockSheds'] = hasLivestockSheds;
    }
    if (name != null) data['name'] = name;
    if (views != null) data['views'] = views;
    if (amenities != null) data['amenities'] = amenities;
    if (facilities != null) data['facilities'] = facilities;
    if (yearBuilt != null) data['yearBuilt'] = yearBuilt;
    if (totalUnits != null) data['totalUnits'] = totalUnits;
    if (totalParking != null) data['totalParking'] = totalParking;
    if (parkingFloors != null) data['parkingFloors'] = parkingFloors;
    if (elevatorsCount != null) data['elevatorsCount'] = elevatorsCount;
    if (developerName != null) data['developerName'] = developerName;
    if (compoundName != null) data['compoundName'] = compoundName;
    if (services != null) data['services'] = services;
    if (dimensions != null) data['dimensions'] = dimensions!.toJson();
    if (planNumber != null) data['planNumber'] = planNumber;
    if (plotNumber != null) data['plotNumber'] = plotNumber;
    if (buildingRatio != null) data['buildingRatio'] = buildingRatio;
    if (shopsCount != null) data['shopsCount'] = shopsCount;
    if (occupancyRate != null) data['occupancyRate'] = occupancyRate;
    if (estimatedIncome != null) data['estimatedIncome'] = estimatedIncome;
    if (totalApartments != null) data['totalApartments'] = totalApartments;
    if (serviceFee != null) data['serviceFee'] = serviceFee;
    if (electricityKWShop != null) {
      data['electricityKWShop'] = electricityKWShop;
    }
    return data;
  }
}

class Dimensions {
  int? east;
  int? west;
  int? north;
  int? south;

  Dimensions({this.east, this.west, this.north, this.south});

  Dimensions.fromJson(Map<String, dynamic> json) {
    east = json['east'];
    west = json['west'];
    north = json['north'];
    south = json['south'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['east'] = east;
    data['west'] = west;
    data['north'] = north;
    data['south'] = south;
    return data;
  }
}

/// Unified Features class for all property types
class PropertyFeatures {
  final Map<String, bool> features;
  final List<String> allowedActivities;

  PropertyFeatures({required this.features, required this.allowedActivities});

  factory PropertyFeatures.fromJson(Map<String, dynamic> json) {
    return PropertyFeatures(
      features: Map<String, bool>.from(json),
      allowedActivities: List<String>.from(json['allowedActivities'] ?? []),
    );
  }
}

class PropertyLocation {
  String? id;
  String? city;
  String? district;
  String? street;
  double? latitude;
  double? longitude;
  List<NearbyPlace>? nearby;
  String? propertyId;

  PropertyLocation({
    this.id,
    this.city,
    this.district,
    this.street,
    this.latitude,
    this.longitude,
    this.nearby,
    this.propertyId,
  });

  factory PropertyLocation.fromJson(Map<String, dynamic> json) {
    return PropertyLocation(
      id: json['id'],
      city: json['city'],
      district: json['district'],
      street: json['street'],
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      nearby: json['nearby'] != null
          ? (json['nearby'] is List
                ? (json['nearby'] as List).map((v) {
                    if (v is String) {
                      return NearbyPlace(name: v);
                    }
                    return NearbyPlace.fromJson(v);
                  }).toList()
                : null)
          : null,
      propertyId: json['propertyId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['city'] = city;
    data['district'] = district;
    data['street'] = street;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    if (nearby != null) {
      data['nearby'] = nearby!.map((v) => v.toJson()).toList();
    }
    data['propertyId'] = propertyId;
    return data;
  }
}

class NearbyPlace {
  String? id;
  String? name;
  String? type;
  double? distance;

  NearbyPlace({this.id, this.name, this.type, this.distance});

  factory NearbyPlace.fromJson(Map<String, dynamic> json) {
    return NearbyPlace(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      distance: json['distance']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    data['name'] = name;
    if (type != null) data['type'] = type;
    if (distance != null) data['distance'] = distance;
    return data;
  }
}

class PropertyMedia {
  String? id;
  String? propertyId;
  String? type;
  String? url;
  bool? isMain;
  int? order;
  String? createdAt;

  PropertyMedia({
    this.id,
    this.propertyId,
    this.type,
    this.url,
    this.isMain,
    this.order,
    this.createdAt,
  });

  factory PropertyMedia.fromJson(Map<String, dynamic> json) {
    return PropertyMedia(
      id: json['id'],
      propertyId: json['propertyId'],
      type: json['type'],
      url: json['url'],
      isMain: json['isMain'],
      order: json['order'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['propertyId'] = propertyId;
    data['type'] = type;
    data['url'] = url;
    data['isMain'] = isMain;
    data['order'] = order;
    data['createdAt'] = createdAt;
    return data;
  }
}

class PropertyDeeds {
  String? id;
  String? propertyId;
  String? deedType;
  String? documentNumber;
  String? customTypeName;
  String? fileUrl;
  String? calendarType;
  String? deedDate;
  String? createdAt;

  PropertyDeeds({
    this.id,
    this.propertyId,
    this.deedType,
    this.documentNumber,
    this.customTypeName,
    this.fileUrl,
    this.calendarType,
    this.deedDate,
    this.createdAt,
  });

  factory PropertyDeeds.fromJson(Map<String, dynamic> json) {
    return PropertyDeeds(
      id: json['id'],
      propertyId: json['propertyId'],
      deedType: json['deedType'],
      documentNumber: json['documentNumber'],
      customTypeName: json['customTypeName'],
      fileUrl: json['fileUrl'],
      calendarType: json['calendarType'],
      deedDate: json['deedDate'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['propertyId'] = propertyId;
    data['deedType'] = deedType;
    data['documentNumber'] = documentNumber;
    data['customTypeName'] = customTypeName;
    data['fileUrl'] = fileUrl;
    data['calendarType'] = calendarType;
    data['deedDate'] = deedDate;
    data['createdAt'] = createdAt;
    return data;
  }
}

class PropertyEvaluation {
  String? id;
  String? userId;
  String? propertyId;
  String? status;
  int? estimatedValue;
  String? comment;
  String? location;
  int? area;
  String? purpose;
  int? minValue;
  int? maxValue;
  String? marketComparison;
  String? createdAt;
  String? updatedAt;
  String? propertyType;
  String? aiMarketAnalysis;
  String? condition;
  String? furnishing;

  PropertyEvaluation({
    this.id,
    this.userId,
    this.propertyId,
    this.status,
    this.estimatedValue,
    this.comment,
    this.location,
    this.area,
    this.purpose,
    this.minValue,
    this.maxValue,
    this.marketComparison,
    this.createdAt,
    this.updatedAt,
    this.propertyType,
    this.aiMarketAnalysis,
    this.condition,
    this.furnishing,
  });

  factory PropertyEvaluation.fromJson(Map<String, dynamic> json) {
    return PropertyEvaluation(
      id: json['id'],
      userId: json['userId'],
      propertyId: json['propertyId'],
      status: json['status'],
      estimatedValue: json['estimatedValue'],
      comment: json['comment'],
      location: json['location'],
      area: json['area'],
      purpose: json['purpose'],
      minValue: json['minValue'],
      maxValue: json['maxValue'],
      marketComparison: json['marketComparison'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      propertyType: json['propertyType'],
      aiMarketAnalysis: json['aiMarketAnalysis'],
      condition: json['condition'],
      furnishing: json['furnishing'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['propertyId'] = propertyId;
    data['status'] = status;
    data['estimatedValue'] = estimatedValue;
    data['comment'] = comment;
    data['location'] = location;
    data['area'] = area;
    data['purpose'] = purpose;
    data['minValue'] = minValue;
    data['maxValue'] = maxValue;
    data['marketComparison'] = marketComparison;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['propertyType'] = propertyType;
    data['aiMarketAnalysis'] = aiMarketAnalysis;
    data['condition'] = condition;
    data['furnishing'] = furnishing;
    return data;
  }
} 
class Publisher {
  String? userId;
  String? fullName;
  String? role;
  String? image;
  String? falLicenseNumber;
  String? adLicenseNumber;
  String? publisherType;
  int? propertiesCount;

  Publisher({
    this.userId,
    this.fullName,
    this.role,
    this.image,
    this.falLicenseNumber,
    this.adLicenseNumber,
    this.publisherType,
    this.propertiesCount,
  });

  factory Publisher.fromJson(Map<String, dynamic> json) {
    return Publisher(
      userId: json['userId'] ?? json['user_id'],
      fullName: json['fullName'],
      role: json['role'],
      image: json['image'],
      falLicenseNumber: json['falLicenseNumber'],
      adLicenseNumber: json['adLicenseNumber'],
      publisherType: json['publisherType'],
      propertiesCount: json['propertiesCount'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['fullName'] = fullName;
    data['role'] = role;
    data['image'] = image;
    data['falLicenseNumber'] = falLicenseNumber;
    data['adLicenseNumber'] = adLicenseNumber;
    data['publisherType'] = publisherType;
    data['propertiesCount'] = propertiesCount;
    return data;
  }
}
class PropertyOwner {
  String? userId;
  String? fullName;
  String? role;
  String? adLicenseNumber;
  String? falLicenseNumber;
  String? totalProperties;

  PropertyOwner({
    this.userId,
    this.fullName,
    this.role,
    this.adLicenseNumber,
    this.falLicenseNumber,
    this.totalProperties,
  });

  factory PropertyOwner.fromJson(Map<String, dynamic> json) {
    return PropertyOwner(
      userId: json['user_id'],
      fullName: json['fullName'],
      role: json['role'],
      adLicenseNumber: json['adLicenseNumber'],
      falLicenseNumber: json['falLicenseNumber'],
      totalProperties: json['totalProperties'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['fullName'] = fullName;
    data['role'] = role;
    data['adLicenseNumber'] = adLicenseNumber;
    data['falLicenseNumber'] = falLicenseNumber;
    data['totalProperties'] = totalProperties;
    return data;
  }
}

class ParentProperty {
  String? propertyId;
  String? title;
  String? type;
  String? status;

  ParentProperty({this.propertyId, this.title, this.type, this.status});

  factory ParentProperty.fromJson(Map<String, dynamic> json) {
    return ParentProperty(
      propertyId: json['property_id'],
      title: json['title'],
      type: json['type'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['property_id'] = propertyId;
    data['title'] = title;
    data['type'] = type;
    data['status'] = status;
    return data;
  }
}

class ChildProperty {
  String? propertyId;
  String? title;
  String? type;
  String? status;
  String? listingType;
  int? price;
  bool? isActive;
  String? mainImage;

  ChildProperty({
    this.propertyId,
    this.title,
    this.type,
    this.status,
    this.listingType,
    this.price,
    this.isActive,
    this.mainImage,
  });

  factory ChildProperty.fromJson(Map<String, dynamic> json) {
    return ChildProperty(
      propertyId: json['propertyId'],
      title: json['title'],
      type: json['type'],
      status: json['status'],
      listingType: json['listingType'],
      price: json['price'],
      isActive: json['isActive'],
      mainImage: json['mainImage'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['propertyId'] = propertyId;
    data['title'] = title;
    data['type'] = type;
    data['status'] = status;
    data['listingType'] = listingType;
    data['price'] = price;
    data['isActive'] = isActive;
    data['mainImage'] = mainImage;
    return data;
  }
}

class PropertyContract {
  String? id;
  String? propertyId;
  String? contractType;
  String? fileUrl;
  String? createdAt;
  String? status;
  String? startDate;
  String? endDate;
  String? name; // For Apartment legacy format

  PropertyContract({
    this.id,
    this.propertyId,
    this.contractType,
    this.fileUrl,
    this.createdAt,
    this.status,
    this.name,
    this.startDate,
    this.endDate,
  });

  factory PropertyContract.fromJson(Map<String, dynamic> json) {
    return PropertyContract(
      id: json['id'],
      propertyId: json['propertyId'],
      contractType: json['contractType'],
      fileUrl: json['fileUrl'],
      createdAt: json['createdAt'],
      name: json['name'],
      status: json['status'],
      startDate: json['startDate'],
      endDate: json['endDate'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    if (propertyId != null) data['propertyId'] = propertyId;
    if (contractType != null) data['contractType'] = contractType;
    if (fileUrl != null) data['fileUrl'] = fileUrl;
    if (createdAt != null) data['createdAt'] = createdAt;
    if (name != null) data['name'] = name;
    if (status != null) data['status'] = status;
    if (startDate != null) data['startDate'] = startDate;
    if (endDate != null) data['endDate'] = endDate;
    return data;
  }
}

class PropertyExpense {
  String? id;
  String? propertyId;
  String? expenseType;
  int? amount;
  String? title; // For Apartment legacy format
  bool? main; // For Apartment legacy format

  PropertyExpense({
    this.id,
    this.propertyId,
    this.expenseType,
    this.amount,
    this.title,
    this.main,
  });

  factory PropertyExpense.fromJson(Map<String, dynamic> json) {
    return PropertyExpense(
      id: json['id'],
      propertyId: json['propertyId'],
      expenseType: json['expenseType'],
      amount: json['amount'],
      title: json['title'],
      main: json['main'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    if (propertyId != null) data['propertyId'] = propertyId;
    if (expenseType != null) data['expenseType'] = expenseType;
    if (amount != null) data['amount'] = amount;
    if (title != null) data['title'] = title;
    if (main != null) data['main'] = main;
    return data;
  }
}

class FinancialPerformance {
  int? totalChildUnits;

  FinancialPerformance({this.totalChildUnits});

  factory FinancialPerformance.fromJson(Map<String, dynamic> json) {
    return FinancialPerformance(totalChildUnits: json['totalChildUnits']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalChildUnits'] = totalChildUnits;
    return data;
  }
}
