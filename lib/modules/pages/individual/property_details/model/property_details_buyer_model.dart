import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NearbyPlaceModel extends Equatable {
  final String name;
  final String distance; // e.g. "0.8 كم"

  const NearbyPlaceModel({required this.name, required this.distance});

  @override
  List<Object?> get props => [name, distance];
}

class PropertyBuyerModel extends Equatable {
  final String id;
  final String title;
  final String location;
  final double price;
  final List<String> imageUrls;
  final int beds;
  final int balconies;
  final int baths;
  final String area;
  final int floor;
  final String propertyNumber;
  final String paymentMethod;
  final String tag;
  final bool isBookmarked;
  final String description;
  final String propertyType;
  final String occupancyRate;
  final AdvertiserModel advertiser;
  final RentInstallmentInfoModel rentInfo;
  final InsuranceInfoModel insuranceInfo;
  final LatLng? latLng;
  final List<NearbyPlaceModel> nearbyPlaces;

  const PropertyBuyerModel({
    required this.id,
    required this.title,
    required this.location,
    required this.price,
    required this.imageUrls,
    required this.beds,
    required this.balconies,
    required this.baths,
    required this.area,
    required this.floor,
    required this.propertyNumber,
    required this.paymentMethod,
    required this.tag,
    required this.isBookmarked,
    required this.description,
    required this.advertiser,
    required this.rentInfo,
    required this.insuranceInfo,
    required this.occupancyRate,
    this.propertyType = 'شقة سكنية',
    this.latLng,
    this.nearbyPlaces = const [],
  });

  @override
  List<Object?> get props => [
        id, title, location, price, imageUrls, beds, balconies, baths,
        area, floor, propertyNumber, paymentMethod, tag, isBookmarked,
        description, advertiser, rentInfo, insuranceInfo, occupancyRate,
        propertyType, latLng, nearbyPlaces,
      ];

  PropertyBuyerModel copyWith({
    String? id,
    String? title,
    String? location,
    double? price,
    List<String>? imageUrls,
    int? beds,
    int? balconies,
    int? baths,
    String? area,
    int? floor,
    String? propertyNumber,
    String? paymentMethod,
    String? tag,
    bool? isBookmarked,
    String? description,
    String? propertyType,
    AdvertiserModel? advertiser,
    RentInstallmentInfoModel? rentInfo,
    InsuranceInfoModel? insuranceInfo,
    String? occupancyRate,
    LatLng? latLng,
    List<NearbyPlaceModel>? nearbyPlaces,
  }) {
    return PropertyBuyerModel(
      id: id ?? this.id,
      title: title ?? this.title,
      location: location ?? this.location,
      price: price ?? this.price,
      imageUrls: imageUrls ?? this.imageUrls,
      beds: beds ?? this.beds,
      balconies: balconies ?? this.balconies,
      baths: baths ?? this.baths,
      area: area ?? this.area,
      floor: floor ?? this.floor,
      occupancyRate: occupancyRate ?? this.occupancyRate,
      propertyNumber: propertyNumber ?? this.propertyNumber,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      tag: tag ?? this.tag,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      description: description ?? this.description,
      propertyType: propertyType ?? this.propertyType,
      advertiser: advertiser ?? this.advertiser,
      rentInfo: rentInfo ?? this.rentInfo,
      insuranceInfo: insuranceInfo ?? this.insuranceInfo,
      latLng: latLng ?? this.latLng,
      nearbyPlaces: nearbyPlaces ?? this.nearbyPlaces,
    );
  }
}

class AdvertiserModel extends Equatable {
  final String name;
  final String role;
  final bool isVerified;
  final String falLicenseNumber;
  final String adLicenseNumber;
  final int totalProperties;
  final String badgeLabel;

  const AdvertiserModel({
    required this.name,
    required this.role,
    required this.isVerified,
    required this.falLicenseNumber,
    required this.adLicenseNumber,
    required this.totalProperties,
    this.badgeLabel = '',
  });

  @override
  List<Object?> get props => [
        name, role, isVerified, falLicenseNumber, adLicenseNumber,
        totalProperties, badgeLabel,
      ];
}

class RentInstallmentInfoModel extends Equatable {
  final bool isEligible;
  final double annualRentValue;
  final double minMonthlyInstallment;
  final int providersCount;

  const RentInstallmentInfoModel({
    required this.isEligible,
    required this.annualRentValue,
    required this.minMonthlyInstallment,
    required this.providersCount,
  });

  @override
  List<Object?> get props => [
        isEligible, annualRentValue, minMonthlyInstallment, providersCount,
      ];
}

class InsuranceInfoModel extends Equatable {
  final bool isInsured;
  final List<String> availableTypes;
  final int companiesCount;

  const InsuranceInfoModel({
    required this.isInsured,
    required this.availableTypes,
    required this.companiesCount,
  });

  @override
  List<Object?> get props => [isInsured, availableTypes, companiesCount];
}
