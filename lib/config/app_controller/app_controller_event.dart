part of 'app_controller_bloc.dart';

sealed class AppControllerEvent extends Equatable {
  const AppControllerEvent();

  @override
  List<Object> get props => [];
}

final class AppControllerInit extends AppControllerEvent {
  const AppControllerInit();
}

final class AppControllerThemeToggled extends AppControllerEvent {
  const AppControllerThemeToggled();
}
