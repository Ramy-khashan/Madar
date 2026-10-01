part of 'business_project_details_bloc.dart';

sealed class BusinessProjectDetailsEvent extends Equatable {
  const BusinessProjectDetailsEvent();

  @override
  List<Object?> get props => [];
}

final class BusinessProjectDetailsLoad extends BusinessProjectDetailsEvent {
  const BusinessProjectDetailsLoad({required this.projectId});

  final String projectId;

  @override
  List<Object?> get props => [projectId];
}

final class BusinessProjectDetailsExportPdf
    extends BusinessProjectDetailsEvent {
  const BusinessProjectDetailsExportPdf();
}
