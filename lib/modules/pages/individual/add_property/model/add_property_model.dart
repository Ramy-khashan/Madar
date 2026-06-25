import 'package:equatable/equatable.dart';

class AddPropertyModel extends Equatable {
  const AddPropertyModel({
    this.operationType = 'sell',
    this.propertyType,
    this.rentalPeriod = 'annual',
    this.location,
    this.buildingNumber = '',
    this.street = '',
    this.deedType,
    this.deedNumber = '',
    this.dateType = 'gregorian',
    this.date = '',
    this.imagePaths = const [],
    this.aiEnhancement = false,
    this.hasVideo = false,
    this.has360Tour = false,
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
    this.price = '',
    this.title = '',
    this.description = '',
    this.hasRentInstallment = false,
    this.hasInsurance = false,
    this.portfolioFolderName = '',
  });

  final String operationType; // 'sell' | 'rent'
  final String? propertyType;
  final String rentalPeriod; // 'monthly' | 'semi_annual' | 'annual'

  // Step 3 — Location & Deed
  final String? location;
  final String buildingNumber;
  final String street;
  final String? deedType;
  final String deedNumber;
  final String dateType; // 'hijri' | 'gregorian'
  final String date;

  // Step 4 — Images
  final List<String> imagePaths;
  final bool aiEnhancement;
  final bool hasVideo;
  final bool has360Tour;

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

  // Step 6 — Price & Review
  final String price;
  final String title;
  final String description;
  final bool hasRentInstallment;
  final bool hasInsurance;
  final String portfolioFolderName;

  AddPropertyModel copyWith({
    String? operationType,
    String? propertyType,
    String? rentalPeriod,
    String? location,
    String? buildingNumber,
    String? street,
    String? deedType,
    String? deedNumber,
    String? dateType,
    String? date,
    List<String>? imagePaths,
    bool? aiEnhancement,
    bool? hasVideo,
    bool? has360Tour,
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
    String? price,
    String? title,
    String? description,
    bool? hasRentInstallment,
    bool? hasInsurance,
    String? portfolioFolderName,
  }) {
    return AddPropertyModel(
      operationType: operationType ?? this.operationType,
      propertyType: propertyType ?? this.propertyType,
      rentalPeriod: rentalPeriod ?? this.rentalPeriod,
      location: location ?? this.location,
      buildingNumber: buildingNumber ?? this.buildingNumber,
      street: street ?? this.street,
      deedType: deedType ?? this.deedType,
      deedNumber: deedNumber ?? this.deedNumber,
      dateType: dateType ?? this.dateType,
      date: date ?? this.date,
      imagePaths: imagePaths ?? this.imagePaths,
      aiEnhancement: aiEnhancement ?? this.aiEnhancement,
      hasVideo: hasVideo ?? this.hasVideo,
      has360Tour: has360Tour ?? this.has360Tour,
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
      price: price ?? this.price,
      title: title ?? this.title,
      description: description ?? this.description,
      hasRentInstallment: hasRentInstallment ?? this.hasRentInstallment,
      hasInsurance: hasInsurance ?? this.hasInsurance,
      portfolioFolderName: portfolioFolderName ?? this.portfolioFolderName,
    );
  }

  @override
  List<Object?> get props => [
        operationType,
        propertyType,
        rentalPeriod,
        location,
        buildingNumber,
        street,
        deedType,
        deedNumber,
        dateType,
        date,
        imagePaths,
        aiEnhancement,
        hasVideo,
        has360Tour,
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
        price,
        title,
        description,
        hasRentInstallment,
        hasInsurance,
        portfolioFolderName,
      ];
}
