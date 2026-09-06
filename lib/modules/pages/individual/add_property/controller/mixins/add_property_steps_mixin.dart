part of '../add_property_bloc.dart';

mixin AddPropertyStepsMixin on AddPropertyControllersMixin {
  void _onNext(NextStepEvent event, Emitter<AddPropertyState> emit) {
    final model = modelWithControllerValues();
    final errors = _errorsForStep(state.step, model);
    if (errors.isNotEmpty) {
      emit(
        state.copyWith(
          model: model,
          fieldErrors: errors,
          errorMessage: errors.values.first,
        ),
      );
      return;
    }
    final next = _nextStep(state.step, model.operationType);
    if (next != null) {
      emit(
        state.copyWith(
          model: model,
          step: next,
          fieldErrors: const {},
          errorMessage: null,
        ),
      );
      if (next == AddPropertyStep.review) {
        add(const PreviewEvaluationEvent());
      }
    }
  }

  Map<String, String> _errorsForStep(
    AddPropertyStep step,
    AddPropertyModel model,
  ) {
    switch (step) {
      case AddPropertyStep.type:
        return AddPropertyValidator.validateType(model);
      case AddPropertyStep.period:
        return AddPropertyValidator.validatePeriod(model);
      case AddPropertyStep.location:
        return AddPropertyValidator.validateLocation(model);
      case AddPropertyStep.images:
        return AddPropertyValidator.validateImages(model);
      case AddPropertyStep.details:
        return AddPropertyValidator.validateDetails(model);
      case AddPropertyStep.review:
        return AddPropertyValidator.validateReview(model);
    }
  }

  void _onPrevious(PreviousStepEvent event, Emitter<AddPropertyState> emit) {
    final prev = _previousStep(state.step, state.model.operationType);
    if (prev != null) {
      emit(
        state.copyWith(step: prev, fieldErrors: const {}, errorMessage: null),
      );
    }
  }

  AddPropertyStep? _nextStep(AddPropertyStep current, String operationType) {
    switch (current) {
      case AddPropertyStep.type:
        return operationType == 'rent'
            ? AddPropertyStep.period
            : AddPropertyStep.location;
      case AddPropertyStep.period:
        return AddPropertyStep.location;
      case AddPropertyStep.location:
        return AddPropertyStep.images;
      case AddPropertyStep.images:
        return AddPropertyStep.details;
      case AddPropertyStep.details:
        return AddPropertyStep.review;
      case AddPropertyStep.review:
        return null;
    }
  }

  AddPropertyStep? _previousStep(
    AddPropertyStep current,
    String operationType,
  ) {
    switch (current) {
      case AddPropertyStep.type:
        return null;
      case AddPropertyStep.period:
        return AddPropertyStep.type;
      case AddPropertyStep.location:
        return operationType == 'rent'
            ? AddPropertyStep.period
            : AddPropertyStep.type;
      case AddPropertyStep.images:
        return AddPropertyStep.location;
      case AddPropertyStep.details:
        return AddPropertyStep.images;
      case AddPropertyStep.review:
        return AddPropertyStep.details;
    }
  }

  // ── Step 1 handlers ──────────────────────────────────────────────────────

  void _onSelectOperationType(
    SelectOperationTypeEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    emit(
      state.copyWith(model: state.model.copyWith(operationType: event.type)),
    );
  }

  void _onSelectPropertyType(
    SelectPropertyTypeEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    emit(
      state.copyWith(
        model: state.model.copyWith(propertyType: event.typeId),
      ),
    );
  }

  // ── Step 2 handlers ──────────────────────────────────────────────────────

  void _onSelectRentalPeriod(
    SelectRentalPeriodEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    emit(
      state.copyWith(model: state.model.copyWith(rentalPeriod: event.period)),
    );
  }

  // ── Step 3 handlers ──────────────────────────────────────────────────────

  void _onUpdateLocation(
    UpdateLocationEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    emit(state.copyWith(model: state.model.copyWith(location: event.location)));
  }

  void _onUpdateCoordinates(
    UpdateCoordinatesEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    emit(
      state.copyWith(
        model: state.model.copyWith(
          latitude: event.latitude,
          longitude: event.longitude,
          city: event.city,
          district: event.district,
        ),
      ),
    );
  }

  Future<void> _onMapLocationSelected(
    MapLocationSelectedEvent event,
    Emitter<AddPropertyState> emit,
  ) async {
    emit(
      state.copyWith(
        model: state.model.copyWith(
          location:
              '${event.latitude.toStringAsFixed(5)}, ${event.longitude.toStringAsFixed(5)}',
          latitude: event.latitude,
          longitude: event.longitude,
        ),
      ),
    );
    try {
      final response = await sl.get<Dio>().get<Map<String, dynamic>>(
        'https://nominatim.openstreetmap.org/reverse',
        queryParameters: {
          'format': 'json',
          'lat': event.latitude,
          'lon': event.longitude,
          'addressdetails': 1,
          'accept-language': 'ar',
        },
        options: Options(headers: {'User-Agent': 'MadarApp/1.0'}),
      );
      if (isClosed) return;
      final addr = response.data?['address'] as Map<String, dynamic>?;
      if (addr == null) return;
      final neighbourhood = (addr['neighbourhood'] ?? addr['suburb'] ?? '')
          .toString()
          .trim();
      final city = (addr['city'] ?? addr['town'] ?? addr['village'] ?? '')
          .toString()
          .trim();
      final road = (addr['road'] ?? addr['street'] ?? '').toString().trim();
      final house = (addr['house_number'] ?? '').toString().trim();
      final line1 = [neighbourhood, city].where((s) => s.isNotEmpty).join('، ');
      final line2 = [road, house].where((s) => s.isNotEmpty).join(' ');
      final label = [line1, line2].where((s) => s.isNotEmpty).join('\n');
      buildingNumberController.text = house;
      streetController.text = road;
      emit(
        state.copyWith(
          model: state.model.copyWith(
            location: label.isEmpty
                ? state.model.location
                : label,
            latitude: event.latitude,
            longitude: event.longitude,
            city: city,
            district: neighbourhood,
          ),
        ),
      );
    } catch (_) {}
  }

  void _onSelectDeedType(
    SelectDeedTypeEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    final errors = Map<String, String>.from(state.fieldErrors)
      ..remove(AddPropertyField.deedType)
      ..remove(AddPropertyField.deedNumber)
      ..remove(AddPropertyField.deedDate)
      ..remove(AddPropertyField.customTypeName)
      ..remove(AddPropertyField.ownershipDocument);
    emit(
      state.copyWith(
        model: state.model.copyWith(deedType: event.deedType),
        fieldErrors: errors,
      ),
    );
  }

  void _onSelectDateType(
    SelectDateTypeEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    final formatted = deedPickedAt == null
        ? state.model.date
        : HijriDate.format(deedPickedAt!, hijri: event.dateType == 'hijri');
    if (deedPickedAt != null) {
      dateController.text = formatted;
    }
    emit(
      state.copyWith(
        model: state.model.copyWith(dateType: event.dateType, date: formatted),
      ),
    );
  }

  void _onDeedDatePicked(
    DeedDatePickedEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    deedPickedAt = event.date;
    final formatted = HijriDate.format(
      event.date,
      hijri: state.model.dateType == 'hijri',
    );
    dateController.text = formatted;
    final errors = Map<String, String>.from(state.fieldErrors)
      ..remove(AddPropertyField.deedDate);
    emit(
      state.copyWith(
        model: state.model.copyWith(date: formatted),
        fieldErrors: errors,
      ),
    );
  }
}
