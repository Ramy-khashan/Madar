part of 'sign_in_bloc.dart';

class SignInState extends Equatable {
  const SignInState({
    this.autoValidate = AutovalidateMode.disabled,
    this.signInStatus = RequestStatus.init,
    this.errorMsg = '',
  });
  final AutovalidateMode autoValidate;
  final RequestStatus signInStatus;
  final String errorMsg;
  @override
  List<Object> get props => [autoValidate, signInStatus, errorMsg];
  SignInState copyWith({
    AutovalidateMode? autoValidate,
    RequestStatus? signInStatus,
    String? errorMsg,
  }) => SignInState(
    signInStatus:signInStatus??this.signInStatus,
    autoValidate:autoValidate??this.autoValidate,
    errorMsg:errorMsg??this.errorMsg
  );
}
