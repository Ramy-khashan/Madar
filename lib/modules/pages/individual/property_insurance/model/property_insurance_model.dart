class InsuranceRequestModel {
  final String id;
  final String propertyName;
  final String insuranceType;
  final String companyName;
  final String startDate;
  final String endDate;
  final String status; // 'active' | 'renewal_pending' | 'expired'

  const InsuranceRequestModel({
    required this.id,
    required this.propertyName,
    required this.insuranceType,
    required this.companyName,
    required this.startDate,
    required this.endDate,
    required this.status,
  });
}

class InsuranceOfferModel {
  final String companyName;
  final String insuranceTypeText;
  final String coverageDescription;
  final int startingPrice;

  const InsuranceOfferModel({
    required this.companyName,
    required this.insuranceTypeText,
    required this.coverageDescription,
    required this.startingPrice,
  });
}

class CoverageRiskModel {
  final String riskName;
  final bool basicCovered;
  final bool comprehensiveCovered;

  const CoverageRiskModel({
    required this.riskName,
    required this.basicCovered,
    required this.comprehensiveCovered,
  });
}
