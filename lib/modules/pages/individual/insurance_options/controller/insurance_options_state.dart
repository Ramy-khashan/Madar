part of 'insurance_options_bloc.dart';

class InsuranceOptionsState extends Equatable {
  const InsuranceOptionsState({
    this.types = const [],
    this.companies = const [],
    this.selectedTypeId,
    this.selectedCompanyId,
    this.propertyTitle = '',
    this.propertyLocation = '',
    this.propertyPrice = 0,
    this.propertyType = '',
    this.getDetailsStatus = RequestStatus.init,
    this.errorMsg = '',
    this.confirmStatus = RequestStatus.init,
    this.requestNumber = '',
  });

  final List<InsuranceTypeModel> types;
  final List<InsuranceCompanyModel> companies;
  final String? selectedTypeId;
  final String? selectedCompanyId;
  final String propertyTitle;
  final String propertyLocation;
  final double propertyPrice;
  final String propertyType;
  final RequestStatus getDetailsStatus;
  final String errorMsg;
  final RequestStatus confirmStatus;
  final String requestNumber;

  InsuranceTypeModel? get selectedType =>
      selectedTypeId == null
          ? null
          : types.where((t) => t.id == selectedTypeId).firstOrNull;

  InsuranceCompanyModel? get selectedCompany =>
      selectedCompanyId == null
          ? null
          : companies.where((c) => c.id == selectedCompanyId).firstOrNull;

  @override
  List<Object?> get props => [
        types, companies, selectedTypeId, selectedCompanyId,
        propertyTitle, propertyLocation, propertyPrice, propertyType,
        getDetailsStatus, errorMsg, confirmStatus, requestNumber,
      ];

  InsuranceOptionsState copyWith({
    List<InsuranceTypeModel>? types,
    List<InsuranceCompanyModel>? companies,
    String? selectedTypeId,
    String? selectedCompanyId,
    String? propertyTitle,
    String? propertyLocation,
    double? propertyPrice,
    String? propertyType,
    RequestStatus? getDetailsStatus,
    String? errorMsg,
    RequestStatus? confirmStatus,
    String? requestNumber,
  }) {
    return InsuranceOptionsState(
      types: types ?? this.types,
      companies: companies ?? this.companies,
      selectedTypeId: selectedTypeId ?? this.selectedTypeId,
      selectedCompanyId: selectedCompanyId ?? this.selectedCompanyId,
      propertyTitle: propertyTitle ?? this.propertyTitle,
      propertyLocation: propertyLocation ?? this.propertyLocation,
      propertyPrice: propertyPrice ?? this.propertyPrice,
      propertyType: propertyType ?? this.propertyType,
      getDetailsStatus: getDetailsStatus ?? this.getDetailsStatus,
      errorMsg: errorMsg ?? this.errorMsg,
      confirmStatus: confirmStatus ?? this.confirmStatus,
      requestNumber: requestNumber ?? this.requestNumber,
    );
  }
}
