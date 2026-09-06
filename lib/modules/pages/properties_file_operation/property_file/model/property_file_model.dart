import 'package:equatable/equatable.dart';

import '../../../../../core/utils/constants/app_strings.dart';
import '../../../individual/add_property/model/property_enums.dart';
import '../../../individual/property_details/model/property_details_model.dart';

enum UnitStatus { rented, vacant, sold }

UnitStatus unitStatusFrom(String? raw) {
  final value = (raw ?? '').toUpperCase();
  if (value.contains('SOLD')) return UnitStatus.sold;
  if (value.contains('RENT') || value == 'OCCUPIED' || value == 'LEASED') {
    return UnitStatus.rented;
  }
  return UnitStatus.vacant;
}

class PropertyFileModel extends Equatable {
  const PropertyFileModel({
    required this.id,
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.propertyType,
    required this.monthlyRevenue,
    required this.occupancyRate,
    required this.units,
    this.isBookmarked = false,
    this.rawType = '',
    this.declaredTotalUnits = 0,
    this.floorsCount = 0,
    this.shopsCount = 0,
    this.parkingSpots = 0,
    this.buildingArea = 0,
  });

  final String id;
  final String name;
  final String location;
  final String imageUrl;
  final String propertyType;
  final double monthlyRevenue;
  final int occupancyRate;
  final List<UnitModel> units;
  final bool isBookmarked;
  final String rawType;
  final int declaredTotalUnits;
  final int floorsCount;
  final int shopsCount;
  final int parkingSpots;
  final double buildingArea;

  bool get isMultiUnit => isMultiUnitType(rawType);

  static bool isMultiUnitType(String? type) {
    final t = (type ?? '').toUpperCase();
    return t == PropertyApiEnums.typeTower ||
        t == PropertyApiEnums.typeBuilding;
  }

  static String labelForType(String? type) {
    switch ((type ?? '').toUpperCase()) {
      case PropertyApiEnums.typeApartment:
        return AppStrings.propertyTypeApartment;
      case PropertyApiEnums.typeVilla:
        return AppStrings.propertyTypeVilla;
      case PropertyApiEnums.typeFloor:
        return AppStrings.propertyTypeFloor;
      case PropertyApiEnums.typeTownhouse:
        return AppStrings.propertyTypeTownhouse;
      case PropertyApiEnums.typeBuilding:
        return AppStrings.propertyTypeBuilding;
      case PropertyApiEnums.typeLand:
        return AppStrings.propertyTypeLand;
      case PropertyApiEnums.typeRestHouse:
        return AppStrings.propertyTypeRestHouse;
      case PropertyApiEnums.typeTower:
        return AppStrings.propertyTypeTower;
      case PropertyApiEnums.typeShop:
        return AppStrings.propertyTypeShop;
      case PropertyApiEnums.typeOffice:
        return AppStrings.propertyTypeOffice;
      case PropertyApiEnums.typeFarm:
        return AppStrings.propertyTypeFarm;
      case PropertyApiEnums.typeWarehouse:
        return AppStrings.propertyTypeWarehouse;
      default:
        return type ?? '';
    }
  }

  int get totalUnits {
    if (declaredTotalUnits > units.length) return declaredTotalUnits;
    return units.length;
  }
  int get rentedCount =>
      units.where((u) => u.status == UnitStatus.rented).length;
  int get vacantCount =>
      units.where((u) => u.status == UnitStatus.vacant).length;

  factory PropertyFileModel.fromDetails(PropertyDetailsModel p) {
    final loc = [
      p.location?.city,
      p.location?.district,
      p.location?.street,
    ].whereType<String>().where((e) => e.isNotEmpty).join(' - ');
    final media = p.media ?? [];
    final units = (p.childProperties ?? [])
        .asMap()
        .entries
        .map((e) => UnitModel.fromChild(e.value, e.key))
        .toList();
    final occupied = units.where((u) => u.status != UnitStatus.vacant).length;
    final apiRate =
        p.financialPerformance?.occupancyRate ?? p.details?.occupancyRate;
    final declared =
        p.details?.totalApartments ??
        p.financialPerformance?.totalChildUnits ??
        0;
    return PropertyFileModel(
      id: p.propertyId ?? '',
      name: p.title ?? '',
      location: loc,
      imageUrl: media.coverUrl,
      propertyType: labelForType(p.type),
      occupancyRate: (apiRate != null && apiRate > 0)
          ? apiRate
          : (units.isEmpty ? 0 : ((occupied / units.length) * 100).round()),
      monthlyRevenue: (p.financialPerformance?.monthlyIncome ??
              p.details?.estimatedIncome ??
              0)
          .toDouble(),
      units: units,
      rawType: p.type ?? '',
      declaredTotalUnits: declared,
      floorsCount: p.details?.floorsCount ?? 0,
      shopsCount: p.details?.shopsCount ?? 0,
      parkingSpots: p.details?.parkingSpots ?? p.details?.totalParking ?? 0,
      buildingArea: (p.totalArea ?? p.details?.totalArea ?? 0).toDouble(),
    );
  }

