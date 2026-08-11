part of 'phase_details_bloc.dart';

class PhaseDetailsState extends Equatable {
  const PhaseDetailsState({
    required this.phase,
    required this.timeline,
     this.uploadedImagePaths = const [],
    this.selectedSubPhases = const [],
    this.approveErrorMessage = '',
    this.loadingStatus=RequestStatus.init,
  });

  final ProjectStages phase;
   final List<Timeline> timeline;
  final List<String> uploadedImagePaths;
  final String approveErrorMessage;
  final List<String>selectedSubPhases;
  final RequestStatus loadingStatus;

  PhaseDetailsState copyWith({
    ProjectStages? phase,
    bool? isApproving,
    List<Timeline>? timeline,
    List<String>? uploadedImagePaths,
    String? approveErrorMessage,
    List<String>? selectedSubPhases,
    RequestStatus? loadingStatus,
  }) {
    return PhaseDetailsState(
      timeline: timeline ?? this.timeline,
      phase: phase ?? this.phase,
      loadingStatus: loadingStatus ?? this.loadingStatus,
       uploadedImagePaths: uploadedImagePaths ?? this.uploadedImagePaths,
      approveErrorMessage: approveErrorMessage ?? this.approveErrorMessage,
      selectedSubPhases: selectedSubPhases ?? this.selectedSubPhases,
    );
  }

  @override
  List<Object?> get props => [selectedSubPhases, phase,  timeline, uploadedImagePaths, approveErrorMessage, loadingStatus];
}
