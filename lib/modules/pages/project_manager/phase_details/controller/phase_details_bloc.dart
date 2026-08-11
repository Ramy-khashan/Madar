import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/connection/concept/end_points.dart';
import '../../../../../core/connection/interfaces/api_consumer.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/common_fun.dart';
import '../../../../../core/utils/functions/service_locator.dart';
import '../../../business/real_estate_development/business_project_details/model/real_state_project_model.dart';

part 'phase_details_event.dart';
part 'phase_details_state.dart';

class PhaseDetailsBloc extends Bloc<PhaseDetailsEvent, PhaseDetailsState> {
  final String projectId;

  PhaseDetailsBloc({
    required ProjectStages phase,
    required List<Timeline> timeline,
    this.projectId = '',
  }) : super(PhaseDetailsState(phase: phase, timeline: timeline)) {
    on<ToggleTaskEvent>(_onToggleTask);
    on<AddPhaseImageEvent>(_onAddImage);
    on<RemovePhaseImageEvent>(_onRemoveImage);
    on<UpdateNoteEvent>(_onUpdateNote);
    on<UpdateCustomTaskEvent>(_onUpdateCustomTask);
    on<ApprovePhaseEvent>(_onApprovePhase);
    on<PickImagesEvent>(_onPickImages);
  }

  final noteController = TextEditingController();
  final customTaskController = TextEditingController();

  static PhaseDetailsBloc get(BuildContext context) =>
      context.read<PhaseDetailsBloc>();

  void _onToggleTask(ToggleTaskEvent event, Emitter<PhaseDetailsState> emit) {
    // Toggle task selection - not changing stage if done
    final List<String> selectedSubPhases = List<String>.from(
      state.selectedSubPhases,
    );
    if (selectedSubPhases.contains(event.taskId)) {
      selectedSubPhases.remove(event.taskId);
    } else {
      selectedSubPhases.add(event.taskId);
    }
    emit(state.copyWith(selectedSubPhases: selectedSubPhases));
  }

  void _onAddImage(AddPhaseImageEvent event, Emitter<PhaseDetailsState> emit) {
    // Legacy method - use PickImagesEvent instead
  }

  void _onRemoveImage(
    RemovePhaseImageEvent event,
    Emitter<PhaseDetailsState> emit,
  ) {
    final updated = List<String>.from(state.uploadedImagePaths);
    if (event.index < updated.length) {
      updated.removeAt(event.index);
      emit(state.copyWith(uploadedImagePaths: updated));
    }
  }

  void _onUpdateNote(UpdateNoteEvent event, Emitter<PhaseDetailsState> emit) {
    // Note is stored in noteController
  }

  void _onUpdateCustomTask(
    UpdateCustomTaskEvent event,
    Emitter<PhaseDetailsState> emit,
  ) {
    // Custom task is stored in customTaskController
  }

  void _onPickImages(PickImagesEvent event, Emitter<PhaseDetailsState> emit) {
    final updated = List<String>.from(state.uploadedImagePaths)
      ..addAll(event.imagePaths);
    emit(state.copyWith(uploadedImagePaths: updated));
  }

  Future<void> _onApprovePhase(
    ApprovePhaseEvent event,
    Emitter<PhaseDetailsState> emit,
  ) async {
    emit(
      state.copyWith(
        loadingStatus: RequestStatus.loading,
        approveErrorMessage: '',
      ),
    );

    try {
      // Build FormData with the uploaded images and phase details
      final formData = FormData.fromMap({
        'projectStageId': state.phase.id,
        'content': noteController.text,
        'progress': (state.phase.subStages?.length ?? 0) > 0
            ? (state.selectedSubPhases.length / state.phase.subStages!.length) *
                  100
            : 100,
        'subStageIds': state.selectedSubPhases,
        // 'subStageIds': jsonEncode([
        //   {
        //     // 'stageId': state.phase.id,
        //     'subStageIds':
        //     'customSubStages': (customTaskController.text.isNotEmpty)
        //         ? [customTaskController.text]
        //         : [],
        //   },
        // ]),
      });

      // Add files from uploaded images
      for (final filePath in state.uploadedImagePaths) {
        formData.files.add(
          MapEntry(
            'attachments',
            await MultipartFile.fromFile(
              filePath,
              filename: filePath.split('/').last,
            ),
          ),
        );
      }

      // Make API call
      final response = await sl.get<ApiConsumer>().postFormData(
        EndPoints.projectUpdates(event.projectId),
        body: formData,
      );

      response.fold(
        (error) {
          AppToast(error, isError: true);

          emit(
            state.copyWith(
              loadingStatus: RequestStatus.failed,
              approveErrorMessage: error,
            ),
          );
        },
        (success) {
          if (success.response['success']) {
            final updatedPhase = state.phase;
            updatedPhase.status = 'completed';
            updatedPhase.progress = 100;
            emit(
              state.copyWith(
                loadingStatus: RequestStatus.success,
                phase: updatedPhase,
              ),
            );
          } else {
            AppToast(AppStrings.somethingWentWrong, isError: true);

            emit(
              state.copyWith(
                loadingStatus: RequestStatus.failed,
                approveErrorMessage: AppStrings.somethingWentWrong,
              ),
            );
          }
        },
      );
    } catch (e) {
      AppToast(AppStrings.somethingWentWrong, isError: true);

      emit(
        state.copyWith(
          loadingStatus: RequestStatus.failed,
          approveErrorMessage: AppStrings.somethingWentWrong,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    noteController.dispose();
    customTaskController.dispose();
    return super.close();
  }
}
