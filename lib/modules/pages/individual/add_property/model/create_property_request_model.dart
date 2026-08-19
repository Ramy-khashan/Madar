import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import 'property_deed_model.dart';
import 'property_details_base.dart';
import 'property_enums.dart';
import 'property_location_model.dart';

/// Multipart request body for `POST /properties`.
///
/// `location`, `details` and `features` travel as JSON-encoded strings inside
/// the FormData, deeds use indexed `deeds[i][field]` keys, and images, the
/// virtual tour and ownership documents are attached as multipart files.
class CreatePropertyRequestModel extends Equatable {
  const CreatePropertyRequestModel({
    required this.title,
    required this.type,
    required this.listingType,
    required this.price,
    required this.totalArea,
    required this.location,
    this.details,
    this.paymentType = PropertyApiEnums.paymentCash,
    this.brokerId,
    this.features = const [],
    this.deeds = const [],
    this.imagePaths = const [],
    this.virtualTourPath,
    this.videoPath,
    this.description,
    this.rentPeriod,
    this.projectName,
    this.propertyParentId,
    this.propertyNo,
    this.propertyAge,
    this.facadeDirection,
    this.streetsCount,
    this.streetWidth,
  });

  final String title;

  /// One of [PropertyApiEnums.allTypes].
  final String type;

  /// [PropertyApiEnums.listingSale] or [PropertyApiEnums.listingRent].
  final String listingType;
  final num price;

  /// Total area in square meters.
  final num totalArea;
  final PropertyLocationModel location;

  /// Per-type details; the concrete subtype must match [type].
  final PropertyDetailsBase? details;
  final String paymentType;
  final String? brokerId;

  /// Values from [PropertyApiEnums.featureInternet] and friends.
  final List<String> features;
  final List<PropertyDeedModel> deeds;
  final List<String> imagePaths;
  final String? virtualTourPath;
  final String? videoPath;
  final String? description;

  /// Required by the backend when [listingType] is [PropertyApiEnums.listingRent].
  final String? rentPeriod;
  final String? projectName;

  /// Set when the listing belongs to an existing parent property/portfolio.
  final String? propertyParentId;
  final String? propertyNo;

  /// One of [PropertyApiEnums.ageNew] and friends.
  final String? propertyAge;

  /// One of [PropertyApiEnums.facadeNorth] and friends.
  final String? facadeDirection;
  final int? streetsCount;

  /// Street width in meters.
  final num? streetWidth;

  bool get isRent => listingType == PropertyApiEnums.listingRent;

  /// Scalar text fields of the multipart body, already stringified.
  Map<String, String> toFields() {
    final fields = <String, String>{
      'title': title,
      'type': type,
      'listingType': listingType,
      'price': price.toString(),
      'totalArea': totalArea.toString(),
      'paymentType': paymentType,
      'location': jsonEncode(location.toJson()),
      'features': jsonEncode(features),
    };

    if (details != null) {
      fields['details'] = jsonEncode(details!.toJson());
    }
    if (brokerId != null && brokerId!.isNotEmpty) {
      fields['brokerId'] = brokerId!;
    }
    if (description != null && description!.isNotEmpty) {
      fields['description'] = description!;
    }
    if (isRent && rentPeriod != null && rentPeriod!.isNotEmpty) {
      fields['rentPeriod'] = rentPeriod!;
    }
    if (projectName != null && projectName!.isNotEmpty) {
      fields['projectName'] = projectName!;
    }
    if (propertyParentId != null && propertyParentId!.isNotEmpty) {
      fields['propertyParentId'] = propertyParentId!;
    }
    if (propertyNo != null && propertyNo!.isNotEmpty) {
      fields['propertyNo'] = propertyNo!;
    }
    if (propertyAge != null && propertyAge!.isNotEmpty) {
      fields['propertyAge'] = propertyAge!;
    }
    if (facadeDirection != null && facadeDirection!.isNotEmpty) {
      fields['facadeDirection'] = facadeDirection!;
    }
    if (streetsCount != null) {
      fields['streetsCount'] = streetsCount!.toString();
    }
    if (streetWidth != null) {
      fields['streetWidth'] = streetWidth!.toString();
    }

    for (var i = 0; i < deeds.length; i++) {
      fields.addAll(deeds[i].toFields(i));
    }

    return fields;
  }

