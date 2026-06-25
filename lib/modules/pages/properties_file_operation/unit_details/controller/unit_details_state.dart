part of 'unit_details_bloc.dart';

class UnitDetailsState extends Equatable {
  const UnitDetailsState({
    this.unit,
    this.saveStatus = RequestStatus.init,
    this.isDeleted = false,
    this.isSentToBroker = false,
  });

  final UnitModel? unit;
  final RequestStatus saveStatus;
  final bool isDeleted;
  final bool isSentToBroker;

  UnitDetailsState copyWith({
    UnitModel? unit,
    RequestStatus? saveStatus,
    bool? isDeleted,
    bool? isSentToBroker,
  }) =>
      UnitDetailsState(
        unit: unit ?? this.unit,
        saveStatus: saveStatus ?? this.saveStatus,
        isDeleted: isDeleted ?? this.isDeleted,
        isSentToBroker: isSentToBroker ?? this.isSentToBroker,
      );

  @override
  List<Object?> get props => [unit, saveStatus, isDeleted, isSentToBroker];
}
