part of 'forget_password_bloc.dart';

class ForgetPasswordState extends Equatable {
  const ForgetPasswordState({
    this.sendStatus = RequestStatus.init,
    this.resetStatus = RequestStatus.init,
    this.errorMsg = '',
    this.successMsg = '',
    this.autoValidate = AutovalidateMode.disabled,
  });

  final RequestStatus sendStatus;
  final RequestStatus resetStatus;
  final String errorMsg;
  final String successMsg;
  final AutovalidateMode autoValidate;

  ForgetPasswordState copyWith({
    RequestStatus? sendStatus,
    RequestStatus? resetStatus,
    String? errorMsg,
    String? successMsg,
    AutovalidateMode? autoValidate,
  }) {
    return ForgetPasswordState(
      sendStatus: sendStatus ?? this.sendStatus,
      resetStatus: resetStatus ?? this.resetStatus,
      errorMsg: errorMsg ?? this.errorMsg,
      successMsg: successMsg ?? this.successMsg,
      autoValidate: autoValidate ?? this.autoValidate,
    );
  }

  @override
  List<Object> get props => [
    sendStatus,
    resetStatus,
    errorMsg,
    successMsg,
    autoValidate,
  ];
}
