part of 'subscription_bloc.dart';

class SubscriptionState extends Equatable {
  const SubscriptionState({
    this.loadStatus = RequestStatus.init,
    this.plans = const [],
    this.billingCycle = SubscriptionBillingCycle.monthly,
    this.selectedPlanId,
    this.paymentMethod,
    this.confirmStatus = RequestStatus.init,
    this.transactionId = '',
    this.errorMsg = '',
  });

  final RequestStatus loadStatus;
  final List<SubscriptionPlanModel> plans;
  final SubscriptionBillingCycle billingCycle;
  final String? selectedPlanId;
  final SubscriptionPaymentMethod? paymentMethod;
  final RequestStatus confirmStatus;
  final String transactionId;
  final String errorMsg;

  SubscriptionPlanModel? get selectedPlan => selectedPlanId == null
      ? null
      : plans.firstWhere((p) => p.id == selectedPlanId);

  double get selectedPrice {
    if (selectedPlan == null) return 0;
    return billingCycle == SubscriptionBillingCycle.monthly
        ? selectedPlan!.monthlyPrice
        : selectedPlan!.yearlyPrice;
  }

  @override
  List<Object?> get props => [
        loadStatus,
        plans,
        billingCycle,
        selectedPlanId,
        paymentMethod,
        confirmStatus,
        transactionId,
        errorMsg,
      ];

  SubscriptionState copyWith({
    RequestStatus? loadStatus,
    List<SubscriptionPlanModel>? plans,
    SubscriptionBillingCycle? billingCycle,
    String? selectedPlanId,
    SubscriptionPaymentMethod? paymentMethod,
    RequestStatus? confirmStatus,
    String? transactionId,
    String? errorMsg,
  }) {
    return SubscriptionState(
      loadStatus: loadStatus ?? this.loadStatus,
      plans: plans ?? this.plans,
      billingCycle: billingCycle ?? this.billingCycle,
      selectedPlanId: selectedPlanId ?? this.selectedPlanId,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      confirmStatus: confirmStatus ?? this.confirmStatus,
      transactionId: transactionId ?? this.transactionId,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
