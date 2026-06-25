part of 'sign_up_bloc.dart';

  class SignUpState extends Equatable {
  const SignUpState({this.autoValidateMode = AutovalidateMode.disabled,this.errorMsg="", this.signUpStatus = RequestStatus.init});
  final AutovalidateMode autoValidateMode ;
  final RequestStatus signUpStatus ;
  final String errorMsg ;
  @override
  List<Object> get props => [autoValidateMode,signUpStatus,errorMsg];
  SignUpState copyWith({
    AutovalidateMode? autoValidateMode,
    RequestStatus? signUpStatus,
    String? errorMsg,
  }) => SignUpState(
    autoValidateMode: autoValidateMode??this.autoValidateMode,
    signUpStatus: signUpStatus??this.signUpStatus,
    errorMsg: errorMsg??this.errorMsg
  );
}
 