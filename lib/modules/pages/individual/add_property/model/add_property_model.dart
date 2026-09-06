import 'package:equatable/equatable.dart';

import 'property_enums.dart';

class AddPropertyModel extends Equatable {
  const AddPropertyModel({
    this.operationType = 'sell',
    this.propertyType,
    this.rentalPeriod = 'annual',
    this.location,
    this.city = '',
    this.district = '',
    this.latitude,
    this.longitude,
    this.buildingNumber = '',
    this.street = '',
    this.deedType,
    this.deedNumber = '',
    this.customTypeName = '',
    this.dateType = 'gregorian',
    this.date = '',
    this.imagePaths = const [],
    this.aiEnhancement = false,
    this.hasVideo = false,
    this.has360Tour = false,
    this.videoPath,
    this.virtualTourPath,
    this.ownershipDocumentPath,
    this.area = '',
    this.facade,
    this.streetCount = 1,
    this.streetWidth,
    this.propertyAge,
    this.beds = 0,
    this.baths = 0,
    this.lounges = 0,
    this.majlis = 0,
    this.apartmentNumber = '',
    this.totalFloors,
    this.apartmentsPerFloor,
    this.floorLevel,
    this.furnishing,
    this.condition,
    this.developerName = '',
    this.amenities = const {},
    this.typeDetails = const {},
    this.price = '',
    this.title = '',
    this.description = '',
    this.hasRentInstallment = false,
    this.hasInsurance = false,
    this.portfolioFolderName = '',
    this.propertyParentId = '',
    this.propertyParentTitle = '',
  });

  final String operationType; // 'sell' | 'rent'
  final String? propertyType;
  final String rentalPeriod; // 'monthly' | 'semi_annual' | 'annual'

  // Step 3 — Location & Deed
  final String? location;
  final String city;
  final String district;
  final double? latitude;
  final double? longitude;
  final String buildingNumber;
  final String street;
  final String? deedType;
  final String deedNumber;
  final String customTypeName;
  final String dateType; // 'hijri' | 'gregorian'
  final String date;

  String? get apiDeedType => (deedType == null || deedType!.isEmpty)
      ? null
      : PropertyApiEnums.deedTypeFromUi(deedType);

  bool get needsDeedNumberAndDate {
    final type = apiDeedType;
    return type == PropertyApiEnums.deedElectronic ||
        type == PropertyApiEnums.deedRealEstateDeed;
  }

  bool get needsOwnershipDocument {
    final type = apiDeedType;
    return type == PropertyApiEnums.deedSaleContract ||
        type == PropertyApiEnums.deedElectronic ||
        type == PropertyApiEnums.deedOther;
  }

  bool get needsCustomTypeName => apiDeedType == PropertyApiEnums.deedOther;
  bool get needsDeedElectronic =>
      apiDeedType == PropertyApiEnums.deedElectronic;

  // Step 4 — Images
  final List<String> imagePaths;
  final bool aiEnhancement;
  final bool hasVideo;
  final bool has360Tour;
  final String? videoPath;
  final String? virtualTourPath;
  final String? ownershipDocumentPath;

  // Step 5 — Details
  final String area;
  final String? facade;
  final int streetCount;
  final String? streetWidth;
  final String? propertyAge;
  final int beds;
  final int baths;
  final int lounges;
  final int majlis;
  final String apartmentNumber;
  final String? totalFloors;
  final String? apartmentsPerFloor;
  final String? floorLevel;
  final String? furnishing;
  final String? condition;
  final String developerName;
  final Set<String> amenities;

  /// Per-type `details` values keyed by their API field name, so a new backend
  /// field only needs a widget and a mapper entry rather than a model field.
  final Map<String, dynamic> typeDetails;

  T? detail<T>(String key) {
    final value = typeDetails[key];
    return value is T ? value : null;
  }

  int detailCount(String key) => detail<int>(key) ?? 0;

  bool detailFlag(String key) => detail<bool>(key) ?? false;

  List<String> detailList(String key) =>
      (typeDetails[key] as List<dynamic>?)?.cast<String>() ?? const [];

  // Step 6 — Price & Review
  final String price;
  final String title;
  final String description;
  final bool hasRentInstallment;
  final bool hasInsurance;
  final String portfolioFolderName;
  final String propertyParentId;
  final String propertyParentTitle;

  bool get hasParentProperty => propertyParentId.isNotEmpty;

  bool get isApartment => propertyType == PropertyApiEnums.typeApartment;

