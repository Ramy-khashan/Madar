part of 'business_project_details_bloc.dart';

class BusinessProjectDetailsState extends Equatable {
  const BusinessProjectDetailsState({
    this.status = RequestStatus.init,
    this.exportStatus = RequestStatus.init,
    this.errorMessage = '',
    this.projectId = '',
    this.project,
  });

  final RequestStatus status;
  final RequestStatus exportStatus;
  final RealStateProjectModel? project;
  final String errorMessage;
  final String projectId;

  BusinessProjectDetailsState copyWith({
    RequestStatus? status,
    RequestStatus? exportStatus,
    String? errorMessage,
    RealStateProjectModel? project,
    String? projectId,
  }) => BusinessProjectDetailsState(
    status: status ?? this.status,
    exportStatus: exportStatus ?? this.exportStatus,
    project: project ?? this.project,
    errorMessage: errorMessage ?? this.errorMessage,
    projectId: projectId ?? this.projectId,
  );

  @override
  List<Object?> get props => [
    status,
    exportStatus,
    project,
    errorMessage,
    projectId,
  ];
}
