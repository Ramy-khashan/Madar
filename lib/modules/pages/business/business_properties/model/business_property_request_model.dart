class BusinessPropertyRequestModel {
  final String id;
  final String title;
  final String location;
  final String individualName;
  final String requestDate;
  final String imageUrl;
  final String status;

  const BusinessPropertyRequestModel({
    required this.id,
    required this.title,
    required this.location,
    required this.individualName,
    required this.requestDate,
    required this.imageUrl,
    required this.status,
  });
}
