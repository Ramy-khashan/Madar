part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpActionEvent extends SignUpEvent {
  const SignUpActionEvent();
}

class SignUpLicenseFilePicked extends SignUpEvent {
  const SignUpLicenseFilePicked(this.path);

  final String path;

  @override
  List<Object> get props => [path];
}

class SignUpLicenseFileCleared extends SignUpEvent {
  const SignUpLicenseFileCleared();
}