  /// Builds the multipart body, reading every attached file from disk.
  Future<FormData> toFormData() async {
    final formData = FormData();

    toFields().forEach((key, value) {
      formData.fields.add(MapEntry(key, value));
    });

    for (final path in imagePaths) {
      if (path.isEmpty) continue;
      formData.files.add(MapEntry('images', await _multipart(path)));
    }

    if (virtualTourPath != null && virtualTourPath!.isNotEmpty) {
      formData.files.add(
        MapEntry('virtualTour', await _multipart(virtualTourPath!)),
      );
    }

    if (videoPath != null && videoPath!.isNotEmpty) {
      formData.files.add(MapEntry('video', await _multipart(videoPath!)));
    }

    for (var i = 0; i < deeds.length; i++) {
      final deed = deeds[i];
      if (!deed.hasOwnershipDocument) continue;
      formData.files.add(
        MapEntry(
          deed.ownershipDocumentField(i),
          await _multipart(deed.ownershipDocumentPath!),
        ),
      );
    }

    return formData;
  }

  static Future<MultipartFile> _multipart(String path) =>
      MultipartFile.fromFile(path, filename: path.split('/').last);

  CreatePropertyRequestModel copyWith({
    String? title,
    String? type,
    String? listingType,
    num? price,
    num? totalArea,
    PropertyLocationModel? location,
    PropertyDetailsBase? details,
    String? paymentType,
    String? brokerId,
    List<String>? features,
    List<PropertyDeedModel>? deeds,
    List<String>? imagePaths,
    String? virtualTourPath,
    String? videoPath,
    String? description,
    String? rentPeriod,
    String? projectName,
    String? propertyParentId,
    String? propertyNo,
    String? propertyAge,
    String? facadeDirection,
    int? streetsCount,
    num? streetWidth,
  }) {
    return CreatePropertyRequestModel(
      title: title ?? this.title,
      type: type ?? this.type,
      listingType: listingType ?? this.listingType,
      price: price ?? this.price,
      totalArea: totalArea ?? this.totalArea,
      location: location ?? this.location,
      details: details ?? this.details,
      paymentType: paymentType ?? this.paymentType,
      brokerId: brokerId ?? this.brokerId,
      features: features ?? this.features,
      deeds: deeds ?? this.deeds,
      imagePaths: imagePaths ?? this.imagePaths,
      virtualTourPath: virtualTourPath ?? this.virtualTourPath,
      videoPath: videoPath ?? this.videoPath,
      description: description ?? this.description,
      rentPeriod: rentPeriod ?? this.rentPeriod,
      projectName: projectName ?? this.projectName,
      propertyParentId: propertyParentId ?? this.propertyParentId,
      propertyNo: propertyNo ?? this.propertyNo,
      propertyAge: propertyAge ?? this.propertyAge,
      facadeDirection: facadeDirection ?? this.facadeDirection,
      streetsCount: streetsCount ?? this.streetsCount,
      streetWidth: streetWidth ?? this.streetWidth,
    );
  }

  @override
  List<Object?> get props => [
    title,
    type,
    listingType,
    price,
    totalArea,
    location,
    details,
    paymentType,
    brokerId,
    features,
    deeds,
    imagePaths,
    virtualTourPath,
    videoPath,
    description,
    rentPeriod,
    projectName,
    propertyParentId,
    propertyNo,
    propertyAge,
    facadeDirection,
    streetsCount,
    streetWidth,
  ];
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'type': type,
      'listingType': listingType,
      'price': price,
      'totalArea': totalArea,
      'location': location.toJson(),
      if (details != null) 'details': details!.toJson(),
      'paymentType': paymentType,
      if (brokerId != null) 'brokerId': brokerId,
      'features': features,
      if (deeds.isNotEmpty) 'deeds': deeds.map((d) => d.toJson()).toList(),
      if (imagePaths.isNotEmpty) 'imagePaths': imagePaths,
      if (virtualTourPath != null) 'virtualTourPath': virtualTourPath,
      if (videoPath != null) 'videoPath': videoPath,
      if (description != null) 'description': description,
      if (rentPeriod != null) 'rentPeriod': rentPeriod,
      if (projectName != null) 'projectName': projectName,
      if (propertyParentId != null) 'propertyParentId': propertyParentId,
      if (propertyNo != null) 'propertyNo': propertyNo,
      if (propertyAge != null) 'propertyAge': propertyAge,
      if (facadeDirection != null) 'facadeDirection': facadeDirection,
      if (streetsCount != null) 'streetsCount': streetsCount,
      if (streetWidth != null) 'streetWidth': streetWidth,
    };
  }
}
