part of 'splash_bloc.dart';

sealed class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object> get props => [];
}

class InitAppEvent extends SplashEvent {
  const InitAppEvent();
  @override
  List<Object> get props => [];
}
