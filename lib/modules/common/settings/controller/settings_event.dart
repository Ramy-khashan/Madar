part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

final class SettingsLoad extends SettingsEvent {
  const SettingsLoad();
}

final class SettingsNotificationsToggled extends SettingsEvent {
  const SettingsNotificationsToggled();
}

final class SettingsLogoutRequested extends SettingsEvent {
  const SettingsLogoutRequested();
}

final class SettingsDarkModeToggled extends SettingsEvent {
  const SettingsDarkModeToggled();
}

final class SettingsLanguageChanged extends SettingsEvent {
  final String langCode;
  const SettingsLanguageChanged(this.langCode);

  @override
  List<Object> get props => [langCode];
}