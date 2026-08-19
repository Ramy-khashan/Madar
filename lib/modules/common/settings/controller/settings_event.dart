part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

final class SettingsLoad extends SettingsEvent {
  const SettingsLoad();
}

final class SettingsGetSavedCount extends SettingsEvent {
  const SettingsGetSavedCount();
}

final class SettingsGetProfile extends SettingsEvent {
  const SettingsGetProfile();
}

final class HandleProfileImageEvent extends SettingsEvent {
  const HandleProfileImageEvent();
}

class UpdateFullNameEvent extends SettingsEvent {
  const UpdateFullNameEvent(
      {required this.context});

  final BuildContext context;
}

class UpdatePhoneEvent extends SettingsEvent {
  const UpdatePhoneEvent({required this.context});

  final BuildContext context;
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
