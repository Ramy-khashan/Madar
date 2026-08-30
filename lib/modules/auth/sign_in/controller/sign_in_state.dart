part of 'sign_in_bloc.dart';

class SignInState extends Equatable {
  const SignInState({
    this.autoValidate = AutovalidateMode.disabled,
    this.signInStatus = RequestStatus.init,
    this.errorMsg = '',
    this.role = '',
    this.selectedRole = AppConstant.business,
  });
  final AutovalidateMode autoValidate;
  final RequestStatus signInStatus;
  final String errorMsg;
  final String role;
  final String selectedRole;
  @override
  List<Object> get props => [
    autoValidate,
    signInStatus,
    errorMsg,
    role,
    selectedRole,
  ];
  SignInState copyWith({
    AutovalidateMode? autoValidate,
    RequestStatus? signInStatus,
    String? errorMsg,
    String? role,
    String? selectedRole,
  }) => SignInState(
    signInStatus: signInStatus ?? this.signInStatus,
    autoValidate: autoValidate ?? this.autoValidate,
    errorMsg: errorMsg ?? this.errorMsg,
    role: role ?? this.role,
    selectedRole: selectedRole ?? this.selectedRole,
  );
}
