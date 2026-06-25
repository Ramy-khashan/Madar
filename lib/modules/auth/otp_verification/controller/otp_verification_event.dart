part of 'otp_verification_bloc.dart';

sealed class OtpVerificationEvent extends Equatable {
  const OtpVerificationEvent();

  @override
  List<Object> get props => [];
}

final class OtpChangedEvent extends OtpVerificationEvent {
  final String otp;
  const OtpChangedEvent(this.otp);

  @override
  List<Object> get props => [otp];
}

final class OtpSubmittedEvent extends OtpVerificationEvent {
  const OtpSubmittedEvent();
}

final class OtpResendEvent extends OtpVerificationEvent {
  const OtpResendEvent();
}

