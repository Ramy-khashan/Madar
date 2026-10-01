import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/constants/app_enums.dart';
import '../model/rate_property_model.dart';

part 'rate_property_event.dart';
part 'rate_property_state.dart';

class RatePropertyBloc extends Bloc<RatePropertyEvent, RatePropertyState> {
  RatePropertyBloc() : super(const RatePropertyState()) {
    on<RatePropertyLoad>(_onLoad);
    on<RatePropertyTabChanged>(_onTabChanged);
  }

  static RatePropertyBloc get(BuildContext context) =>
      BlocProvider.of<RatePropertyBloc>(context);

  Future<void> _onLoad(
    RatePropertyLoad event,
    Emitter<RatePropertyState> emit,
  ) async {
    emit(state.copyWith(loadStatus: RequestStatus.success, requests: []));
  }

  void _onTabChanged(
    RatePropertyTabChanged event,
    Emitter<RatePropertyState> emit,
  ) {
    emit(state.copyWith(currentTab: event.index));
  }
}
