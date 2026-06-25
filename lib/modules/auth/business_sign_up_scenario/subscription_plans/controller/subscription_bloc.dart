import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/constants/app_enums.dart';
import '../model/subscription_plan_model.dart';

part 'subscription_event.dart';
part 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  SubscriptionBloc() : super(const SubscriptionState()) {
    on<SubscriptionLoad>(_onLoad);
    on<SubscriptionBillingCycleToggled>(_onBillingCycleToggled);
    on<SubscriptionPlanSelected>(_onPlanSelected);
    on<SubscriptionPaymentMethodSelected>(_onPaymentMethodSelected);
    on<SubscriptionConfirmPayment>(_onConfirmPayment);
  }

  static SubscriptionBloc get(BuildContext context) =>
      BlocProvider.of<SubscriptionBloc>(context);

  static final List<SubscriptionPlanModel> _mockPlans = [
    const SubscriptionPlanModel(
      id: 'basic',
      badge: 'basic',
      monthlyPrice: 99,
      yearlyPrice: 990,
      features: [
        'نشر حتى 10 عقارات',
        'مدة الإعلان 30 يوم',
        'لوحة تحكم بسيطة',
      ],
    ),
    const SubscriptionPlanModel(
      id: 'pro',
      badge: 'pro',
      monthlyPrice: 99,
      yearlyPrice: 990,
      features: [
        'نشر غير محدود',
        'تقارير متقدمة',
        'إدارة فريق العمل',
      ],
    ),
    const SubscriptionPlanModel(
      id: 'featured',
      badge: 'featured',
      monthlyPrice: 99,
      yearlyPrice: 990,
      features: [
        'نشر حتى 50 عقار',
        'إحصائيات المشاهدات',
        'دعم فني',
      ],
    ),
  ];

  Future<void> _onLoad(
    SubscriptionLoad event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(state.copyWith(loadStatus: RequestStatus.loading));
     emit(state.copyWith(
      loadStatus: RequestStatus.success,
      plans: _mockPlans,
    ));
  }

  void _onBillingCycleToggled(
    SubscriptionBillingCycleToggled event,
    Emitter<SubscriptionState> emit,
  ) {
    emit(state.copyWith(billingCycle: event.cycle));
  }

  void _onPlanSelected(
    SubscriptionPlanSelected event,
    Emitter<SubscriptionState> emit,
  ) {
    emit(state.copyWith(selectedPlanId: event.planId));
  }

  void _onPaymentMethodSelected(
    SubscriptionPaymentMethodSelected event,
    Emitter<SubscriptionState> emit,
  ) {
    emit(state.copyWith(paymentMethod: event.method));
  }

  Future<void> _onConfirmPayment(
    SubscriptionConfirmPayment event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(state.copyWith(confirmStatus: RequestStatus.loading));
    await Future.delayed(const Duration(seconds: 2));
    final txId = 'APL${DateTime.now().millisecondsSinceEpoch}';
    emit(state.copyWith(
      confirmStatus: RequestStatus.success,
      transactionId: txId,
    ));
  }
}