  PropertyFileModel copyWith({
    bool? isBookmarked,
    List<UnitModel>? units,
    String? name,
  }) => PropertyFileModel(
    id: id,
    name: name ?? this.name,
    location: location,
    imageUrl: imageUrl,
    propertyType: propertyType,
    monthlyRevenue: monthlyRevenue,
    occupancyRate: occupancyRate,
    units: units ?? this.units,
    isBookmarked: isBookmarked ?? this.isBookmarked,
    rawType: rawType,
    declaredTotalUnits: declaredTotalUnits,
    floorsCount: floorsCount,
    shopsCount: shopsCount,
    parkingSpots: parkingSpots,
    buildingArea: buildingArea,
  );

  @override
  List<Object?> get props => [
    id,
    name,
    location,
    imageUrl,
    propertyType,
    monthlyRevenue,
    occupancyRate,
    units,
    isBookmarked,
    rawType,
    declaredTotalUnits,
    floorsCount,
    shopsCount,
    parkingSpots,
    buildingArea,
  ];
}

class UnitModel extends Equatable {
  const UnitModel({
    required this.id,
    required this.number,
    required this.label,
    required this.status,
    required this.area,
    required this.rooms,
    required this.bathrooms,
    required this.monthlyRent,
    required this.floor,
    this.tenantName = '',
    this.tenantPhone = '',
    this.rentStartDate = '',
    this.rentEndDate = '',
    this.isHijriDate = true,
    this.expenses = const [],
    this.projectName = '',
    this.imageUrl = '',
    this.listingType = '',
    this.rawStatus = '',
    this.buildingId = '',
  });

  final String id;
  final String number;
  final String label;
  final UnitStatus status;
  final double area;
  final int rooms;
  final int bathrooms;
  final double monthlyRent;
  final int floor;
  final String tenantName;
  final String tenantPhone;
  final String rentStartDate;
  final String rentEndDate;
  final bool isHijriDate;
  final List<UnitExpenseModel> expenses;
  final String projectName;
  final String imageUrl;
  final String listingType;
  final String rawStatus;
  final String buildingId;

  factory UnitModel.fromChild(ChildProperty child, int index) {
    final title = (child.title ?? '').trim();
    final unitNumber = (child.unitNumber ?? '').trim();
    final unitId = unitNumber.isNotEmpty
        ? unitNumber
        : (title.isNotEmpty ? title : '${index + 1}');
    final tenancy = (child.tenancyStatus ?? '').trim();
    final statusRaw = tenancy.isNotEmpty ? tenancy : (child.status ?? '');
    return UnitModel(
      id: child.propertyId ?? '',
      number: unitId,
      label: title.isNotEmpty ? title : unitId,
      status: unitStatusFrom(statusRaw),
      area: (child.totalArea ?? 0).toDouble(),
      rooms: child.rooms ?? 0,
      bathrooms: child.bathrooms ?? 0,
      monthlyRent: (child.monthlyRent ?? child.price ?? 0).toDouble(),
      floor: 0,
      imageUrl: child.mainImage ?? '',
      listingType: child.listingType ?? '',
      rawStatus: statusRaw,
    );
  }

  factory UnitModel.fromBuildingApartment(BuildingApartmentModel apartment) {
    final t = apartment.tenancy;
    return UnitModel(
      id: apartment.propertyId,
      number: apartment.unitNumber,
      label: apartment.unitNumber,
      status: unitStatusFrom(t.status),
      area: apartment.totalArea,
      rooms: apartment.rooms,
      bathrooms: apartment.bathrooms,
      monthlyRent: t.monthlyRent,
      floor: 0,
      tenantName: t.tenantName,
      tenantPhone: t.tenantPhone,
      rentStartDate: t.startDate,
      rentEndDate: t.endDate,
      isHijriDate: t.calendarType.toUpperCase() == 'HIJRI',
      expenses: apartment.expenses,
      rawStatus: t.status,
      buildingId: apartment.buildingId,
    );
  }

