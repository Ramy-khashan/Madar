part of '../add_property_bloc.dart';

mixin AddPropertyMediaMixin on AddPropertyControllersMixin {
  void _onAddImage(AddImageEvent event, Emitter<AddPropertyState> emit) {
    final updated = List<String>.from(state.model.imagePaths)..add(event.path);
    emit(state.copyWith(model: state.model.copyWith(imagePaths: updated)));
  }

  void _onAddImages(AddImagesEvent event, Emitter<AddPropertyState> emit) {
    if (event.paths.isEmpty) return;
    final updated = List<String>.from(state.model.imagePaths)
      ..addAll(event.paths);
    emit(state.copyWith(model: state.model.copyWith(imagePaths: updated)));
  }

  void _onRemoveImage(RemoveImageEvent event, Emitter<AddPropertyState> emit) {
    final updated = List<String>.from(state.model.imagePaths)
      ..removeAt(event.index);
    emit(state.copyWith(model: state.model.copyWith(imagePaths: updated)));
  }

  void _onToggleAiEnhancement(
    ToggleAiEnhancementEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    emit(
      state.copyWith(
        model: state.model.copyWith(aiEnhancement: !state.model.aiEnhancement),
      ),
    );
  }

  void _onSetVideoPath(
    SetVideoPathEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    emit(
      state.copyWith(
        model: state.model.copyWith(videoPath: event.path, hasVideo: true),
      ),
    );
  }

  void _onClearVideo(ClearVideoEvent event, Emitter<AddPropertyState> emit) {
    emit(
      state.copyWith(
        model: state.model.copyWith(hasVideo: false, clearVideoPath: true),
      ),
    );
  }

  void _onSetVirtualTourPath(
    SetVirtualTourPathEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    emit(
      state.copyWith(
        model: state.model.copyWith(
          virtualTourPath: event.path,
          has360Tour: true,
        ),
      ),
    );
  }

  void _onClearVirtualTour(
    ClearVirtualTourEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    emit(
      state.copyWith(
        model: state.model.copyWith(
          has360Tour: false,
          clearVirtualTourPath: true,
        ),
      ),
    );
  }

  void _onSetDeedDocument(
    SetDeedDocumentEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    final errors = Map<String, String>.from(state.fieldErrors)
      ..remove(AddPropertyField.ownershipDocument);
    emit(
      state.copyWith(
        model: state.model.copyWith(ownershipDocumentPath: event.path),
        fieldErrors: errors,
      ),
    );
  }

  void _onClearDeedDocument(
    ClearDeedDocumentEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    emit(
      state.copyWith(
        model: state.model.copyWith(clearOwnershipDocumentPath: true),
      ),
    );
  }

  Future<void> _onPreviewEvaluation(
    PreviewEvaluationEvent event,
    Emitter<AddPropertyState> emit,
  ) async {
    try {
      final model = modelWithControllerValues();
      emit(
        state.copyWith(
          model: model,
          isPreviewLoading: true,
          hasMarketData: false,
        ),
      );

      final result = await CreatePropertyApis.previewEvaluation(model);

      result.fold(
        (_) => emit(
          state.copyWith(
            isPreviewLoading: false,
            hasMarketData: false,
            aiDescription: '',
          ),
        ),
        (preview) => emit(
          state.copyWith(
            isPreviewLoading: false,
            hasMarketData: preview.hasMarketData,
            suggestedMin: preview.suggestedMin,
            suggestedMax: preview.suggestedMax,
            aiDescription: preview.aiDescription,
          ),
        ),
      );
    } catch (e) {
       emit(
        state.copyWith(
          isPreviewLoading: false,
          hasMarketData: false,
          aiDescription: '',
        ),
      );
    }
  }

  void _onApplyAiDescription(
    ApplyAiDescriptionEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    final text = state.aiDescription?.trim() ?? '';
    if (text.contains('404') || text.contains('error')) {
      return;
    }
    if (text.isEmpty) return;
    descriptionController.text = text;
    emit(state.copyWith(model: state.model.copyWith(description: text)));
  }
}
