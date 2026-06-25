part of 'app_controller_bloc.dart';

class AppControllerState extends Equatable {
  const AppControllerState({
    this.themeMode = ThemeMode.light,
  });

  final ThemeMode themeMode;

  bool get isDark => themeMode == ThemeMode.dark;

  AppControllerState copyWith({ThemeMode? themeMode}) => AppControllerState(
        themeMode: themeMode ?? this.themeMode,
      );

  @override
  List<Object> get props => [themeMode];
}
