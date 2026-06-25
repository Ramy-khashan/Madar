import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/constants/app_strings.dart';
import '../model/contract_model.dart';
import '../model/tabs_model.dart';

part 'contracts_event.dart';
part 'contracts_state.dart';

class ContractsBloc extends Bloc<ContractsEvent, ContractsState> {
  ContractsBloc() : super(const ContractsState()) {
    on<ContractsLoad>(_onLoad);
    on<ContractsFilterChanged>(_onFilterChanged);
  }

  static ContractsBloc get(BuildContext context) =>
      context.read<ContractsBloc>();

  static final List<ContractModel> _mockContracts = [
    const ContractModel(
      id: '1',
      title: 'عقد شراء - شقة الملقا',
      propertyName: 'شقة الملقا، الرياض',
      location: 'الرياض',
      amount: 850000,
      date: '2024-01-15',
      status: 'active',
      type: 'buy',
    ),
    const ContractModel(
      id: '2',
      title: 'عقد إيجار - فيلا جدة',
      propertyName: 'فيلا الشاطئ، جدة',
      location: 'جدة',
      amount: 850000,
      date: '2024-02-01',
      status: 'underReview',
      type: 'monthlyRent',
    ),
    const ContractModel(
      id: '3',
      title: 'عقد شراء - دوبلكس الدمام',
      propertyName: 'دوبلكس الشاطئ، الدمام',
      location: 'الدمام',
      amount: 850000,
      date: '2023-12-10',
      status: 'completed',
      type: 'buy',
    ),
  ];

  void _onLoad(ContractsLoad event, Emitter<ContractsState> emit) {
    emit(
      state.copyWith(
        allContracts: _mockContracts,
        selectedFilter: 'all',
      ),
    );
  }

  void _onFilterChanged(
    ContractsFilterChanged event,
    Emitter<ContractsState> emit,
  ) {
    emit(state.copyWith(selectedFilter: event.filter));
  }

  static List<ContractTabsModel> tabs = [
    ContractTabsModel(id: 'all', title: AppStrings.allTab),
    ContractTabsModel(id: 'active', title: AppStrings.activeStatus),
    ContractTabsModel(id: 'completed', title: AppStrings.completedStatus),
  ];
}
