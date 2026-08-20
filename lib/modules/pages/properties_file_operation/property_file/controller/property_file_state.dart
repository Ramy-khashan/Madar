part of 'property_file_bloc.dart';

class PropertyFileState extends Equatable {
  const PropertyFileState({
    this.property,
    this.details,
    this.status = RequestStatus.init,
    this.saveStatus = RequestStatus.init,
    this.expenseStatus = RequestStatus.init,
    this.errorMsg = '',
    this.unitFilter,
    this.isDeleted = false,
    this.expenses = const [],
    this.expenseFiles = const [],
  });

  final PropertyFileModel? property;
  final PropertyDetailsModel? details;
  final RequestStatus status;
  final RequestStatus saveStatus;
  final RequestStatus expenseStatus;
  final String errorMsg;
  final UnitStatus? unitFilter;
  final bool isDeleted;
  final List<UnitExpenseModel> expenses;
  final List<String> expenseFiles;

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
    RequestStatus? expenseStatus,
    String? errorMsg,
    UnitStatus? Function()? unitFilter,
    bool? isDeleted,
    List<UnitExpenseModel>? expenses,
    List<String>? expenseFiles,
  }) => PropertyFileState(
    property: property ?? this.property,
    details: details ?? this.details,
    status: status ?? this.status,
    saveStatus: saveStatus ?? this.saveStatus,
    expenseStatus: expenseStatus ?? this.expenseStatus,
    errorMsg: errorMsg ?? this.errorMsg,
    unitFilter: unitFilter != null ? unitFilter() : this.unitFilter,
    isDeleted: isDeleted ?? this.isDeleted,
    expenses: expenses ?? this.expenses,
    expenseFiles: expenseFiles ?? this.expenseFiles,
  );

  @override
  List<Object?> get props => [
    property,
    details,
    status,
    saveStatus,
    expenseStatus,
    errorMsg,
    unitFilter,
    isDeleted,
    expenses,
    expenseFiles,
  ];
}
