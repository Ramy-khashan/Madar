part of 'property_file_bloc.dart';

class PropertyFileState extends Equatable {
  const PropertyFileState({
    this.property,
    this.status = RequestStatus.init,
    this.errorMsg = '',
    this.unitFilter,
    this.isDeleted = false,
  });

  final PropertyFileModel? property;
  final RequestStatus status;
  final String errorMsg;
  final UnitStatus? unitFilter; // null = show all
  final bool isDeleted;

  List<UnitModel> get filteredUnits {
    final units = property?.units ?? [];
    if (unitFilter == null) return units;
    return units.where((u) => u.status == unitFilter).toList();
  }

  PropertyFileState copyWith({
    PropertyFileModel? property,
    RequestStatus? status,
    String? errorMsg,
    UnitStatus? Function()? unitFilter,
    bool? isDeleted,
  }) =>
      PropertyFileState(
        property: property ?? this.property,
        status: status ?? this.status,
        errorMsg: errorMsg ?? this.errorMsg,
        unitFilter: unitFilter != null ? unitFilter() : this.unitFilter,
        isDeleted: isDeleted ?? this.isDeleted,
      );

  @override
  List<Object?> get props => [property, status, errorMsg, unitFilter, isDeleted];
}
