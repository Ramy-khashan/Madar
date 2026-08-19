import 'package:equatable/equatable.dart';

/// Represents a broker or owner profile shown in the listing header.
class PropertyListingUserModel extends Equatable {
  const PropertyListingUserModel({
    required this.name,
 
    required this.propertiesCount,
    this.imageUrl,
  });

  final String name;
 
  final int propertiesCount;
  final String? imageUrl;

  @override
  List<Object?> get props => [
        name,
   
        propertiesCount,
        imageUrl,
      ];
}
