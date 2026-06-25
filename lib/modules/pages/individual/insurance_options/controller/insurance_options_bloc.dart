import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/constants/app_enums.dart';
import '../model/insurance_options_model.dart';

part 'insurance_options_event.dart';
part 'insurance_options_state.dart';

class InsuranceOptionsBloc
    extends Bloc<InsuranceOptionsEvent, InsuranceOptionsState> {
  InsuranceOptionsBloc() : super(const InsuranceOptionsState()) {
    on<InsuranceOptionsLoad>(_onLoad);
    on<InsuranceOptionsTypeSelected>(_onTypeSelected);
    on<InsuranceOptionsCompanySelected>(_onCompanySelected);
    on<InsuranceOptionsConfirm>(_onConfirm);
  }

  static InsuranceOptionsBloc get(BuildContext context) =>
      BlocProvider.of<InsuranceOptionsBloc>(context);

  Future<void> _onLoad(
    InsuranceOptionsLoad event,
    Emitter<InsuranceOptionsState> emit,
  ) async {
    emit(state.copyWith(getDetailsStatus: RequestStatus.loading));
     emit(
      state.copyWith(
        getDetailsStatus: RequestStatus.success,
        propertyTitle: 'شقة فاخرة في الملقا',
        propertyLocation: 'الرياض - حي الملقا',
        propertyPrice: 850000,
        propertyType: 'شقة سكنية',
        types: const [
          InsuranceTypeModel(
            id: 'basic',
            name: 'تأمين أساسي',
            pricePerYear: 850000,
            coverages: ['السرقة', 'الكوارث الطبيعية', 'الحرائق'],
            isRecommended: false,
          ),
          InsuranceTypeModel(
            id: 'comprehensive',
            name: 'تأمين شامل',
            pricePerYear: 850000,
            coverages: [
              'أضرار المياه', 'السرقة', 'الكوارث الطبيعية',
              'الأضرار الكهربائية', 'المسؤولية المدنية', 'الحرائق',
            ],
            isRecommended: true,
          ),
        ],
        companies: const [
          InsuranceCompanyModel(id: 'taawuni', name: 'التعاونية', rating: 4.8, processingHours: 24, discountPercent: 5),
          InsuranceCompanyModel(id: 'malath', name: 'ملاذ للتأمين', rating: 4.8, processingHours: 24, discountPercent: 5),
          InsuranceCompanyModel(id: 'wala', name: 'ولاء للتأمين', rating: 4.8, processingHours: 24, discountPercent: 5),
        ],
      ),
    );
  }

  void _onTypeSelected(
    InsuranceOptionsTypeSelected event,
    Emitter<InsuranceOptionsState> emit,
  ) {
    emit(state.copyWith(selectedTypeId: event.typeId));
  }

  void _onCompanySelected(
    InsuranceOptionsCompanySelected event,
    Emitter<InsuranceOptionsState> emit,
  ) {
    emit(state.copyWith(selectedCompanyId: event.companyId));
  }

  Future<void> _onConfirm(
    InsuranceOptionsConfirm event,
    Emitter<InsuranceOptionsState> emit,
  ) async {
    emit(state.copyWith(confirmStatus: RequestStatus.loading));
     emit(state.copyWith(
      confirmStatus: RequestStatus.success,
      requestNumber: 'INS-003',
    ));
  }
}
