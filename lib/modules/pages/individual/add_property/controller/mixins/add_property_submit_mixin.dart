part of '../add_property_bloc.dart';

mixin AddPropertySubmitMixin on AddPropertyControllersMixin {
  void _onToggleRentInstallment(
    ToggleRentInstallmentEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    emit(
      state.copyWith(
        model: state.model.copyWith(
          hasRentInstallment: !state.model.hasRentInstallment,
        ),
      ),
    );
  }

  void _onToggleInsurance(
    ToggleInsuranceEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    emit(
      state.copyWith(
        model: state.model.copyWith(hasInsurance: !state.model.hasInsurance),
      ),
    );
  }

  void _onShowPortfolioSheet(
    ShowPortfolioSheetEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    final model = modelWithControllerValues();
    final errors = _errorsForSubmit(model);
    if (errors.isNotEmpty) {
      final firstKey = errors.keys.first;
      emit(
        state.copyWith(
          model: model,
          fieldErrors: errors,
          errorMessage: errors.values.first,
          step: stepForField(firstKey),
          showPortfolioSheet: false,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        model: model.copyWith(clearPropertyParent: true),
        fieldErrors: const {},
        errorMessage: null,
        showPortfolioSheet: true,
        hasPortfolioMode: true,
        isNewFolder: true,
      ),
    );
  }

  void _onHidePortfolioSheet(
    HidePortfolioSheetEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    emit(state.copyWith(showPortfolioSheet: false));
  }

  Map<String, String> _errorsForSubmit(AddPropertyModel model) {
    return {
      ...AddPropertyValidator.validateType(model),
      if (model.operationType == 'rent')
        ...AddPropertyValidator.validatePeriod(model),
      ...AddPropertyValidator.validateLocation(model),
      ...AddPropertyValidator.validateImages(model),
      ...AddPropertyValidator.validateDetails(model),
      ...AddPropertyValidator.validateReview(model),
    };
  }

  Future<void> _onConfirmSave(
    ConfirmSaveEvent event,
    Emitter<AddPropertyState> emit,
  ) async {
    final model = modelWithControllerValues().copyWith(clearPropertyParent: true);
    final errors = _errorsForSubmit(model);

    if (errors.isNotEmpty) {
      final firstKey = errors.keys.first;
      emit(
        state.copyWith(
          model: model,
          fieldErrors: errors,
          errorMessage: errors.values.first,
          step: stepForField(firstKey),
          showPortfolioSheet: false,
          isLoading: false,
          openChooseBrokerOnSuccess: false,
        ),
      );
      return;
    }

    final request = model.toCreateRequest(
      brokerId: event.brokerId,
      adLicenseNumber: event.adLicenseNumber,
    );

    if (request == null) {
      emit(
        state.copyWith(
          model: model,
          showPortfolioSheet: false,
          submitStatus: SubmitStatus.failure,
          errorMessage: AppStrings.somethingWentWrong,
          openChooseBrokerOnSuccess: false,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        model: model,
        showPortfolioSheet: false,
        submitStatus: SubmitStatus.loading,
        isLoading: true,
        fieldErrors: const {},
        errorMessage: null,
        openChooseBrokerOnSuccess: event.openChooseBrokerOnSuccess,
      ),
    );

    final result = await CreatePropertyApis.createProperty(request);

    result.fold(
      (failure) => emit(
        state.copyWith(
          isLoading: false,
          submitStatus: SubmitStatus.failure,
          errorMessage: failure,
          openChooseBrokerOnSuccess: false,
        ),
      ),
      (data) => emit(
        state.copyWith(
          isLoading: false,
          submitStatus: SubmitStatus.success,
          createdPropertyId: _extractCreatedPropertyId(data),
          openChooseBrokerOnSuccess: event.openChooseBrokerOnSuccess,
        ),
      ),
    );
  }

  void _onSendToBroker(
    SendToBrokerEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    add(ConfirmSaveEvent(brokerId: event.brokerId));
  }

  String? _extractCreatedPropertyId(dynamic data) {
    if (data is! Map) return null;
    final id =
        data['property_id'] ?? data['propertyId'] ?? data['id'] ?? data['_id'];
    if (id != null) return id.toString();
    final nested = data['property'];
    if (nested is Map) {
      final nestedId =
          nested['property_id'] ?? nested['propertyId'] ?? nested['id'];
      if (nestedId != null) return nestedId.toString();
    }
    return null;
  }
}
