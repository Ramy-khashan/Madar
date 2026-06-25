part of 'sign_in_bloc.dart';

sealed class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class SignInActionEvent extends SignInEvent {
  const SignInActionEvent();
  @override
  List<Object> get props => [];
}
