part of 'forget_password_bloc.dart';

sealed class ForgetPasswordEvent extends Equatable {
  const ForgetPasswordEvent();

  @override
  List<Object> get props => [];
}

final class ForgetPasswordPhoneChanged extends ForgetPasswordEvent {
  const ForgetPasswordPhoneChanged(this.phone);
  final String phone;

  @override
  List<Object> get props => [phone];
}

final class ForgetPasswordSendOtp extends ForgetPasswordEvent {
  const ForgetPasswordSendOtp();
}

final class ForgetPasswordResetSubmitted extends ForgetPasswordEvent {
  const ForgetPasswordResetSubmitted();
}
