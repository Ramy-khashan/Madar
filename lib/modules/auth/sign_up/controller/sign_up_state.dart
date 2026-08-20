part of 'sign_up_bloc.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.autoValidateMode = AutovalidateMode.disabled,
    this.errorMsg = '',
    this.signUpStatus = RequestStatus.init,
    this.falLicenseFilePath = '',
  });

  final AutovalidateMode autoValidateMode;
  final RequestStatus signUpStatus;
  final String errorMsg;
  final String falLicenseFilePath;

  @override
  List<Object> get props => [
    autoValidateMode,
    signUpStatus,
    errorMsg,
    falLicenseFilePath,
  ];

  SignUpState copyWith({
    AutovalidateMode? autoValidateMode,
    RequestStatus? signUpStatus,
    String? errorMsg,
    String? falLicenseFilePath,
  }) => SignUpState(
    autoValidateMode: autoValidateMode ?? this.autoValidateMode,
    signUpStatus: signUpStatus ?? this.signUpStatus,
    errorMsg: errorMsg ?? this.errorMsg,
    falLicenseFilePath: falLicenseFilePath ?? this.falLicenseFilePath,
  );
}
