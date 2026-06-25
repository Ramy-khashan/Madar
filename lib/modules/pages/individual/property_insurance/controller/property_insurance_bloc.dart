import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/constants/app_strings.dart';
import '../model/property_insurance_model.dart';

part 'property_insurance_event.dart';
part 'property_insurance_state.dart';

class PropertyInsuranceBloc
    extends Bloc<PropertyInsuranceEvent, PropertyInsuranceState> {
  PropertyInsuranceBloc() : super(const PropertyInsuranceState()) {
    on<PropertyInsuranceLoad>(_onLoad);
    on<PropertyInsuranceTabChanged>(_onTabChanged);
  }

  static PropertyInsuranceBloc get(BuildContext context) =>
      context.read<PropertyInsuranceBloc>();

  static const List<InsuranceRequestModel> _mockRequests = [
    InsuranceRequestModel(
      id: '1',
      propertyName: 'شقة في حي النرجس',
      insuranceType: 'شامل',
      companyName: 'التعاونية',
      startDate: '2025-01-01',
      endDate: '2025-12-31',
      status: 'active',
    ),
    InsuranceRequestModel(
      id: '2',
      propertyName: 'شقة في حي النرجس',
      insuranceType: 'شامل',
      companyName: 'التعاونية',
      startDate: '2025-01-01',
      endDate: '2025-12-31',
      status: 'renewal_pending',
    ),
    InsuranceRequestModel(
      id: '3',
      propertyName: 'شقة في حي النرجس',
      insuranceType: 'شامل',
      companyName: 'التعاونية',
      startDate: '2025-01-01',
      endDate: '2025-12-31',
      status: 'expired',
    ),
  ];

  static const List<InsuranceOfferModel> _mockOffers = [
    InsuranceOfferModel(
      companyName: 'التعاونية',
      insuranceTypeText: 'أساسي / شامل',
      coverageDescription: 'تغطية شاملة للأضرار الأساسية والكوارث',
      startingPrice: 800,
    ),
    InsuranceOfferModel(
      companyName: 'الراجحي تكافل',
      insuranceTypeText: 'أساسي / شامل',
      coverageDescription: 'تغطية متكاملة مع خيارات إضافية',
      startingPrice: 800,
    ),
  ];

  static final List<CoverageRiskModel> _mockCoverageRisks = [
    CoverageRiskModel(
      riskName: AppStrings.fireDamageRisk,
      basicCovered: true,
      comprehensiveCovered: true,
    ),
    CoverageRiskModel(
      riskName: AppStrings.waterDamageRisk,
      basicCovered: true,
      comprehensiveCovered: true,
    ),
    CoverageRiskModel(
      riskName: AppStrings.naturalDisastersRisk,
      basicCovered: false,
      comprehensiveCovered: true,
    ),
    CoverageRiskModel(
      riskName: AppStrings.structuralDamageRisk,
      basicCovered: false,
      comprehensiveCovered: true,
    ),
    CoverageRiskModel(
      riskName: AppStrings.theftBurglaryRisk,
      basicCovered: false,
      comprehensiveCovered: true,
    ),
    CoverageRiskModel(
      riskName: AppStrings.civilLiabilityRisk,
      basicCovered: false,
      comprehensiveCovered: true,
    ),
  ];

  void _onLoad(
    PropertyInsuranceLoad event,
    Emitter<PropertyInsuranceState> emit,
  ) {
    emit(state.copyWith(
      requests: _mockRequests,
      offers: _mockOffers,
      coverageRisks: _mockCoverageRisks,
    ));
  }

  void _onTabChanged(
    PropertyInsuranceTabChanged event,
    Emitter<PropertyInsuranceState> emit,
  ) {
    emit(state.copyWith(selectedTab: event.tabIndex));
  }
}

