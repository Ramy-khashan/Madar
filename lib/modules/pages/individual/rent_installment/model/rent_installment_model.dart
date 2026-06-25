class RentInstallmentRequestModel {
  final String id;
  final String propertyName;
  final String requestNumber;
  final double rentValue;
  final int planMonths;
  final String providerName;
  final String status; // 'accepted' | 'under_review' | 'rejected'
  final String? rejectionReason;

  const RentInstallmentRequestModel({
    required this.id,
    required this.propertyName,
    required this.requestNumber,
    required this.rentValue,
    required this.planMonths,
    required this.providerName,
    required this.status,
    this.rejectionReason,
  });
  
}

class InstallmentProviderInfoModel {
  final String name;
  final String subtitle;

  const InstallmentProviderInfoModel({
    required this.name,
    required this.subtitle,
  });

}
