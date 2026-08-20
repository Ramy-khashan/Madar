import 'package:equatable/equatable.dart';

import '../../../../../core/utils/constants/app_images.dart';

class BrokerModel extends Equatable {
  const BrokerModel({
    required this.id,
    required this.name,
    required this.licenseNumber,
    required this.propertiesCount,
    required this.location,
    required this.commissionPercent,
    required this.description,
    required this.userId,
    this.imageUrl = '',
  });

  final String id;
  final String name;
  final String licenseNumber;
  final int propertiesCount;
  final String location;
  final double commissionPercent;
  final String description;
  final String imageUrl;
  final String userId;

  @override
  List<Object?> get props => [
    name,
    licenseNumber,
    propertiesCount,
    location,
    imageUrl,
    userId,
    commissionPercent,
    description,
    imageUrl,
    id
  ];

  factory BrokerModel.fromJson(Map<String, dynamic> json) {
    return BrokerModel(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      name: json['officeName'] ?? '',
      licenseNumber: json['license'] ?? '',
      propertiesCount: json['propertiesCount'] ?? 0,
      description: json['description'] ?? '',

      location: json['location'] ?? '',
      commissionPercent: (json['commissionPercent'] ?? 2.5).toDouble(),
      imageUrl: json['image'] ?? AppImages.agentImage,
    );
  }
}
