import '../../../individual/property_details/model/property_details_model.dart';

class BusinessPropertyRequestModel {
  BusinessPropertyRequestModel({
    this.requestId,
    this.propertyId,
    this.title,
    this.owner,
    this.status,
    this.createdAt,
    this.image,
    this.city,
    this.district,
    this.adLicenseNumber,
  });

  String? requestId;
  String? propertyId;
  String? title;
  String? owner;
  String? status;
  String? createdAt;
  String? image;
  String? city;
  String? district;
  String? adLicenseNumber;

  bool get isPending {
    final value = (status ?? '').toUpperCase();
    return value.isEmpty ||
        value == 'PENDING' ||
        value == 'WAITING' ||
        value == 'NEW';
  }

  String get locationLabel {
    final parts = [
      district,
      city,
    ].whereType<String>().map((e) => e.trim()).where((e) => e.isNotEmpty);
    return parts.join(' - ');
  }

  String get createdAtLabel {
    final parsed = DateTime.tryParse(createdAt ?? '');
    if (parsed == null) return '';
    final local = parsed.toLocal();
    final y = local.year.toString().padLeft(4, '0');
    final m = local.month.toString().padLeft(2, '0');
    final d = local.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  factory BusinessPropertyRequestModel.fromJson(Map<String, dynamic> json) {
    final property = _asMap(json['property'] ?? json['listing']);
    final ownerRaw = json['owner'] ?? json['user'] ?? json['individual'];
    final ownerMap = _asMap(ownerRaw);

    return BusinessPropertyRequestModel(
      requestId: _firstNonEmpty([
        json['requestId'],
        json['request_id'],
        json['id'],
      ]),
      propertyId: _firstNonEmpty([
        json['propertyId'],
        json['property_id'],
        property['id'],
        property['propertyId'],
        property['property_id'],
      ]),
      title: _firstNonEmpty([
        json['title'],
        json['propertyName'],
        json['name'],
        property['title'],
        property['name'],
      ]),
      owner: _firstNonEmpty([
        if (ownerRaw is String) ownerRaw,
        ownerMap['fullName'],
        ownerMap['name'],
        ownerMap['userName'],
        json['ownerName'],
      ]),
      status:
          _firstNonEmpty([json['status'], json['requestStatus']]) ?? 'PENDING',
      createdAt: _firstNonEmpty([
        json['createdAt'],
        json['created_at'],
        json['requestDate'],
        json['date'],
      ]),
      image: PropertyMedia.coverFrom(
        property['media'] ?? json['media'],
        fallback: _firstNonEmpty([
          json['image'],
          json['mainImage'],
          json['cover'],
          property['image'],
          property['mainImage'],
        ]),
      ),
      city: _firstNonEmpty([
        json['city'],
        property['city'],
        _asMap(json['location'])['city'],
        _asMap(property['location'])['city'],
      ]),
      district: _firstNonEmpty([
        json['district'],
        property['district'],
        _asMap(json['location'])['district'],
        _asMap(property['location'])['district'],
      ]),
      adLicenseNumber: _firstNonEmpty([
        json['adLicenseNumber'],
        json['ad_license_number'],
        property['adLicenseNumber'],
      ]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'requestId': requestId,
      'propertyId': propertyId,
      'title': title,
      'owner': owner,
      'status': status,
      'createdAt': createdAt,
      'image': image,
      'city': city,
      'district': district,
      'adLicenseNumber': adLicenseNumber,
    };
  }
}

class PublishedPropertyApplicant {
  const PublishedPropertyApplicant({
    this.id = '',
    this.name = '',
    this.imageUrl = '',
    this.phone = '',
  });

  final String id;
  final String name;
  final String imageUrl;
  final String phone;

  factory PublishedPropertyApplicant.fromJson(Map<String, dynamic> json) {
    return PublishedPropertyApplicant(
      id: _firstNonEmpty([json['id'], json['userId'], json['user_id']]) ?? '',
      name:
          _firstNonEmpty([json['fullName'], json['name'], json['userName']]) ??
          '',
      imageUrl:
          _firstNonEmpty([json['image'], json['avatar'], json['imageUrl']]) ??
          '',
      phone:
          _firstNonEmpty([
            json['phone'],
            json['phoneNumber'],
            json['mobile'],
          ]) ??
          '',
    );
  }
}

class BusinessRequestPublishedPropertyModel {
  const BusinessRequestPublishedPropertyModel({
    required this.id,
    required this.title,
    required this.location,
    required this.imageUrl,
    this.propertyId = '',
    this.price = 0,
    this.listingType = '',
    this.paymentType = '',
    this.wantsInsurance = false,
    this.requestDate = '',
    this.status = '',
    this.applicant = const PublishedPropertyApplicant(),
    this.adLicenseNumber = '',
    this.rejectReason = '',
    this.contractId = '',
    this.contractNo = '',
    this.contractStatus = '',
    this.commissionAmount = 0,
    this.commissionPayer = '',
  });

  final String id;
  final String propertyId;
  final String title;
  final String location;
  final String imageUrl;
  final double price;
  final String listingType;
  final String paymentType;
  final bool wantsInsurance;
  final String requestDate;
  final String status;
  final PublishedPropertyApplicant applicant;
  final String adLicenseNumber;
  final String rejectReason;
  final String contractId;
  final String contractNo;
  final String contractStatus;
  final double commissionAmount;
  final String commissionPayer;

  bool get isRent => listingType.toUpperCase().contains('RENT');
  bool get hasContract => contractId.isNotEmpty;

  bool get isPending {
    final value = status.toUpperCase();
    return value.isEmpty ||
        value == 'PENDING' ||
        value == 'IN_PROGRESS' ||
        value == 'WAITING' ||
        value == 'NEW';
  }

  bool get isRejected => status.toUpperCase() == 'REJECTED';

  BusinessRequestPublishedPropertyModel copyWith({
    String? status,
    String? rejectReason,
    String? contractStatus,
  }) {
    return BusinessRequestPublishedPropertyModel(
      id: id,
      propertyId: propertyId,
      title: title,
      location: location,
      imageUrl: imageUrl,
      price: price,
      listingType: listingType,
      paymentType: paymentType,
      wantsInsurance: wantsInsurance,
      requestDate: requestDate,
      status: status ?? this.status,
      applicant: applicant,
      adLicenseNumber: adLicenseNumber,
      rejectReason: rejectReason ?? this.rejectReason,
      contractId: contractId,
      contractNo: contractNo,
      contractStatus: contractStatus ?? this.contractStatus,
      commissionAmount: commissionAmount,
      commissionPayer: commissionPayer,
    );
  }

  String get requestDateLabel {
    final parsed = DateTime.tryParse(requestDate);
    if (parsed == null) return requestDate;
    final local = parsed.toLocal();
    final y = local.year.toString().padLeft(4, '0');
    final m = local.month.toString().padLeft(2, '0');
    final d = local.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  String get statusKey {
    switch (status.toUpperCase()) {
      case 'ACCEPTED':
      case 'APPROVED':
        return 'request_status_accepted';
      case 'REJECTED':
        return 'request_status_rejected';
      case 'IN_PROGRESS':
      case 'PENDING':
      default:
        return 'request_status_in_progress';
    }
  }

  factory BusinessRequestPublishedPropertyModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final property = _asMap(json['property'] ?? json['listing']);
    final applicantRaw =
        json['requester'] ?? json['applicant'] ?? json['user'] ?? json['owner'];
    final locationRaw = json['location'];
    final locationFromString = locationRaw is String ? locationRaw.trim() : '';
    final city =
        _firstNonEmpty([
          json['city'],
          property['city'],
          _asMap(json['location'])['city'],
        ]) ??
        '';
    final district =
        _firstNonEmpty([
          json['district'],
          property['district'],
          _asMap(json['location'])['district'],
        ]) ??
        '';
    final locationFromParts = [
      district,
      city,
    ].where((e) => e.trim().isNotEmpty).join(' - ');
    final contract = _asMap(json['contract']);
    final priceRaw =
        json['price'] ?? contract['price'] ?? property['price'] ?? 0;
    final commissionRaw = contract['commissionAmount'] ?? 0;

    return BusinessRequestPublishedPropertyModel(
      id:
          _firstNonEmpty([json['requestId'], json['request_id'], json['id']]) ??
          '',
      propertyId:
          _firstNonEmpty([
            json['propertyId'],
            json['property_id'],
            property['id'],
          ]) ??
          '',
      title:
          _firstNonEmpty([
            json['propertyTitle'],
            json['title'],
            json['name'],
            property['title'],
          ]) ??
          '',
      location: locationFromString.isNotEmpty
          ? locationFromString
          : (locationFromParts.isNotEmpty
                ? locationFromParts
                : (_firstNonEmpty([json['address']]) ?? '')),
      imageUrl: PropertyMedia.coverFrom(
        property['media'] ?? json['media'],
        fallback:
            _firstNonEmpty([
              json['propertyImage'],
              json['image'],
              json['imageUrl'],
              json['mainImage'],
              property['image'],
            ]) ??
            '',
      ),
      price: priceRaw is num
          ? priceRaw.toDouble()
          : double.tryParse(priceRaw.toString()) ?? 0,
      listingType:
          _firstNonEmpty([
            json['requestType'],
            json['listingType'],
            json['type'],
            property['listingType'],
          ]) ??
          '',
      paymentType: _firstNonEmpty([json['paymentType'], json['payment_type']]) ?? '',
      wantsInsurance: json['wantsInsurance'] == true,
      requestDate:
          _firstNonEmpty([
            json['createdAt'],
            json['created_at'],
            json['requestDate'],
          ]) ??
          '',
      status: _firstNonEmpty([
            json['status'],
            json['requestStatus'],
            contract['status'],
          ]) ??
          '',
      adLicenseNumber:
          _firstNonEmpty([
            json['adLicenseNumber'],
            json['ad_license_number'],
            property['adLicenseNumber'],
          ]) ??
          '',
      rejectReason:
          _firstNonEmpty([
            json['rejectReason'],
            json['rejectionReason'],
            json['reason'],
            json['note'],
          ]) ??
          '',
      contractId:
          _firstNonEmpty([
            contract['id'],
            contract['contractId'],
            json['contractId'],
          ]) ??
          '',
      contractNo: _firstNonEmpty([contract['contractNo'], contract['title']]) ?? '',
      contractStatus: _firstNonEmpty([contract['status']]) ?? '',
      commissionAmount: commissionRaw is num
          ? commissionRaw.toDouble()
          : double.tryParse(commissionRaw.toString()) ?? 0,
      commissionPayer: _firstNonEmpty([contract['commissionPayer']]) ?? '',
      applicant: applicantRaw is Map
          ? PublishedPropertyApplicant.fromJson(
              Map<String, dynamic>.from(applicantRaw),
            )
          : PublishedPropertyApplicant(name: applicantRaw?.toString() ?? ''),
    );
  }
}

Map<String, dynamic> _asMap(dynamic value) {
  if (value is Map) return Map<String, dynamic>.from(value);
  return const {};
}

String? _firstNonEmpty(List<dynamic> values) {
  for (final value in values) {
    if (value == null) continue;
    final text = value.toString().trim();
    if (text.isNotEmpty && text != 'null') return text;
  }
  return null;
}
