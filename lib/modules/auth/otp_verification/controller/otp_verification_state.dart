part of 'otp_verification_bloc.dart';

sealed class OtpVerificationState extends Equatable {
  const OtpVerificationState();

  @override
  List<Object> get props => [];
}

final class OtpVerificationInitial extends OtpVerificationState {}

final class OtpVerificationLoading extends OtpVerificationState {}

final class OtpVerificationSuccess extends OtpVerificationState {}

final class OtpVerificationError extends OtpVerificationState {
  final String message;
  const OtpVerificationError(this.message);

  @override
  List<Object> get props => [message];
}

final class OtpResendLoading extends OtpVerificationState {}

final class OtpResendSuccess extends OtpVerificationState {}

