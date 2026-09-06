part of 'unit_details_bloc.dart';

class UnitDetailsState extends Equatable {
  const UnitDetailsState({
    this.unit,
    this.details,
    this.saveStatus = RequestStatus.init,
    this.loadStatus = RequestStatus.init,
    this.isDeleted = false,
    this.isSentToBroker = false,
    this.expenseFiles = const [],
    this.errorMsg = '',
    this.buildingId = '',
  });

  final UnitModel? unit;
  final PropertyDetailsModel? details;
  final RequestStatus saveStatus;
  final RequestStatus loadStatus;
  final bool isDeleted;
  final bool isSentToBroker;
  final List<String> expenseFiles;
  final String errorMsg;
  final String buildingId;

  UnitDetailsState copyWith({
    UnitModel? unit,
    PropertyDetailsModel? details,
    RequestStatus? saveStatus,
    RequestStatus? loadStatus,
    bool? isDeleted,
    bool? isSentToBroker,
    List<String>? expenseFiles,
    String? errorMsg,
    String? buildingId,
  }) => UnitDetailsState(
    unit: unit ?? this.unit,
    details: details ?? this.details,
    saveStatus: saveStatus ?? this.saveStatus,
    loadStatus: loadStatus ?? this.loadStatus,
    isDeleted: isDeleted ?? this.isDeleted,
    isSentToBroker: isSentToBroker ?? this.isSentToBroker,
    expenseFiles: expenseFiles ?? this.expenseFiles,
    errorMsg: errorMsg ?? this.errorMsg,
    buildingId: buildingId ?? this.buildingId,
  );

  @override
  List<Object?> get props => [
    unit,
    details,
    saveStatus,
    loadStatus,
    isDeleted,
    isSentToBroker,
    expenseFiles,
    errorMsg,
    buildingId,
  ];
}
