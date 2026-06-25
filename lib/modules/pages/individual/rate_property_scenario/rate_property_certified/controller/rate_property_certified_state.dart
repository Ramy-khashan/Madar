part of 'rate_property_certified_bloc.dart';

class RatePropertyCertifiedState extends Equatable {
  const RatePropertyCertifiedState({
    this.currentStep = 0,
    this.selectedType,
    this.location = '',
    this.area = '',
    this.propertyAge,
    this.finishingLevel,
    this.purpose,
    this.ownershipDeedFile,
    this.ownerIdFile,
    this.propertyPlanFile,
    this.ownerIdError = false,
    this.companies = const [],
    this.companiesStatus = RequestStatus.init,
    this.selectedCompanyId,
    this.submitStatus = RequestStatus.init,
    this.requestNumber = '',
  });

  final int currentStep;
  final String? selectedType;
  final String location;
  final String area;
  final String? propertyAge;
  final String? finishingLevel;
  final String? purpose;
  final RatePropertyUploadedFile? ownershipDeedFile;
  final RatePropertyUploadedFile? ownerIdFile;
  final RatePropertyUploadedFile? propertyPlanFile;
  final bool ownerIdError;
  final List<RatePropertyCompanyModel> companies;
  final RequestStatus companiesStatus;
  final String? selectedCompanyId;
  final RequestStatus submitStatus;
  final String requestNumber;

  bool get canProceedStep1 =>
      selectedType != null &&
      location.isNotEmpty &&
      area.isNotEmpty &&
      propertyAge != null &&
      finishingLevel != null &&
      purpose != null;

  RatePropertyCompanyModel? get selectedCompany =>
      selectedCompanyId == null
          ? null
          : companies.where((c) => c.id == selectedCompanyId).firstOrNull;

  @override
  List<Object?> get props => [
        currentStep,
        selectedType,
        location,
        area,
        propertyAge,
        finishingLevel,
        purpose,
        ownershipDeedFile,
        ownerIdFile,
        propertyPlanFile,
        ownerIdError,
        companies,
        companiesStatus,
        selectedCompanyId,
        submitStatus,
        requestNumber,
      ];

  RatePropertyCertifiedState copyWith({
    int? currentStep,
    String? selectedType,
    String? location,
    String? area,
    String? propertyAge,
    String? finishingLevel,
    String? purpose,
    RatePropertyUploadedFile? ownershipDeedFile,
    RatePropertyUploadedFile? ownerIdFile,
    RatePropertyUploadedFile? propertyPlanFile,
    bool? ownerIdError,
    List<RatePropertyCompanyModel>? companies,
    RequestStatus? companiesStatus,
    String? selectedCompanyId,
    RequestStatus? submitStatus,
    String? requestNumber,
    bool clearOwnershipDeed = false,
    bool clearOwnerId = false,
    bool clearPropertyPlan = false,
  }) {
    return RatePropertyCertifiedState(
      currentStep: currentStep ?? this.currentStep,
      selectedType: selectedType ?? this.selectedType,
      location: location ?? this.location,
      area: area ?? this.area,
      propertyAge: propertyAge ?? this.propertyAge,
      finishingLevel: finishingLevel ?? this.finishingLevel,
      purpose: purpose ?? this.purpose,
      ownershipDeedFile: clearOwnershipDeed
          ? null
          : (ownershipDeedFile ?? this.ownershipDeedFile),
      ownerIdFile:
          clearOwnerId ? null : (ownerIdFile ?? this.ownerIdFile),
      propertyPlanFile: clearPropertyPlan
          ? null
          : (propertyPlanFile ?? this.propertyPlanFile),
      ownerIdError: ownerIdError ?? this.ownerIdError,
      companies: companies ?? this.companies,
      companiesStatus: companiesStatus ?? this.companiesStatus,
      selectedCompanyId: selectedCompanyId ?? this.selectedCompanyId,
      submitStatus: submitStatus ?? this.submitStatus,
      requestNumber: requestNumber ?? this.requestNumber,
    );
  }
}
