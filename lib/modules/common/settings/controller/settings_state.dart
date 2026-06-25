part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  final UserProfileModel? profile;
  final bool notificationsEnabled;
  final bool darkModeEnabled;
  final String selectedLanguage;

  const SettingsState({
      this.profile,
      this.notificationsEnabled=false,
      this.darkModeEnabled=false,
      this.selectedLanguage='ar',
  });

  SettingsState copyWith({
    UserProfileModel? profile,
    bool? notificationsEnabled,
    bool? darkModeEnabled,
    String? selectedLanguage,
  }) => SettingsState(
    profile: profile ?? this.profile,
    notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    selectedLanguage: selectedLanguage ?? this.selectedLanguage,
    darkModeEnabled: darkModeEnabled ?? this.darkModeEnabled,
  );

  @override
  List<Object?> get props => [profile, notificationsEnabled, darkModeEnabled, selectedLanguage];
}
