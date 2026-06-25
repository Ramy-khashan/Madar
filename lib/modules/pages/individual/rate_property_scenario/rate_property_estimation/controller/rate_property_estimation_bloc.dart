import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/constants/app_enums.dart';

part 'rate_property_estimation_event.dart';
part 'rate_property_estimation_state.dart';

class RatePropertyEstimationBloc
    extends Bloc<RatePropertyEstimationEvent, RatePropertyEstimationState> {
  RatePropertyEstimationBloc() : super(const RatePropertyEstimationState()) {
    on<RatePropertyEstimationTypeSelected>(_onTypeSelected);
    on<RatePropertyEstimationFieldChanged>(_onFieldChanged);
    on<RatePropertyEstimationCalculate>(_onCalculate);
    on<RatePropertyEstimationSave>(_onSave);
  }
  final TextEditingController locationController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  static RatePropertyEstimationBloc get(BuildContext context) =>
      BlocProvider.of<RatePropertyEstimationBloc>(context);

  void _onTypeSelected(
    RatePropertyEstimationTypeSelected event,
    Emitter<RatePropertyEstimationState> emit,
  ) {
    emit(state.copyWith(selectedType: event.typeId));
  }

  void _onFieldChanged(
    RatePropertyEstimationFieldChanged event,
    Emitter<RatePropertyEstimationState> emit,
  ) {
    emit(
      state.copyWith(
        location: event.location ?? state.location,
        area: event.area ?? state.area,
        propertyAge: event.propertyAge ?? state.propertyAge,
        finishingLevel: event.finishingLevel ?? state.finishingLevel,
        purpose: event.purpose ?? state.purpose,
      ),
    );
  }

  Future<void> _onCalculate(
    RatePropertyEstimationCalculate event,
    Emitter<RatePropertyEstimationState> emit,
  ) async {
    emit(state.copyWith(analyzeStatus: RequestStatus.loading));

    await Future.delayed(const Duration(seconds: 3));
    emit(
      state.copyWith(
        analyzeStatus: RequestStatus.success,
        estimatedValue: 2084295,
        minValue: 2325865,
        maxValue: 2842724,
        marketComparison: 'above',
      ),
    );
  }

  Future<void> _onSave(
    RatePropertyEstimationSave event,
    Emitter<RatePropertyEstimationState> emit,
  ) async {
    emit(state.copyWith(saveStatus: RequestStatus.loading));
    emit(state.copyWith(saveStatus: RequestStatus.success));
  }
}
