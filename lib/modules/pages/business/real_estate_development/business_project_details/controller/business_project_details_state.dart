part of 'business_project_details_bloc.dart';

class BusinessProjectDetailsState extends Equatable {
  const BusinessProjectDetailsState({
    this.status = RequestStatus.init,
    this.project,
    this.role = 'owner',
  });

  final RequestStatus status;
  final RealEstateProjectModel? project;

  /// 'owner' | 'manager'
  final String role;

  BusinessProjectDetailsState copyWith({
    RequestStatus? status,
    RealEstateProjectModel? project,
    String? role,
  }) => BusinessProjectDetailsState(
        status: status ?? this.status,
        project: project ?? this.project,
        role: role ?? this.role,
      );

  @override
  List<Object?> get props => [status, project, role];
}
