import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'otp_verification_event.dart';
part 'otp_verification_state.dart';

class OtpVerificationBloc extends Bloc<OtpVerificationEvent, OtpVerificationState> {
  final TextEditingController pinController = TextEditingController();

  OtpVerificationBloc() : super(OtpVerificationInitial()) {
    on<OtpChangedEvent>(_onOtpChanged);
    on<OtpSubmittedEvent>(_onOtpSubmitted);
    on<OtpResendEvent>(_onOtpResend);
  }

  static OtpVerificationBloc get(BuildContext context) => context.read<OtpVerificationBloc>();

  void _onOtpChanged(OtpChangedEvent event, Emitter<OtpVerificationState> emit) {
    // React to pin changes if needed
  }

  Future<void> _onOtpSubmitted(
    OtpSubmittedEvent event,
    Emitter<OtpVerificationState> emit,
  ) async {
    emit(OtpVerificationLoading());
    // TODO: call API with pinController.text
    // emit(OtpVerificationSuccess()) or emit(OtpVerificationError(message))
  }

  Future<void> _onOtpResend(
    OtpResendEvent event,
    Emitter<OtpVerificationState> emit,
  ) async {
    emit(OtpResendLoading());
    pinController.clear();
    // TODO: call resend OTP API
    // emit(OtpResendSuccess()) or emit(OtpVerificationError(message))
  }

  @override
  Future<void> close() {
    pinController.dispose();
    return super.close();
  }
}

