part of 'property_file_bloc.dart';

class PropertyFileState extends Equatable {
  const PropertyFileState({
    this.property,
    this.details,
    this.status = RequestStatus.init,
    this.saveStatus = RequestStatus.init,
    this.publishStatus = RequestStatus.init,
    this.expenseStatus = RequestStatus.init,
    this.errorMsg = '',
    this.unitFilter,
    this.isDeleted = false,
    this.expenses = const [],
    this.expenseFiles = const [],
    this.tenancyStatus = UnitStatus.vacant,
    this.isHijriDate = false,
  });

  final PropertyFileModel? property;
  final PropertyDetailsModel? details;
  final RequestStatus status;
  final RequestStatus saveStatus;
  final RequestStatus publishStatus;
  final RequestStatus expenseStatus;
  final String errorMsg;
  final UnitStatus? unitFilter;
  final bool isDeleted;
  final List<UnitExpenseModel> expenses;
  final List<String> expenseFiles;
  final UnitStatus tenancyStatus;
  final bool isHijriDate;

  bool get isRented => tenancyStatus == UnitStatus.rented;

  bool get isMultiUnit =>
      property?.isMultiUnit ?? PropertyFileModel.isMultiUnitType(details?.type);

  List<UnitModel> get filteredUnits {
    final units = property?.units ?? [];
    if (unitFilter == null) return units;
    return units.where((u) => u.status == unitFilter).toList();
  }

  PropertyFileState copyWith({
    PropertyFileModel? property,
    PropertyDetailsModel? details,
    RequestStatus? status,
    RequestStatus? saveStatus,
    RequestStatus? publishStatus,
    RequestStatus? expenseStatus,
    String? errorMsg,
    UnitStatus? Function()? unitFilter,
    bool? isDeleted,
    List<UnitExpenseModel>? expenses,
    List<String>? expenseFiles,
    UnitStatus? tenancyStatus,
    bool? isHijriDate,
  }) => PropertyFileState(
    property: property ?? this.property,
    details: details ?? this.details,
    status: status ?? this.status,
    saveStatus: saveStatus ?? this.saveStatus,
    publishStatus: publishStatus ?? this.publishStatus,
    expenseStatus: expenseStatus ?? this.expenseStatus,
    errorMsg: errorMsg ?? this.errorMsg,
    unitFilter: unitFilter != null ? unitFilter() : this.unitFilter,
    isDeleted: isDeleted ?? this.isDeleted,
    expenses: expenses ?? this.expenses,
    expenseFiles: expenseFiles ?? this.expenseFiles,
    tenancyStatus: tenancyStatus ?? this.tenancyStatus,
    isHijriDate: isHijriDate ?? this.isHijriDate,
  );

  @override
  List<Object?> get props => [
    property,
    details,
    status,
    saveStatus,
    publishStatus,
    expenseStatus,
    errorMsg,
    unitFilter,
    isDeleted,
    expenses,
    expenseFiles,
    tenancyStatus,
    isHijriDate,
  ];
}
