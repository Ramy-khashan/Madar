part of 'business_project_details_bloc.dart';

class BusinessProjectDetailsState extends Equatable {
  const BusinessProjectDetailsState({
    this.status = RequestStatus.init,
    this.project,
   });

  final RequestStatus status;
  final RealEstateProjectModel? project;

  
  BusinessProjectDetailsState copyWith({
    RequestStatus? status,
    RealEstateProjectModel? project,
   }) => BusinessProjectDetailsState(
        status: status ?? this.status,
        project: project ?? this.project,
       );

  @override
  List<Object?> get props => [status, project];
}
