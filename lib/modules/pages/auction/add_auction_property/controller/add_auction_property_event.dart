part of 'add_auction_property_bloc.dart';

abstract class AddAuctionPropertyEvent extends Equatable {
  const AddAuctionPropertyEvent();
  @override
  List<Object?> get props => [];
}

class AddAuctionPropertyTypeSelected extends AddAuctionPropertyEvent {
  const AddAuctionPropertyTypeSelected(this.typeId);
  final String typeId;
  @override
  List<Object?> get props => [typeId];
}

class AddAuctionPropertyFieldChanged extends AddAuctionPropertyEvent {
  const AddAuctionPropertyFieldChanged({
    this.location,
    this.startingPrice,
    this.startDate,
    this.startTime,
    this.endDate,
    this.endTime,
    this.description,
  });
  final String? location;
  final String? startingPrice;
  final String? startDate;
  final String? startTime;
  final String? endDate;
  final String? endTime;
  final String? description;

  @override
  List<Object?> get props => [
        location,
        startingPrice,
        startDate,
        startTime,
        endDate,
        endTime,
        description,
      ];
}

class AddAuctionPropertyCounterChanged extends AddAuctionPropertyEvent {
  const AddAuctionPropertyCounterChanged({
    this.rooms,
    this.bathrooms,
    this.area,
    this.balcony,
    this.floor,
    this.propertyNumber,
  });
  final int? rooms;
  final int? bathrooms;
  final int? area;
  final int? balcony;
  final int? floor;
  final int? propertyNumber;

  @override
  List<Object?> get props =>
      [rooms, bathrooms, area, balcony, floor, propertyNumber];
}

class AddAuctionPropertySubmit extends AddAuctionPropertyEvent {
  const AddAuctionPropertySubmit();
}