  factory UnitModel.fromDetails(PropertyDetailsModel p, {UnitModel? base}) {
    final d = p.details;
    final expenses = (p.expenses ?? [])
        .map(
          (e) => UnitExpenseModel(
            id: e.id,
            description: e.expenseType ?? e.title ?? '',
            amount: (e.amount ?? 0).toDouble(),
            fileUrl: e.fileUrl,
            createdAt: e.createdAt,
          ),
        )
        .toList();
    return UnitModel(
      id: p.propertyId ?? base?.id ?? '',
      number: base?.number ?? p.title ?? '',
      label: p.title ?? base?.label ?? '',
      status: unitStatusFrom(p.status ?? base?.rawStatus),
      area: (d?.area ?? d?.totalArea ?? p.totalArea ?? 0).toDouble(),
      rooms: d?.bedrooms ?? d?.roomsCount ?? 0,
      bathrooms: d?.bathrooms ?? 0,
      monthlyRent: (p.price ?? base?.monthlyRent ?? 0).toDouble(),
      floor: d?.floor ?? 0,
      tenantName: base?.tenantName ?? '',
      tenantPhone: base?.tenantPhone ?? '',
      rentStartDate: base?.rentStartDate ?? '',
      rentEndDate: base?.rentEndDate ?? '',
      isHijriDate: base?.isHijriDate ?? true,
      expenses: expenses,
      projectName: p.projectName ?? base?.projectName ?? '',
      imageUrl: (p.media ?? []).coverUrl.isNotEmpty
          ? (p.media ?? []).coverUrl
          : (base?.imageUrl ?? ''),
      listingType: p.listingType ?? base?.listingType ?? '',
      rawStatus: p.status ?? base?.rawStatus ?? '',
      buildingId: base?.buildingId ?? '',
    );
  }

  UnitModel copyWith({
    UnitStatus? status,
    String? tenantName,
    String? tenantPhone,
    String? rentStartDate,
    String? rentEndDate,
    bool? isHijriDate,
    List<UnitExpenseModel>? expenses,
    String? label,
    String? number,
    double? area,
    int? rooms,
    int? bathrooms,
    double? monthlyRent,
    int? floor,
    String? projectName,
    String? imageUrl,
    String? listingType,
    String? rawStatus,
    String? buildingId,
  }) => UnitModel(
    id: id,
    number: number ?? this.number,
    label: label ?? this.label,
    status: status ?? this.status,
    area: area ?? this.area,
    rooms: rooms ?? this.rooms,
    bathrooms: bathrooms ?? this.bathrooms,
    monthlyRent: monthlyRent ?? this.monthlyRent,
    floor: floor ?? this.floor,
    tenantName: tenantName ?? this.tenantName,
    tenantPhone: tenantPhone ?? this.tenantPhone,
    rentStartDate: rentStartDate ?? this.rentStartDate,
    rentEndDate: rentEndDate ?? this.rentEndDate,
    isHijriDate: isHijriDate ?? this.isHijriDate,
    expenses: expenses ?? this.expenses,
    projectName: projectName ?? this.projectName,
    imageUrl: imageUrl ?? this.imageUrl,
    listingType: listingType ?? this.listingType,
    rawStatus: rawStatus ?? this.rawStatus,
    buildingId: buildingId ?? this.buildingId,
  );

  @override
  List<Object?> get props => [
    id,
    number,
    label,
    status,
    area,
    rooms,
    bathrooms,
    monthlyRent,
    floor,
    tenantName,
    tenantPhone,
    rentStartDate,
    rentEndDate,
    isHijriDate,
    expenses,
    projectName,
    imageUrl,
    listingType,
    rawStatus,
    buildingId,
  ];
}

class UnitExpenseModel extends Equatable {
  const UnitExpenseModel({
    required this.description,
    required this.amount,
    this.id,
    this.fileUrl,
    this.createdAt,
  });

  final String? id;
  final String description;
  final double amount;
  final String? fileUrl;
  final String? createdAt;

