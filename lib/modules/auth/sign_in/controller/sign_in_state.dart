part of 'sign_in_bloc.dart';

class SignInState extends Equatable {
  const SignInState({
    this.autoValidate = AutovalidateMode.disabled,
    this.signInStatus = RequestStatus.init,
    this.errorMsg = '',
    this.role = '',
  });
  final AutovalidateMode autoValidate;
  final RequestStatus signInStatus;
  final String errorMsg;
  final String role;
  @override
  List<Object> get props => [autoValidate, signInStatus, errorMsg,role];
  SignInState copyWith({
    AutovalidateMode? autoValidate,
    RequestStatus? signInStatus,
    String? errorMsg,
    String? role,
  }) => SignInState(
    signInStatus:signInStatus??this.signInStatus,
    autoValidate:autoValidate??this.autoValidate,
    errorMsg:errorMsg??this.errorMsg,
    role:role??this.role,
  );
}
