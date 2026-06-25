 import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../model/broker_model.dart';

part 'choose_broker_event.dart';
part 'choose_broker_state.dart';

class ChooseBrokerBloc extends Bloc<ChooseBrokerEvent, ChooseBrokerState> {
  ChooseBrokerBloc() : super(const ChooseBrokerState()) {
    on<ChooseBrokerLoad>(_onLoad);
    on<ChooseBrokerSearch>(_onSearch);
    on<ChooseBrokerSelect>(_onSelect);
    on<ChooseBrokerConfirm>(_onConfirm);
    on<ChooseBrokerBack>(_onBack);
  }

  static ChooseBrokerBloc get(BuildContext context) =>
      BlocProvider.of<ChooseBrokerBloc>(context);

  Future<void> _onLoad(
    ChooseBrokerLoad event,
    Emitter<ChooseBrokerState> emit,
  ) async {
    emit(state.copyWith(loadStatus: RequestStatus.loading));
     emit(state.copyWith(
      loadStatus: RequestStatus.success,
      brokers: _mockBrokers,
    ));
  }

  void _onSearch(ChooseBrokerSearch event, Emitter<ChooseBrokerState> emit) {
    emit(state.copyWith(searchQuery: event.query));
  }

  void _onSelect(ChooseBrokerSelect event, Emitter<ChooseBrokerState> emit) {
    emit(state.copyWith(
      selectedBrokerId: event.brokerId,
      step: ChooseBrokerStep.details,
    ));
  }

  Future<void> _onConfirm(
    ChooseBrokerConfirm event,
    Emitter<ChooseBrokerState> emit,
  ) async {
    emit(state.copyWith(confirmStatus: RequestStatus.loading));
     emit(state.copyWith(confirmStatus: RequestStatus.success));
  }

  void _onBack(ChooseBrokerBack event, Emitter<ChooseBrokerState> emit) {
    emit(state.copyWith(
      step: ChooseBrokerStep.list,
      clearSelectedBrokerId: true,
    ));
  }

  static const List<BrokerModel> _mockBrokers = [
    BrokerModel(
      id: '1',
      name: 'مكتب العقارات المتميزة',
      licenseNumber: 'REC-2023-1001',
      rating: 4.9,
      reviewsCount: 127,
      propertiesCount: 45,
      location: 'الرياض وضواحيها',
      experienceYears: 8,
      commissionPercent: 2.5,
      description:
          'متخصصون في عقارات الرياض الفاخرة مع خدمة تسويق احترافية',
    ),
    BrokerModel(
      id: '2',
      name: 'وسيط العقار السريع',
      licenseNumber: 'REC-2023-1001',
      rating: 4.9,
      reviewsCount: 127,
      propertiesCount: 45,
      location: 'جدة والساحل الغربي',
      experienceYears: 6,
      commissionPercent: 2.5,
      description:
          'نوفر خدمات سريعة للبيع والإيجار مع متابعة مستمرة',
    ),
    BrokerModel(
      id: '3',
      name: 'شركة الأفق العقارية',
      licenseNumber: 'REC-2023-1005',
      rating: 4.7,
      reviewsCount: 98,
      propertiesCount: 32,
      location: 'الدمام والمنطقة الشرقية',
      experienceYears: 10,
      commissionPercent: 2.0,
      description:
          'خبرة واسعة في سوق المنطقة الشرقية مع شبكة واسعة من المشترين',
    ),
  ];
   static List<String> responsibilities = [
      AppStrings.respReviewDocs,
      AppStrings.respPhotography,
      AppStrings.respPublish,
      AppStrings.respManageContacts,
      AppStrings.respOrganizeInspections,
      AppStrings.respCompleteProcedures,
    ];
}