  bool get isRemote => (id ?? '').isNotEmpty;

  factory UnitExpenseModel.fromJson(Map<String, dynamic> json) {
    final file = json['file'] ?? json['fileUrl'];
    final fileText = file?.toString().trim() ?? '';
    return UnitExpenseModel(
      id: json['id']?.toString(),
      description: (json['expenseType'] ?? json['title'] ?? json['type'] ?? '')
          .toString(),
      amount: _asNum(json['amount']),
      fileUrl: fileText.isEmpty || fileText == 'null' ? null : fileText,
      createdAt: json['createdAt']?.toString(),
    );
  }

  @override
  List<Object?> get props => [id, description, amount, fileUrl, createdAt];
}

class BuildingApartmentTenancy extends Equatable {
  const BuildingApartmentTenancy({
    this.status = 'VACANT',
    this.tenantName = '',
    this.tenantPhone = '',
    this.monthlyRent = 0,
    this.startDate = '',
    this.endDate = '',
    this.calendarType = 'GREGORIAN',
  });

  final String status;
  final String tenantName;
  final String tenantPhone;
  final double monthlyRent;
  final String startDate;
  final String endDate;
  final String calendarType;

  bool get isRented => status.toUpperCase() == 'RENTED';

  factory BuildingApartmentTenancy.fromJson(Map<String, dynamic> json) {
    return BuildingApartmentTenancy(
      status: (json['status'] ?? 'VACANT').toString(),
      tenantName: (json['tenantName'] ?? '').toString(),
      tenantPhone: (json['tenantPhone'] ?? '').toString(),
      monthlyRent: _asNum(json['monthlyRent']),
      startDate: _dateOnly(json['startDate']),
      endDate: _dateOnly(json['endDate']),
      calendarType: (json['calendarType'] ?? 'GREGORIAN').toString(),
    );
  }

  @override
  List<Object?> get props => [
    status,
    tenantName,
    tenantPhone,
    monthlyRent,
    startDate,
    endDate,
    calendarType,
  ];
}

class BuildingApartmentModel extends Equatable {
  const BuildingApartmentModel({
    required this.propertyId,
    required this.unitNumber,
    required this.buildingId,
    this.buildingName = '',
    this.totalArea = 0,
    this.rooms = 0,
    this.bathrooms = 0,
    this.tenancy = const BuildingApartmentTenancy(),
    this.expenses = const [],
  });

  final String propertyId;
  final String unitNumber;
  final String buildingId;
  final String buildingName;
  final double totalArea;
  final int rooms;
  final int bathrooms;
  final BuildingApartmentTenancy tenancy;
  final List<UnitExpenseModel> expenses;

  factory BuildingApartmentModel.fromJson(Map<String, dynamic> json) {
    final tenancyRaw = json['tenancy'];
    return BuildingApartmentModel(
      propertyId: (json['property_id'] ?? json['propertyId'] ?? '').toString(),
      unitNumber: (json['unitNumber'] ?? '').toString(),
      buildingId: (json['buildingId'] ?? '').toString(),
      buildingName: (json['buildingName'] ?? '').toString(),
      totalArea: _asNum(json['totalArea']),
      rooms: _asNum(json['rooms']).toInt(),
      bathrooms: _asNum(json['bathrooms']).toInt(),
      tenancy: tenancyRaw is Map
          ? BuildingApartmentTenancy.fromJson(
              Map<String, dynamic>.from(tenancyRaw),
            )
          : BuildingApartmentTenancy(
              status: (json['status'] ?? 'VACANT').toString(),
            ),
      expenses: (json['expenses'] is List)
          ? (json['expenses'] as List)
                .whereType<Map>()
                .map(
                  (e) => UnitExpenseModel.fromJson(
                    Map<String, dynamic>.from(e),
                  ),
                )
                .toList()
          : const [],
    );
  }

  @override
  List<Object?> get props => [
    propertyId,
    unitNumber,
    buildingId,
    buildingName,
    totalArea,
    rooms,
    bathrooms,
    tenancy,
    expenses,
  ];
}

double _asNum(dynamic value) {
  if (value is num) return value.toDouble();
  return double.tryParse(value?.toString() ?? '') ?? 0;
}

String _dateOnly(dynamic value) {
  final text = value?.toString() ?? '';
  if (text.isEmpty || text == 'null') return '';
  return text.split('T').first;
}

