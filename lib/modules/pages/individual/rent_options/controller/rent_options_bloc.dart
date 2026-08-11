import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../model/rent_options_model.dart';

part 'rent_options_event.dart';
part 'rent_options_state.dart';

class RentOptionsBloc extends Bloc<RentOptionsEvent, RentOptionsState> {
  RentOptionsBloc() : super(const RentOptionsState()) {
    on<RentOptionsLoad>(_onLoad);
    on<RentOptionsPlanSelected>(_onPlanSelected);
    on<RentOptionsProviderSelected>(_onProviderSelected);
    on<RentOptionsConfirm>(_onConfirm);
  }

  static RentOptionsBloc get(BuildContext context) =>
      BlocProvider.of<RentOptionsBloc>(context);

  Future<void> _onLoad(
    RentOptionsLoad event,
    Emitter<RentOptionsState> emit,
  ) async {
    emit(state.copyWith(getDetailsStatus: RequestStatus.loading));
     emit(
      state.copyWith(
        getDetailsStatus: RequestStatus.success,
        propertyTitle: 'شقة فاخرة في الملقا',
        propertyLocation: 'الرياض - حي الملقا',
        propertyPrice: 850000,
        propertyType: 'شقة سكنية',
        plans: const [
          InstallmentPlanModel(id: 'p4', monthsCount: 4, monthlyAmount: 850000, fees: 500),
          InstallmentPlanModel(id: 'p6', monthsCount: 6, monthlyAmount: 850000, fees: 500),
          InstallmentPlanModel(id: 'p12', monthsCount: 12, monthlyAmount: 850000, fees: 500),
        ],
        providers: [
          InstallmentProviderModel(id: 'tamara', name: AppStrings.providerTamara, rating: 4.8, processingHours: 24),
          InstallmentProviderModel(id: 'tabby', name: AppStrings.providerTabby, rating: 4.8, processingHours: 24),
          InstallmentProviderModel(id: 'postpay', name: 'بوست باي', rating: 4.8, processingHours: 24),
        ],
      ),
    );
  }

  void _onPlanSelected(
    RentOptionsPlanSelected event,
    Emitter<RentOptionsState> emit,
  ) {
    emit(state.copyWith(selectedPlanId: event.planId));
  }

  void _onProviderSelected(
    RentOptionsProviderSelected event,
    Emitter<RentOptionsState> emit,
  ) {
    emit(state.copyWith(selectedProviderId: event.providerId));
  }

  Future<void> _onConfirm(
    RentOptionsConfirm event,
    Emitter<RentOptionsState> emit,
  ) async {
    emit(state.copyWith(confirmStatus: RequestStatus.loading));
     emit(state.copyWith(
      confirmStatus: RequestStatus.success,
      requestNumber: 'INS-002',
    ));
  }
}
