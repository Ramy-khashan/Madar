part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  final UserProfileModel? profile;
  final bool notificationsEnabled;
  final bool darkModeEnabled;
  final String selectedLanguage;
  final int savedItem;
  final RequestStatus loadingSavedItems;
  final RequestStatus loadingProfile;
  final RequestStatus loadingImageProfile;
  final RequestStatus updateFullNameStatus;
  final RequestStatus updatePhoneStatus;

  const SettingsState({
      this.profile,
      this.notificationsEnabled=false,
      this.darkModeEnabled=false,
      this.selectedLanguage='ar',
      this.savedItem=0,
      this.loadingSavedItems=RequestStatus.init,
      this.loadingProfile=RequestStatus.init, 
      this.loadingImageProfile=RequestStatus.init, 
      this.updateFullNameStatus=RequestStatus.init,
      this.updatePhoneStatus=RequestStatus.init,
  });

  SettingsState copyWith({
    UserProfileModel? profile,
    bool? notificationsEnabled,
    bool? darkModeEnabled,
    String? selectedLanguage,
    int? savedItem,
    RequestStatus? loadingSavedItems,
    RequestStatus? loadingProfile,
    RequestStatus? loadingImageProfile,
    RequestStatus? updateFullNameStatus,
    RequestStatus? updatePhoneStatus,
  }) => SettingsState(
    profile: profile ?? this.profile,
    notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    darkModeEnabled: darkModeEnabled ?? this.darkModeEnabled,
    savedItem: savedItem ?? this.savedItem,
    loadingSavedItems: loadingSavedItems ?? this.loadingSavedItems,
    loadingProfile: loadingProfile ?? this.loadingProfile,
    selectedLanguage: selectedLanguage ?? this.selectedLanguage,
    loadingImageProfile: loadingImageProfile ?? this.loadingImageProfile,
    updateFullNameStatus: updateFullNameStatus ?? this.updateFullNameStatus,
    updatePhoneStatus: updatePhoneStatus ?? this.updatePhoneStatus,
  );

  @override
  List<Object?> get props => [profile, notificationsEnabled, loadingImageProfile,darkModeEnabled, selectedLanguage, savedItem,loadingSavedItems,loadingProfile ];
}
