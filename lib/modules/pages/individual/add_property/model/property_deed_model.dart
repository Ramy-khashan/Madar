import 'package:equatable/equatable.dart';

class PropertyDeedModel extends Equatable {
  const PropertyDeedModel({
    required this.deedType,
    this.deedNumber,
    this.calendarType,
    this.deedDate,
    this.customTypeName,
    this.ownershipDocumentPath,
  });

  final String deedType;
  final String? deedNumber;
  final String? calendarType;

  final String? deedDate;
  final String? customTypeName;
  final String? ownershipDocumentPath;

  bool get hasOwnershipDocument =>
      ownershipDocumentPath != null && ownershipDocumentPath!.isNotEmpty;

  Map<String, String> toFields(int index) {
    final prefix = 'deeds[$index]';
    return {
      '$prefix[deedType]': deedType,
      if (deedNumber != null && deedNumber!.isNotEmpty)
        '$prefix[deedNumber]': deedNumber!,
      if (calendarType != null && calendarType!.isNotEmpty)
        '$prefix[calendarType]': calendarType!,
      if (deedDate != null && deedDate!.isNotEmpty)
        '$prefix[deedDate]': deedDate!,
      if (customTypeName != null && customTypeName!.isNotEmpty)
        '$prefix[customTypeName]': customTypeName!,
    };
  }

  String ownershipDocumentField(int index) =>
      'deeds[$index][ownershipDocument]';

  PropertyDeedModel copyWith({
    String? deedType,
    String? deedNumber,
    String? calendarType,
    String? deedDate,
    String? customTypeName,
    String? ownershipDocumentPath,
  }) {
    return PropertyDeedModel(
      deedType: deedType ?? this.deedType,
      deedNumber: deedNumber ?? this.deedNumber,
      calendarType: calendarType ?? this.calendarType,
      deedDate: deedDate ?? this.deedDate,
      customTypeName: customTypeName ?? this.customTypeName,
      ownershipDocumentPath:
          ownershipDocumentPath ?? this.ownershipDocumentPath,
    );
  }

  @override
  List<Object?> get props => [
    deedType,
    deedNumber,
    calendarType,
    deedDate,
    customTypeName,
    ownershipDocumentPath,
  ];
  Map<String, String> toJson() {
    return {
      'deedType': deedType,
      'deedNumber': ?deedNumber,
      'calendarType': ?calendarType,
      'deedDate': ?deedDate,
      'customTypeName': ?customTypeName,
    };
  }
}
