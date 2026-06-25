class AccountModel {
  final String title;
  final String description;
  final String image;
  final String accountType;
  final String badge;
  final List<String> features;

  const AccountModel({
    required this.title,
    required this.description,
    required this.image,
    required this.accountType,
    required this.badge,
    required this.features,
  });
}