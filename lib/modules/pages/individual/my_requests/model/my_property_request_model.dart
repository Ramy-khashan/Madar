class MyPropertyRequestModel {
  const MyPropertyRequestModel({
    required this.id,
    this.propertyId = '',
    this.userId = '',
    this.requestType = '',
    this.paymentType = '',
    this.status = '',
    this.note = '',
    this.createdAt = '',
    this.updatedAt = '',
    this.propertyTitle = '',
    this.propertyImage = '',
    this.propertyLocation = '',
    this.price,
    this.contract,
  });

  final String id;
  final String propertyId;
  final String userId;
  final String requestType;
  final String paymentType;
  final String status;
  final String note;
  final String createdAt;
  final String updatedAt;
  final String propertyTitle;
  final String propertyImage;
  final String propertyLocation;
  final double? price;
  final MyRequestContractModel? contract;

  bool get isPending {
    final value = status.toUpperCase();
    return value.isEmpty ||
        value == 'PENDING' ||
        value == 'WAITING' ||
        value == 'NEW' ||
        value == 'IN_PROGRESS';
  }

  bool get isRejected => status.toUpperCase() == 'REJECTED';

  bool get isBrokerApproved {
    final value = status.toUpperCase();
    return value == 'APPROVED' ||
        value == 'ACCEPTED' ||
        value == 'CONTRACT_PENDING' ||
        value == 'AWAITING_BUYER' ||
        value == 'AWAITING_SIGNATURE';
  }

  bool get canDelete => id.isNotEmpty && isPending;

  bool get canRespondToContract {
    if (!isBrokerApproved || id.isEmpty) return false;
    final contractStatus = (contract?.status ?? '').toUpperCase();
    if (contractStatus.isEmpty) return true;
    return contractStatus == 'PENDING' ||
        contractStatus == 'WAITING' ||
        contractStatus == 'NEW';
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

  String get createdAtLabel {
    final parsed = DateTime.tryParse(createdAt);
    if (parsed == null) return createdAt;
    final local = parsed.toLocal();
    final y = local.year.toString().padLeft(4, '0');
    final m = local.month.toString().padLeft(2, '0');
    final d = local.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  MyPropertyRequestModel copyWith({
    String? status,
    MyRequestContractModel? contract,
  }) {
    return MyPropertyRequestModel(
      id: id,
      propertyId: propertyId,
      userId: userId,
      requestType: requestType,
      paymentType: paymentType,
      status: status ?? this.status,
      note: note,
      createdAt: createdAt,
      updatedAt: updatedAt,
      propertyTitle: propertyTitle,
      propertyImage: propertyImage,
      propertyLocation: propertyLocation,
      price: price,
      contract: contract ?? this.contract,
    );
  }

  factory MyPropertyRequestModel.fromJson(Map<String, dynamic> json) {
    final request = _asMap(json['request']).isNotEmpty
        ? _asMap(json['request'])
        : json;
    final property = _asMap(
      request['property'] ?? json['property'] ?? json['listing'],
    );
    final locationMap = _asMap(
      property['location'] ?? request['location'] ?? json['location'],
    );
    final contractMap = _asMap(json['contract'] ?? request['contract']);
    final priceRaw =
        json['price'] ??
        request['price'] ??
        property['price'] ??
        contractMap['price'];

    final city = _firstNonEmpty([
      json['city'],
      request['city'],
      property['city'],
      locationMap['city'],
    ]);
    final district = _firstNonEmpty([
      json['district'],
      request['district'],
      property['district'],
      locationMap['district'],
    ]);
    final location = _firstNonEmpty([
      json['propertyLocation'],
      json['location'],
      request['location'] is String ? request['location'] : null,
      [district, city].where((e) => (e ?? '').trim().isNotEmpty).join(' - '),
    ]);

    return MyPropertyRequestModel(
      id:
          _firstNonEmpty([
            request['id'],
            request['requestId'],
            request['request_id'],
            json['id'],
            json['requestId'],
          ]) ??
          '',
      propertyId:
          _firstNonEmpty([
            request['propertyId'],
            request['property_id'],
            json['propertyId'],
            property['id'],
            property['propertyId'],
          ]) ??
          '',
      userId:
          _firstNonEmpty([
            request['userId'],
            request['user_id'],
            json['userId'],
            json['buyerId'],
          ]) ??
          '',
      requestType:
          _firstNonEmpty([
            request['requestType'],
            json['requestType'],
            json['type'],
            property['listingType'],
          ]) ??
          '',
      paymentType:
          _firstNonEmpty([request['paymentType'], json['paymentType']]) ?? '',
      status: _firstNonEmpty([request['status'], json['status']]) ?? '',
      note: _firstNonEmpty([request['note'], json['note']]) ?? '',
      createdAt:
          _firstNonEmpty([request['createdAt'], json['createdAt']]) ?? '',
      updatedAt:
          _firstNonEmpty([request['updatedAt'], json['updatedAt']]) ?? '',
      propertyTitle:
          _firstNonEmpty([
            json['propertyTitle'],
            request['propertyTitle'],
            property['title'],
            property['name'],
            json['title'],
          ]) ??
          '',
      propertyImage:
          _firstNonEmpty([
            json['propertyImage'],
            json['image'],
            property['image'],
            property['mainImage'],
            property['coverImage'],
          ]) ??
          '',
      propertyLocation: location ?? '',
      price: _asDouble(priceRaw),
      contract: contractMap.isEmpty
          ? null
          : MyRequestContractModel.fromJson(contractMap),
    );
  }

  static Map<String, dynamic> _asMap(dynamic value) {
    if (value is Map) return Map<String, dynamic>.from(value);
    return const {};
  }

  static String? _firstNonEmpty(List<dynamic> values) {
    for (final value in values) {
      if (value == null) continue;
      final text = value.toString().trim();
      if (text.isNotEmpty && text != 'null') return text;
    }
    return null;
  }

  static double? _asDouble(dynamic value) {
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '');
  }
}

class MyRequestContractModel {
  const MyRequestContractModel({
    required this.id,
    this.contractNo = '',
    this.status = '',
    this.type = '',
    this.price,
    this.commissionAmount,
    this.commissionPayer = '',
    this.startDate = '',
    this.endDate = '',
    this.buyerId = '',
    this.sellerId = '',
    this.brokerId = '',
  });

  final String id;
  final String contractNo;
  final String status;
  final String type;
  final double? price;
  final double? commissionAmount;
  final String commissionPayer;
  final String startDate;
  final String endDate;
  final String buyerId;
  final String sellerId;
  final String brokerId;

  MyRequestContractModel copyWith({String? status}) {
    return MyRequestContractModel(
      id: id,
      contractNo: contractNo,
      status: status ?? this.status,
      type: type,
      price: price,
      commissionAmount: commissionAmount,
      commissionPayer: commissionPayer,
      startDate: startDate,
      endDate: endDate,
      buyerId: buyerId,
      sellerId: sellerId,
      brokerId: brokerId,
    );
  }

  factory MyRequestContractModel.fromJson(Map<String, dynamic> json) {
    return MyRequestContractModel(
      id: MyPropertyRequestModel._firstNonEmpty([json['id']]) ?? '',
      contractNo:
          MyPropertyRequestModel._firstNonEmpty([
            json['contractNo'],
            json['contract_no'],
          ]) ??
          '',
      status: MyPropertyRequestModel._firstNonEmpty([json['status']]) ?? '',
      type: MyPropertyRequestModel._firstNonEmpty([json['type']]) ?? '',
      price: MyPropertyRequestModel._asDouble(json['price']),
      commissionAmount: MyPropertyRequestModel._asDouble(
        json['commissionAmount'] ?? json['commission_amount'],
      ),
      commissionPayer:
          MyPropertyRequestModel._firstNonEmpty([
            json['commissionPayer'],
            json['commission_payer'],
          ]) ??
          '',
      startDate:
          MyPropertyRequestModel._firstNonEmpty([json['startDate']]) ?? '',
      endDate: MyPropertyRequestModel._firstNonEmpty([json['endDate']]) ?? '',
      buyerId: MyPropertyRequestModel._firstNonEmpty([json['buyerId']]) ?? '',
      sellerId: MyPropertyRequestModel._firstNonEmpty([json['sellerId']]) ?? '',
      brokerId: MyPropertyRequestModel._firstNonEmpty([json['brokerId']]) ?? '',
    );
  }
}
