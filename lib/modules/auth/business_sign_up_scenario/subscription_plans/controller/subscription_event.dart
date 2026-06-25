part of 'subscription_bloc.dart';

abstract class SubscriptionEvent extends Equatable {
  const SubscriptionEvent();

  @override
  List<Object?> get props => [];
}

class SubscriptionLoad extends SubscriptionEvent {
  const SubscriptionLoad();
}

class SubscriptionBillingCycleToggled extends SubscriptionEvent {
  final SubscriptionBillingCycle cycle;
  const SubscriptionBillingCycleToggled(this.cycle);

  @override
  List<Object?> get props => [cycle];
}

class SubscriptionPlanSelected extends SubscriptionEvent {
  final String planId;
  const SubscriptionPlanSelected(this.planId);

  @override
  List<Object?> get props => [planId];
}

class SubscriptionPaymentMethodSelected extends SubscriptionEvent {
  final SubscriptionPaymentMethod method;
  const SubscriptionPaymentMethodSelected(this.method);

  @override
  List<Object?> get props => [method];
}

class SubscriptionConfirmPayment extends SubscriptionEvent {
  const SubscriptionConfirmPayment();
}
