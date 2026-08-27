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
      propertyId: json['propertyId'] ?? json['property_id'] ?? json['id'],
      title: json['title'],
      projectName: json['projectName'],
      type: json['type'],
      listingType: json['listingType'],
      price: _jsonInt(json['price']),
      totalArea: _jsonInt(json['totalArea']),
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
      features: PropertyFeatures.parse(json['features']),
      location: json['location'] is Map
          ? PropertyLocation.fromJson(
              Map<String, dynamic>.from(json['location'] as Map),
            )
          : (json['latitude'] != null || json['longitude'] != null)
          ? PropertyLocation(
              city: json['city']?.toString(),
              district: json['district']?.toString(),
              latitude: _jsonDouble(json['latitude']),
              longitude: _jsonDouble(json['longitude']),
            )
          : null,
      media: json['media'] is List
          ? (PropertyMedia.parseList(json['media'])
              ..sort((a, b) => (a.order ?? 0).compareTo(b.order ?? 0)))
          : null,
      deeds: json['deeds'] is List
          ? (json['deeds'] as List)
                .whereType<Map>()
                .map(
                  (v) => PropertyDeeds.fromJson(Map<String, dynamic>.from(v)),
                )
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
      expenses: json['expenses'] is List
          ? (json['expenses'] as List)
                .whereType<Map>()
                .map(
                  (v) => PropertyExpense.fromJson(Map<String, dynamic>.from(v)),
                )
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
  bool? hasClubhouse;
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
  String? apartmentNumber;
  int? apartmentsPerFloor;
  int? totalFloors;

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
    this.hasClubhouse,
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
    this.apartmentNumber,
    this.apartmentsPerFloor,
    this.totalFloors,
  });

  PropertyDetails.fromJson(Map<String, dynamic> json) {
    area = _jsonInt(json['area']);
    totalArea = _jsonInt(json['totalArea']);
    builtArea = _jsonInt(json['builtArea']);
    height = _jsonInt(json['height']);
    bedrooms = _jsonInt(json['bedrooms']);
    bathrooms = _jsonInt(json['bathrooms']);
    councils = _jsonInt(json['councils']);
    kitchens = _jsonInt(json['kitchens']);
    livingRooms = _jsonInt(json['livingRooms']);
    roomsCount = _jsonInt(json['roomsCount']);
    maidRoom = json['maidRoom'];
    driverRoom = json['driverRoom'];
    floor = _jsonInt(json['floor']);
    floorsCount = _jsonInt(json['floorsCount'] ?? json['totalFloors']);
    totalFloors = _jsonInt(json['totalFloors'] ?? json['floorsCount']);
    apartmentNumber = json['apartmentNumber']?.toString();
    apartmentsPerFloor = _jsonInt(json['apartmentsPerFloor']);
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
    activities = _jsonStringList(json['activities']);
    locationType = json['locationType'];
    frontWidth = json['frontWidth'];
    hasStorage = json['hasStorage'];
    soilType = json['soilType'];
    hasFence = json['hasFence'];
    wellDepth = json['wellDepth'];
    wellsCount = json['wellsCount'];
    hasRestHouse = json['hasRestHouse'];
    waterSources = _jsonStringList(json['waterSources']);
    distanceToCity = json['distanceToCity'];
    hasElectricity = json['hasElectricity'];
    palmTreesCount = json['palmTreesCount'];
    hasLivestockSheds = json['hasLivestockSheds'];
    name = json['name'];
    views = _jsonStringList(json['views']);
    amenities = _jsonStringList(json['amenities']);
    facilities = _jsonStringList(json['facilities']);
    yearBuilt = json['yearBuilt'];
    totalUnits = json['totalUnits'];
    totalParking = json['totalParking'];
    parkingFloors = json['parkingFloors'];
    elevatorsCount = json['elevatorsCount'];
    developerName = json['developerName'];
    compoundName = json['compoundName'];
    hasClubhouse = json['hasClubhouse'];
    services = _jsonStringList(json['services']);
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
    if (hasClubhouse != null) data['hasClubhouse'] = hasClubhouse;
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
    if (apartmentNumber != null) data['apartmentNumber'] = apartmentNumber;
    if (apartmentsPerFloor != null) {
      data['apartmentsPerFloor'] = apartmentsPerFloor;
    }
    if (totalFloors != null) data['totalFloors'] = totalFloors;
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

/// Unified Features class for all property types.
///
/// GET details returns `features` as a string list
/// (`["CENTRAL_AC","PARKING"]`). Older payloads used a bool map.
class PropertyFeatures {
  final Map<String, bool> features;
  final List<String> allowedActivities;

  PropertyFeatures({required this.features, required this.allowedActivities});

  static PropertyFeatures? parse(dynamic raw) {
    if (raw == null) return null;
    if (raw is List) {
      final keys = raw.map((e) => e.toString().toUpperCase()).toList();
      final map = <String, bool>{};
      for (final key in keys) {
        map[key] = true;
        final alias = _alias(key);
        if (alias != null) map[alias] = true;
      }
      return PropertyFeatures(features: map, allowedActivities: const []);
    }
    if (raw is Map) {
      final map = <String, bool>{};
      raw.forEach((k, v) {
        if (v == true || v == 1 || v == 'true') {
          map[k.toString()] = true;
        }
      });
      return PropertyFeatures(
        features: map,
        allowedActivities: List<String>.from(raw['allowedActivities'] ?? []),
      );
    }
    return null;
  }

  factory PropertyFeatures.fromJson(Map<String, dynamic> json) {
    return parse(json) ??
        PropertyFeatures(features: const {}, allowedActivities: const []);
  }

  static String? _alias(String apiKey) {
    const aliases = {
      'ELECTRICITY': 'hasElectricity',
      'ELECTRICTY': 'hasElectricity',
      'SEWAGE': 'hasSewage',
      'WATER': 'hasWater',
      'FENCE': 'hasFence',
      'IRRIGATION': 'hasIrrigation',
      'INTERNET': 'hasInternet',
      'CENTRAL_AC': 'hasCentralAC',
      'ELEVATOR': 'hasElevator',
      'MAID_ROOM': 'hasMaidRoom',
      'TWO_ENTRANCES': 'hasTwoEntrances',
      'DRIVER_ROOM': 'hasDriverRoom',
      'BASEMENT': 'hasBasement',
      'ROOF': 'hasRoof',
      'WAREHOUSE': 'hasWarehouse',
      'POOL': 'hasPool',
      'WATER_WELL': 'hasWaterWell',
      'CCTV': 'hasCctv',
      'ELECTRONIC_GATE': 'hasElectronicGate',
      'GARDEN': 'hasGarden',
      'HEALTH_CLUB': 'hasHealthClub',
      'GUARD': 'hasGuard',
      'SECURITY': 'hasGuard',
      'PARKING': 'hasParking',
      'STORAGE': 'hasStorage',
    };
    return aliases[apiKey];
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
      latitude: _jsonDouble(json['latitude']),
      longitude: _jsonDouble(json['longitude']),
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

  static List<PropertyMedia> parseList(dynamic raw) {
    if (raw is! List) return const [];
    return raw
        .whereType<Map>()
        .map((e) => PropertyMedia.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  static String coverFrom(dynamic mediaJson, {String? fallback}) {
    final cover = parseList(mediaJson).coverUrl;
    if (cover.isNotEmpty) return cover;
    return fallback ?? '';
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

  bool get hasUrl => (url ?? '').trim().isNotEmpty;

  String get normalizedType => (type ?? '').toUpperCase().trim();

  bool get isVirtualTour {
    final t = normalizedType;
    return t == 'VIRTUAL_TOUR' || t == 'TOUR_360' || t == '360';
  }

  bool get isVideo {
    if (isVirtualTour || normalizedType == 'VIDEO') return true;
    final u = (url ?? '').toLowerCase();
    return u.contains('/video/') ||
        u.endsWith('.mp4') ||
        u.endsWith('.mov') ||
        u.endsWith('.webm') ||
        u.endsWith('.m3u8');
  }

  bool get isImage => !isVideo && hasUrl;

  String get thumbnailUrl {
    if (!hasUrl) return '';
    if (!isVideo) return url!;
    var u = url!;
    if (u.contains('/video/upload/')) {
      u = u.replaceFirst('/video/upload/', '/video/upload/so_0/');
      u = u.replaceFirst(
        RegExp(r'\.(mp4|mov|webm)(\?.*)?$', caseSensitive: false),
        '.jpg',
      );
    }
    return u;
  }
}

extension PropertyMediaListX on List<PropertyMedia> {
  List<PropertyMedia> get playable {
    final list = where((m) => m.hasUrl).toList()
      ..sort((a, b) => (a.order ?? 0).compareTo(b.order ?? 0));
    return list;
  }

  String get coverUrl {
    final items = playable;
    if (items.isEmpty) return '';
    final images = items.where((m) => m.isImage).toList();
    final mainImage = images.where((m) => m.isMain == true);
    if (mainImage.isNotEmpty) return mainImage.first.url!;
    if (images.isNotEmpty) return images.first.url!;
    final mainAny = items.where((m) => m.isMain == true);
    return (mainAny.isNotEmpty ? mainAny.first : items.first).thumbnailUrl;
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
      userId: json['userId'] ?? json['user_id'],
      fullName: json['fullName'],
      role: json['role'],
      adLicenseNumber: json['adLicenseNumber'],
      falLicenseNumber: json['falLicenseNumber'],
      totalProperties:
          json['totalProperties']?.toString() ??
          json['propertiesCount']?.toString(),
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
      propertyId: json['propertyId'] ?? json['property_id'],
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
    final image = PropertyMedia.coverFrom(
      json['media'],
      fallback: json['mainImage']?.toString(),
    );
    return ChildProperty(
      propertyId: json['propertyId'] ?? json['property_id'],
      title: json['title'],
      type: json['type'],
      status: json['status'],
      listingType: json['listingType'],
      price: _jsonInt(json['price']),
      isActive: json['isActive'],
      mainImage: image,
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
  String? name;
  num? price;
  String? buyerName;
  String? sellerName;
  String? brokerName;

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
    this.price,
    this.buyerName,
    this.sellerName,
    this.brokerName,
  });

  bool get isActive => (status ?? '').toUpperCase() == 'ACTIVE';
  bool get isRent => (contractType ?? '').toUpperCase().contains('RENT');

  factory PropertyContract.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> asMap(dynamic value) =>
        value is Map ? Map<String, dynamic>.from(value) : const {};
    final buyer = asMap(json['buyer']);
    final seller = asMap(json['seller']);
    final broker = asMap(json['broker']);
    final buyerName = (buyer['fullName'] ?? buyer['name'])?.toString();
    final sellerName = (seller['fullName'] ?? seller['name'])?.toString();
    final brokerName = (broker['fullName'] ?? broker['name'])?.toString();
    return PropertyContract(
      id: json['contractId'] ?? json['id'],
      propertyId: json['propertyId'],
      contractType: json['type'] ?? json['contractType'],
      fileUrl: json['fileUrl'],
      createdAt: json['createdAt'],
      name: json['name'] ?? buyerName ?? sellerName,
      status: json['status'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      price: json['price'] is num
          ? json['price'] as num
          : num.tryParse('${json['price'] ?? ''}'),
      buyerName: buyerName,
      sellerName: sellerName,
      brokerName: brokerName,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['contractId'] = id;
    if (propertyId != null) data['propertyId'] = propertyId;
    if (contractType != null) data['type'] = contractType;
    if (fileUrl != null) data['fileUrl'] = fileUrl;
    if (createdAt != null) data['createdAt'] = createdAt;
    if (name != null) data['name'] = name;
    if (status != null) data['status'] = status;
    if (startDate != null) data['startDate'] = startDate;
    if (endDate != null) data['endDate'] = endDate;
    if (price != null) data['price'] = price;
    return data;
  }
}

class PropertyExpense {
  String? id;
  String? propertyId;
  String? expenseType;
  int? amount;
  String? title;
  String? fileUrl;
  String? createdAt;
  bool? main;

  PropertyExpense({
    this.id,
    this.propertyId,
    this.expenseType,
    this.amount,
    this.title,
    this.fileUrl,
    this.createdAt,
    this.main,
  });

  factory PropertyExpense.fromJson(Map<String, dynamic> json) {
    return PropertyExpense(
      id: json['expenseId'] ?? json['id'],
      propertyId: json['propertyId'],
      expenseType: json['type'] ?? json['expenseType'],
      amount: _jsonInt(json['amount']),
      title: json['title'] ?? json['type'],
      fileUrl: json['file'] ?? json['fileUrl'],
      createdAt: json['createdAt'],
      main: json['main'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['expenseId'] = id;
    if (propertyId != null) data['propertyId'] = propertyId;
    if (expenseType != null) data['type'] = expenseType;
    if (amount != null) data['amount'] = amount;
    if (title != null) data['title'] = title;
    if (fileUrl != null) data['file'] = fileUrl;
    if (createdAt != null) data['createdAt'] = createdAt;
    if (main != null) data['main'] = main;
    return data;
  }
}

class FinancialPerformance {
  int? totalChildUnits;
  int? activeChildUnits;
  int? occupancyRate;
  int? monthlyIncome;

  FinancialPerformance({
    this.totalChildUnits,
    this.activeChildUnits,
    this.occupancyRate,
    this.monthlyIncome,
  });

  factory FinancialPerformance.fromJson(Map<String, dynamic> json) {
    return FinancialPerformance(
      totalChildUnits: _jsonInt(json['totalChildUnits']),
      activeChildUnits: _jsonInt(json['activeChildUnits']),
      occupancyRate: _jsonInt(json['occupancyRate']),
      monthlyIncome: _jsonInt(json['monthlyIncome']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalChildUnits'] = totalChildUnits;
    data['activeChildUnits'] = activeChildUnits;
    data['occupancyRate'] = occupancyRate;
    data['monthlyIncome'] = monthlyIncome;
    return data;
  }
}

int? _jsonInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value.toString());
}

double? _jsonDouble(dynamic value) {
  if (value == null) return null;
  if (value is double) return value;
  if (value is num) return value.toDouble();
  return double.tryParse(value.toString());
}

List<String>? _jsonStringList(dynamic value) {
  if (value is! List) return null;
  final items = value
      .map((e) => e.toString())
      .where((e) => e.isNotEmpty)
      .toList();
  return items.isEmpty ? null : items;
}
