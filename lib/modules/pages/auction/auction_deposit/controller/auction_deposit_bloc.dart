import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/constants/app_enums.dart';
import '../model/auction_deposit_model.dart';
import '../model/payment_type_details_model.dart';

part 'auction_deposit_event.dart';
part 'auction_deposit_state.dart';

class AuctionDepositBloc
    extends Bloc<AuctionDepositEvent, AuctionDepositState> {
  AuctionDepositBloc() : super(const AuctionDepositState()) {
    on<AuctionDepositLoad>(_onLoad);
    on<AuctionDepositMethodSelected>(_onMethodSelected);
    on<AuctionDepositConfirmPayment>(_onConfirmPayment);
  }

  static AuctionDepositBloc get(BuildContext context) =>
      BlocProvider.of<AuctionDepositBloc>(context);

  Future<void> _onLoad(
    AuctionDepositLoad event,
    Emitter<AuctionDepositState> emit,
  ) async {
    emit(state.copyWith(loadStatus: RequestStatus.loading));
     emit(state.copyWith(
      loadStatus: RequestStatus.success,
      propertyTitle: 'شقة فاخرة في الملقا',
      depositAmount: 30000,
    ));
  }

  void _onMethodSelected(
    AuctionDepositMethodSelected event,
    Emitter<AuctionDepositState> emit,
  ) {
    emit(state.copyWith(selectedPaymentMethod: event.method));
  }

  Future<void> _onConfirmPayment(
    AuctionDepositConfirmPayment event,
    Emitter<AuctionDepositState> emit,
  ) async {
    emit(state.copyWith(
      step: AuctionDepositStep.processing,
      confirmStatus: RequestStatus.loading,
    ));
     final txId = 'APL${DateTime.now().millisecondsSinceEpoch}';
    emit(state.copyWith(
      confirmStatus: RequestStatus.success,
      transactionId: txId,
      step: AuctionDepositStep.success,
    ));
  }
  static List<PaymentTypeDetailsModel> paymentMethods = [
    PaymentTypeDetailsModel(
      method: AuctionDepositPaymentMethod.applePay,
      label: 'Apple Pay',
      subtitle: 'الدفع عبر Apple Pay',
      iconPath: 'assets/icons/apple_pay.svg',
    ),
    PaymentTypeDetailsModel(
      method: AuctionDepositPaymentMethod.visa,
      label: 'Visa',
      subtitle: 'الدفع عبر بطاقات Visa',
      iconPath: 'assets/icons/visa.svg',
    ),
  ];
}
