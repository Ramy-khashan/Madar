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
    emit(state.copyWith(loadStatus: RequestStatus.loading));
     emit(
      state.copyWith(
        loadStatus: RequestStatus.success,
        requests: const [
          RatePropertyRequestModel(
            id: '1',
            title: 'فيلا الرياض - حي النرجس',
            requestNumber: 'REQ-002',
            type: 'certified',
            requestDate: '١٦ رجب ١٤٤٧ هـ',
            status: 'ready',
            estimatedValue: 2850000,
          ),
          RatePropertyRequestModel(
            id: '2',
            title: 'شقة جدة - حي الزهراء',
            requestNumber: 'REQ-002',
            type: 'estimated',
            requestDate: '١٦ رجب ١٤٤٧ هـ',
            status: 'underReview',
          ),
          RatePropertyRequestModel(
            id: '3',
            title: 'شقة جدة - حي الزهراء',
            requestNumber: 'REQ-002',
            type: 'estimated',
            requestDate: '١٦ رجب ١٤٤٧ هـ',
            status: 'newRequest',
          ),
        ],
      ),
    );
  }

  void _onTabChanged(
    RatePropertyTabChanged event,
    Emitter<RatePropertyState> emit,
  ) {
    emit(state.copyWith(currentTab: event.index));
  }
}
