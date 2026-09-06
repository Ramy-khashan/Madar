part of '../add_property_bloc.dart';

mixin AddPropertyDetailsMixin on AddPropertyControllersMixin {
  void _onSelectFacade(
    SelectFacadeEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    emit(state.copyWith(model: state.model.copyWith(facade: event.facade)));
  }

  void _onIncrementStreetCount(
    IncrementStreetCountEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    emit(
      state.copyWith(
        model: state.model.copyWith(streetCount: state.model.streetCount + 1),
      ),
    );
  }

  void _onDecrementStreetCount(
    DecrementStreetCountEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    if (state.model.streetCount <= 1) return;
    emit(
      state.copyWith(
        model: state.model.copyWith(streetCount: state.model.streetCount - 1),
      ),
    );
  }

  void _onSelectStreetWidth(
    SelectStreetWidthEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    emit(state.copyWith(model: state.model.copyWith(streetWidth: event.width)));
  }

  void _onSelectPropertyAge(
    SelectPropertyAgeEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    emit(state.copyWith(model: state.model.copyWith(propertyAge: event.age)));
  }

  void _onIncrementCounter(
    IncrementCounterEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    final m = state.model;
    emit(
      state.copyWith(
        model: switch (event.field) {
          'beds' => m.copyWith(beds: m.beds + 1),
          'baths' => m.copyWith(baths: m.baths + 1),
          'lounges' => m.copyWith(lounges: m.lounges + 1),
          'majlis' => m.copyWith(majlis: m.majlis + 1),
          _ => m,
        },
      ),
    );
  }

  void _onDecrementCounter(
    DecrementCounterEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    final m = state.model;
    emit(
      state.copyWith(
        model: switch (event.field) {
          'beds' => m.beds > 0 ? m.copyWith(beds: m.beds - 1) : m,
          'baths' => m.baths > 0 ? m.copyWith(baths: m.baths - 1) : m,
          'lounges' => m.lounges > 0 ? m.copyWith(lounges: m.lounges - 1) : m,
          'majlis' => m.majlis > 0 ? m.copyWith(majlis: m.majlis - 1) : m,
          _ => m,
        },
      ),
    );
  }

  void _onSelectDropdown(
    SelectDropdownEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    final m = state.model;
    emit(
      state.copyWith(
        model: switch (event.field) {
          'totalFloors' => m.copyWith(totalFloors: event.value),
          'apartmentsPerFloor' => m.copyWith(apartmentsPerFloor: event.value),
          'floorLevel' => m.copyWith(floorLevel: event.value),
          'furnishing' => m.copyWith(furnishing: event.value),
          'condition' => m.copyWith(condition: event.value),
          _ => m,
        },
      ),
    );
  }

  /// Per-type detail fields all funnel through one map, so these handlers stay
  /// type-agnostic.
  void _emitDetail(Emitter<AddPropertyState> emit, String key, dynamic value) {
    final updated = Map<String, dynamic>.from(state.model.typeDetails);
    if (value == null) {
      updated.remove(key);
    } else {
      updated[key] = value;
    }
    emit(state.copyWith(model: state.model.copyWith(typeDetails: updated)));
  }

  void _onSetDetailField(
    SetDetailFieldEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    _emitDetail(emit, event.key, event.value);
  }

  void _onToggleDetailListItem(
    ToggleDetailListItemEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    final current = List<String>.from(state.model.detailList(event.key));
    if (current.contains(event.value)) {
      current.remove(event.value);
    } else {
      current.add(event.value);
    }
    _emitDetail(emit, event.key, current);
  }

  void _onIncrementDetailCounter(
    IncrementDetailCounterEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    _emitDetail(emit, event.key, state.model.detailCount(event.key) + 1);
  }

  void _onDecrementDetailCounter(
    DecrementDetailCounterEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    final current = state.model.detailCount(event.key);
    if (current <= 0) return;
    _emitDetail(emit, event.key, current - 1);
  }

  void _onToggleDetailFlag(
    ToggleDetailFlagEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    _emitDetail(emit, event.key, !state.model.detailFlag(event.key));
  }

  void _onToggleAmenity(
    ToggleAmenityEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    final updated = Set<String>.from(state.model.amenities);
    if (updated.contains(event.amenityId)) {
      updated.remove(event.amenityId);
    } else {
      updated.add(event.amenityId);
    }
    emit(state.copyWith(model: state.model.copyWith(amenities: updated)));
  }
}
