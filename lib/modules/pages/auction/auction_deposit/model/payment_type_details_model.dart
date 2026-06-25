import '../../../../../core/utils/constants/app_enums.dart';
 
class PaymentTypeDetailsModel {
  final AuctionDepositPaymentMethod method;
  final String label;
  final String subtitle;
  final String iconPath;

  PaymentTypeDetailsModel({
    required this.method,
    required this.label,
    required this.subtitle,
    required this.iconPath,
  });
}
