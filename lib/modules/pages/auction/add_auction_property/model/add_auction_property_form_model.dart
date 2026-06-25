import 'package:equatable/equatable.dart';

class AddAuctionPropertyFormModel extends Equatable {
  const AddAuctionPropertyFormModel({
    this.propertyTypeId = '',
    this.location = '',
    this.startingPrice = '',
    this.startDate = '',
    this.startTime = '',
    this.endDate = '',
    this.endTime = '',
    this.rooms = 0,
    this.bathrooms = 0,
    this.area = 0,
    this.balcony = 0,
    this.floor = 0,
    this.propertyNumber = 0,
    this.description = '',
  });

  final String propertyTypeId;
  final String location;
  final String startingPrice;
  final String startDate;
  final String startTime;
  final String endDate;
  final String endTime;
  final int rooms;
  final int bathrooms;
  final int area;
  final int balcony;
  final int floor;
  final int propertyNumber;
  final String description;

  @override
  List<Object?> get props => [
        propertyTypeId,
        location,
        startingPrice,
        startDate,
        startTime,
        endDate,
        endTime,
        rooms,
        bathrooms,
        area,
        balcony,
        floor,
        propertyNumber,
        description,
      ];

  AddAuctionPropertyFormModel copyWith({
    String? propertyTypeId,
    String? location,
    String? startingPrice,
    String? startDate,
    String? startTime,
    String? endDate,
    String? endTime,
    int? rooms,
    int? bathrooms,
    int? area,
    int? balcony,
    int? floor,
    int? propertyNumber,
    String? description,
  }) {
    return AddAuctionPropertyFormModel(
      propertyTypeId: propertyTypeId ?? this.propertyTypeId,
      location: location ?? this.location,
      startingPrice: startingPrice ?? this.startingPrice,
      startDate: startDate ?? this.startDate,
      startTime: startTime ?? this.startTime,
      endDate: endDate ?? this.endDate,
      endTime: endTime ?? this.endTime,
      rooms: rooms ?? this.rooms,
      bathrooms: bathrooms ?? this.bathrooms,
      area: area ?? this.area,
      balcony: balcony ?? this.balcony,
      floor: floor ?? this.floor,
      propertyNumber: propertyNumber ?? this.propertyNumber,
      description: description ?? this.description,
    );
  }
}
