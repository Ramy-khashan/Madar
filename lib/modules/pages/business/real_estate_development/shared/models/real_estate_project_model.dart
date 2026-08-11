// import 'package:equatable/equatable.dart';

// import '../../../../../../core/utils/constants/app_constant.dart';
// import 'project_phase_model.dart';
// import 'project_timeline_model.dart';

// class RealEstateProjectModel extends Equatable {
//   const RealEstateProjectModel({
//     required this.id,
//     required this.name,
//     required this.location,
//     required this.status,
//     required this.completionPercentage,
//     required this.lastUpdate,
//     this.imageUrl = '',
//     this.type = AppConstant.residentialProjectType,
//     this.budget = 0,
//     this.startDate = '',
//     this.expectedEndDate = '',
//     this.mainPhases = '',
//     this.roomsCount = 0,
//     this.bathroomsCount = 0,
//     this.area = 0,
//     this.balconyCount = 0,
//     this.floorNumber = 0,
//     this.propertyNumber = '',
//     this.unitsCount = 0,
//     this.parkingSpots = 0,
//     this.tenants = '',
//     this.inProgressPhasesCount = 0,
//     this.delayedPhasesCount = 0,
//     this.phases = const [],
//     this.timeline = const [],
//     this.smartNotes = const [],
//     this.pdfReportUrl,
//     this.attachmentUrl,
//   });

//   final String id;
//   final String name;
//   final String location;

//   /// 'in_progress' | 'delayed' | 'completed'
//   final String status;
//   final double completionPercentage;
//   final String lastUpdate;
//   final String imageUrl;
//   final String type;
//   final double budget;
//   final String startDate;
//   final String expectedEndDate;
//   final String mainPhases;
//   final int roomsCount;
//   final int bathroomsCount;
//   final double area;
//   final int balconyCount;
//   final int floorNumber;
//   final String propertyNumber;
//   final int unitsCount;
//   final int parkingSpots;
//   final String tenants;
//   final int inProgressPhasesCount;
//   final int delayedPhasesCount;
//   final List<ProjectPhaseModel> phases;
//   final List<ProjectTimelineModel> timeline;
//   final List<String> smartNotes;
//   final String? pdfReportUrl;
//   final String? attachmentUrl;

//   factory RealEstateProjectModel.fromJson(Map<String, dynamic> json) =>
//       RealEstateProjectModel(
//         id: json['id'] as String? ?? '',
//         name: json['name'] as String? ?? '',
//         location: json['location'] as String? ?? '',
//         status: json['status'] as String? ?? 'in_progress',
//         completionPercentage:
//             (json['completionPercentage'] as num?)?.toDouble() ?? 0,
//         lastUpdate: json['lastUpdate'] as String? ?? '',
//         imageUrl: json['imageUrl'] as String? ?? '',
//         type: json['type'] as String? ?? AppConstant.residentialProjectType,
//         budget: (json['budget'] as num?)?.toDouble() ?? 0,
//         startDate: json['startDate'] as String? ?? '',
//         expectedEndDate: json['expectedEndDate'] as String? ?? '',
//         mainPhases: json['mainPhases'] as String? ?? '',
//         roomsCount: json['roomsCount'] as int? ?? 0,
//         bathroomsCount: json['bathroomsCount'] as int? ?? 0,
//         area: (json['area'] as num?)?.toDouble() ?? 0,
//         balconyCount: json['balconyCount'] as int? ?? 0,
//         floorNumber: json['floorNumber'] as int? ?? 0,
//         propertyNumber: json['propertyNumber'] as String? ?? '',
//         unitsCount: json['unitsCount'] as int? ?? 0,
//         parkingSpots: json['parkingSpots'] as int? ?? 0,
//         tenants: json['tenants'] as String? ?? '',
//         inProgressPhasesCount: json['inProgressPhasesCount'] as int? ?? 0,
//         delayedPhasesCount: json['delayedPhasesCount'] as int? ?? 0,
//         phases: (json['phases'] as List<dynamic>?)
//                 ?.map(
//                   (e) =>
//                       ProjectPhaseModel.fromJson(e as Map<String, dynamic>),
//                 )
//                 .toList() ??
//             const [],
//         timeline: (json['timeline'] as List<dynamic>?)
//                 ?.map(
//                   (e) =>
//                       ProjectTimelineModel.fromJson(e as Map<String, dynamic>),
//                 )
//                 .toList() ??
//             const [],
//         smartNotes:
//             (json['smartNotes'] as List<dynamic>?)?.cast<String>() ??
//             const [],
//         pdfReportUrl: json['pdfReportUrl'] as String?,
//         attachmentUrl: json['attachmentUrl'] as String?,
//       );

//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'name': name,
//         'location': location,
//         'status': status,
//         'completionPercentage': completionPercentage,
//         'lastUpdate': lastUpdate,
//         'imageUrl': imageUrl,
//         'type': type,
//         'budget': budget,
//         'startDate': startDate,
//         'expectedEndDate': expectedEndDate,
//         'mainPhases': mainPhases,
//         'roomsCount': roomsCount,
//         'bathroomsCount': bathroomsCount,
//         'area': area,
//         'balconyCount': balconyCount,
//         'floorNumber': floorNumber,
//         'propertyNumber': propertyNumber,
//         'unitsCount': unitsCount,
//         'parkingSpots': parkingSpots,
//         'tenants': tenants,
//         'inProgressPhasesCount': inProgressPhasesCount,
//         'delayedPhasesCount': delayedPhasesCount,
//         'phases': phases.map((e) => e.toJson()).toList(),
//         'timeline': timeline.map((e) => e.toJson()).toList(),
//         'smartNotes': smartNotes,
//         'pdfReportUrl': pdfReportUrl,
//         'attachmentUrl': attachmentUrl,
//       };

//   @override
//   List<Object?> get props => [
//         id,
//         name,
//         location,
//         status,
//         completionPercentage,
//         lastUpdate,
//         imageUrl,
//         type,
//         budget,
//         startDate,
//         expectedEndDate,
//         mainPhases,
//         roomsCount,
//         bathroomsCount,
//         area,
//         balconyCount,
//         floorNumber,
//         propertyNumber,
//         unitsCount,
//         parkingSpots,
//         tenants,
//         inProgressPhasesCount,
//         delayedPhasesCount,
//         phases,
//         timeline,
//         smartNotes,
//         pdfReportUrl,
//         attachmentUrl,
//       ];
// }