  AddPropertyModel copyWith({
    String? operationType,
    String? propertyType,
    String? rentalPeriod,
    String? location,
    String? city,
    String? district,
    double? latitude,
    double? longitude,
    String? buildingNumber,
    String? street,
    String? deedType,
    String? deedNumber,
    String? customTypeName,
    String? dateType,
    String? date,
    List<String>? imagePaths,
    bool? aiEnhancement,
    bool? hasVideo,
    bool? has360Tour,
    String? videoPath,
    String? virtualTourPath,
    bool clearVideoPath = false,
    bool clearVirtualTourPath = false,
    bool clearOwnershipDocumentPath = false,
    String? ownershipDocumentPath,
    String? area,
    String? facade,
    int? streetCount,
    String? streetWidth,
    String? propertyAge,
    int? beds,
    int? baths,
    int? lounges,
    int? majlis,
    String? apartmentNumber,
    String? totalFloors,
    String? apartmentsPerFloor,
    String? floorLevel,
    String? furnishing,
    String? condition,
    String? developerName,
    Set<String>? amenities,
    Map<String, dynamic>? typeDetails,
    String? price,
    String? title,
    String? description,
    bool? hasRentInstallment,
    bool? hasInsurance,
    String? portfolioFolderName,
    String? propertyParentId,
    String? propertyParentTitle,
    bool clearPropertyParent = false,
  }) {
    return AddPropertyModel(
      operationType: operationType ?? this.operationType,
      propertyType: propertyType ?? this.propertyType,
      rentalPeriod: rentalPeriod ?? this.rentalPeriod,
      location: location ?? this.location,
      city: city ?? this.city,
      district: district ?? this.district,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      buildingNumber: buildingNumber ?? this.buildingNumber,
      street: street ?? this.street,
      deedType: deedType ?? this.deedType,
      deedNumber: deedNumber ?? this.deedNumber,
      customTypeName: customTypeName ?? this.customTypeName,
      dateType: dateType ?? this.dateType,
      date: date ?? this.date,
      imagePaths: imagePaths ?? this.imagePaths,
      aiEnhancement: aiEnhancement ?? this.aiEnhancement,
      hasVideo: hasVideo ?? this.hasVideo,
      has360Tour: has360Tour ?? this.has360Tour,
      videoPath: clearVideoPath ? null : (videoPath ?? this.videoPath),
      virtualTourPath: clearVirtualTourPath
          ? null
          : (virtualTourPath ?? this.virtualTourPath),
      ownershipDocumentPath: clearOwnershipDocumentPath
          ? null
          : (ownershipDocumentPath ?? this.ownershipDocumentPath),
      area: area ?? this.area,
      facade: facade ?? this.facade,
      streetCount: streetCount ?? this.streetCount,
      streetWidth: streetWidth ?? this.streetWidth,
      propertyAge: propertyAge ?? this.propertyAge,
      beds: beds ?? this.beds,
      baths: baths ?? this.baths,
      lounges: lounges ?? this.lounges,
      majlis: majlis ?? this.majlis,
      apartmentNumber: apartmentNumber ?? this.apartmentNumber,
      totalFloors: totalFloors ?? this.totalFloors,
      apartmentsPerFloor: apartmentsPerFloor ?? this.apartmentsPerFloor,
      floorLevel: floorLevel ?? this.floorLevel,
      furnishing: furnishing ?? this.furnishing,
      condition: condition ?? this.condition,
      developerName: developerName ?? this.developerName,
      amenities: amenities ?? this.amenities,
      typeDetails: typeDetails ?? this.typeDetails,
      price: price ?? this.price,
      title: title ?? this.title,
      description: description ?? this.description,
      hasRentInstallment: hasRentInstallment ?? this.hasRentInstallment,
      hasInsurance: hasInsurance ?? this.hasInsurance,
      portfolioFolderName: portfolioFolderName ?? this.portfolioFolderName,
      propertyParentId: clearPropertyParent
          ? ''
          : (propertyParentId ?? this.propertyParentId),
      propertyParentTitle: clearPropertyParent
          ? ''
          : (propertyParentTitle ?? this.propertyParentTitle),
    );
  }

  @override
  List<Object?> get props => [
    operationType,
    propertyType,
    rentalPeriod,
    location,
    city,
    district,
    latitude,
    longitude,
    buildingNumber,
    street,
    deedType,
    deedNumber,
    customTypeName,
    dateType,
    date,
    imagePaths,
    aiEnhancement,
    hasVideo,
    has360Tour,
    videoPath,
    virtualTourPath,
    ownershipDocumentPath,
    area,
    facade,
    streetCount,
    streetWidth,
    propertyAge,
    beds,
    baths,
    lounges,
    majlis,
    apartmentNumber,
    totalFloors,
    apartmentsPerFloor,
    floorLevel,
    furnishing,
    condition,
    developerName,
    amenities,
    typeDetails,
    price,
    title,
    description,
    hasRentInstallment,
    hasInsurance,
    portfolioFolderName,
    propertyParentId,
    propertyParentTitle,
  ];
}
