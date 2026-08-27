import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/repository/apis/auth_apis.dart';
import '../../../../core/utils/constants/app_strings.dart';

part 'otp_verification_event.dart';
part 'otp_verification_state.dart';

class OtpVerificationBloc
    extends Bloc<OtpVerificationEvent, OtpVerificationState> {
  final TextEditingController pinController = TextEditingController();
  final String phone;

  OtpVerificationBloc({required this.phone}) : super(OtpVerificationInitial()) {
    on<OtpChangedEvent>(_onOtpChanged);
    on<OtpSubmittedEvent>(_onOtpSubmitted);
    on<OtpResendEvent>(_onOtpResend);
  }

  static OtpVerificationBloc get(BuildContext context) =>
      context.read<OtpVerificationBloc>();

  void _onOtpChanged(
    OtpChangedEvent event,
    Emitter<OtpVerificationState> emit,
  ) {}

  Future<void> _onOtpSubmitted(
    OtpSubmittedEvent event,
    Emitter<OtpVerificationState> emit,
  ) async {
    final code = pinController.text.trim();
    if (code.length != 6 || phone.isEmpty) return;
    emit(OtpVerificationLoading());
    final result = await AuthApis.verifyOtp(phone: phone, code: code);
    result.fold(
      (failed) => emit(OtpVerificationError(failed)),
      (_) => emit(OtpVerificationSuccess()),
    );
  }

  Future<void> _onOtpResend(
    OtpResendEvent event,
    Emitter<OtpVerificationState> emit,
  ) async {
    if (phone.isEmpty) return;
    emit(OtpResendLoading());
    pinController.clear();
    final result = await AuthApis.sendOtp(phone: phone);
    result.fold(
      (failed) => emit(OtpVerificationError(failed)),
      (message) => emit(
        OtpResendSuccess(
          message.isNotEmpty ? message : AppStrings.otpSentSuccessfully,
        ),
      ),
    );
  }

  @override
  Future<void> close() {
    pinController.dispose();
    return super.close();
  }
}
