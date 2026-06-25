import 'package:equatable/equatable.dart';

enum UnitStatus { rented, vacant }

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

  int get totalUnits => units.length;
  int get rentedCount => units.where((u) => u.status == UnitStatus.rented).length;
  int get vacantCount => units.where((u) => u.status == UnitStatus.vacant).length;

  PropertyFileModel copyWith({bool? isBookmarked}) => PropertyFileModel(
        id: id,
        name: name,
        location: location,
        imageUrl: imageUrl,
        propertyType: propertyType,
        monthlyRevenue: monthlyRevenue,
        occupancyRate: occupancyRate,
        units: units,
        isBookmarked: isBookmarked ?? this.isBookmarked,
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
  });

  final String id;
  final String number;   // e.g. "A1"
  final String label;    // e.g. "شقة A1"
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

  UnitModel copyWith({
    UnitStatus? status,
    String? tenantName,
    String? tenantPhone,
    String? rentStartDate,
    String? rentEndDate,
    bool? isHijriDate,
    List<UnitExpenseModel>? expenses,
  }) =>
      UnitModel(
        id: id,
        number: number,
        label: label,
        status: status ?? this.status,
        area: area,
        rooms: rooms,
        bathrooms: bathrooms,
        monthlyRent: monthlyRent,
        floor: floor,
        tenantName: tenantName ?? this.tenantName,
        tenantPhone: tenantPhone ?? this.tenantPhone,
        rentStartDate: rentStartDate ?? this.rentStartDate,
        rentEndDate: rentEndDate ?? this.rentEndDate,
        isHijriDate: isHijriDate ?? this.isHijriDate,
        expenses: expenses ?? this.expenses,
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
      ];
}

class UnitExpenseModel extends Equatable {
  const UnitExpenseModel({
    required this.description,
    required this.amount,
  });

  final String description;
  final double amount;

  @override
  List<Object?> get props => [description, amount];
}
