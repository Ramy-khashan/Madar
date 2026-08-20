import 'package:equatable/equatable.dart';

import 'manager_request_model.dart';
import 'stage_request_model.dart';

class ProjectRequestBase extends Equatable {
  const ProjectRequestBase({
    required this.projectName,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.price,
    required this.type,
    required this.stages,
    required this.manager,
  });

  final String projectName;
  final String location;
  final String startDate;
  final String endDate;
  final String price;
  final String type; // "RESIDENTIAL" or "COMMERCIAL"
  final List<StageRequestModel> stages;
  final ManagerRequestModel manager;

  @override
  List<Object?> get props => [
    projectName,
    location,
    startDate,
    endDate,
    price,
    type,
    stages,
    manager,
  ];
}
