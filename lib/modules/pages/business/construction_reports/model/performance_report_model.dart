import 'package:equatable/equatable.dart';

class PerformanceCountItem extends Equatable {
  const PerformanceCountItem({this.count = 0, this.percent = 0});

  final int count;
  final double percent;

  factory PerformanceCountItem.fromJson(Map<String, dynamic> json) {
    return PerformanceCountItem(
      count: _asDouble(json['count']).toInt(),
      percent: _asDouble(json['percent']),
    );
  }

  double get ratio {
    if (percent <= 0) return 0;
    return percent > 1 ? (percent / 100).clamp(0.0, 1.0) : percent;
  }

  @override
  List<Object?> get props => [count, percent];
}

class OccupancyPoint extends Equatable {
  const OccupancyPoint({required this.month, required this.occupancyRate});

  final String month;
  final double occupancyRate;

  factory OccupancyPoint.fromJson(Map<String, dynamic> json) {
    return OccupancyPoint(
      month: (json['month'] ?? '').toString(),
      occupancyRate: _asDouble(json['occupancyRate']),
    );
  }

  @override
  List<Object?> get props => [month, occupancyRate];
}

class ContractMovementPoint extends Equatable {
  const ContractMovementPoint({required this.month, required this.count});

  final String month;
  final double count;

  factory ContractMovementPoint.fromJson(Map<String, dynamic> json) {
    return ContractMovementPoint(
      month: (json['month'] ?? '').toString(),
      count: _asDouble(json['count']),
    );
  }

  @override
  List<Object?> get props => [month, count];
}

class PerformanceReportModel extends Equatable {
  const PerformanceReportModel({
    this.activeContracts = const PerformanceCountItem(),
    this.occupancyRate = 0,
    this.monthlyIncome = 0,
    this.occupancyOverTime = const [],
    this.rented = const PerformanceCountItem(),
    this.vacant = const PerformanceCountItem(),
    this.contractActive = const PerformanceCountItem(),
    this.contractCompleted = const PerformanceCountItem(),
    this.contractRenewing = const PerformanceCountItem(),
    this.contractMovement = const [],
  });

  final PerformanceCountItem activeContracts;
  final double occupancyRate;
  final double monthlyIncome;
  final List<OccupancyPoint> occupancyOverTime;
  final PerformanceCountItem rented;
  final PerformanceCountItem vacant;
  final PerformanceCountItem contractActive;
  final PerformanceCountItem contractCompleted;
  final PerformanceCountItem contractRenewing;
  final List<ContractMovementPoint> contractMovement;

  String get occupancyRateLabel {
    final value = occupancyRate <= 1 ? occupancyRate * 100 : occupancyRate;
    return '${value.toStringAsFixed(0)}%';
  }

  factory PerformanceReportModel.fromJson(Map<String, dynamic> json) {
    final propertyStatus = _asMap(json['propertyStatus']);
    final contractStatus = _asMap(json['contractStatus']);
    return PerformanceReportModel(
      activeContracts: PerformanceCountItem.fromJson(
        json['activeContracts'] is Map
            ? Map<String, dynamic>.from(json['activeContracts'] as Map)
            : {'count': json['activeContracts']},
      ),
      occupancyRate: _asDouble(json['occupancyRate']),
      monthlyIncome: _asDouble(json['monthlyIncome']),
      occupancyOverTime: _asMapList(
        json['occupancyOverTime'],
      ).map(OccupancyPoint.fromJson).toList(),
      rented: PerformanceCountItem.fromJson(_asMap(propertyStatus['rented'])),
      vacant: PerformanceCountItem.fromJson(_asMap(propertyStatus['vacant'])),
      contractActive: PerformanceCountItem.fromJson(
        _asMap(contractStatus['active']),
      ),
      contractCompleted: PerformanceCountItem.fromJson(
        _asMap(contractStatus['completed']),
      ),
      contractRenewing: PerformanceCountItem.fromJson(
        _asMap(contractStatus['renewing']),
      ),
      contractMovement: _asMapList(
        json['contractMovement'],
      ).map(ContractMovementPoint.fromJson).toList(),
    );
  }

  @override
  List<Object?> get props => [
    activeContracts,
    occupancyRate,
    monthlyIncome,
    occupancyOverTime,
    rented,
    vacant,
    contractActive,
    contractCompleted,
    contractRenewing,
    contractMovement,
  ];
}

double _asDouble(dynamic value) {
  if (value is num) return value.toDouble();
  return double.tryParse(value?.toString() ?? '') ?? 0;
}

Map<String, dynamic> _asMap(dynamic value) {
  if (value is Map) return Map<String, dynamic>.from(value);
  return const {};
}

List<Map<String, dynamic>> _asMapList(dynamic value) {
  if (value is! List) return const [];
  return value
      .whereType<Map>()
      .map((e) => Map<String, dynamic>.from(e))
      .toList();
}
