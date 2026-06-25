import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/app_controller/app_controller_bloc.dart';
import '../../../../../core/utils/functions/service_locator.dart';
import '../../../../../core/utils/functions/translation.dart';
import '../../../../../madar_app.dart';
import '../model/user_profile_model.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState()) {
    on<SettingsLoad>(_onLoad);
    on<SettingsNotificationsToggled>(_onNotificationsToggled);
    on<SettingsDarkModeToggled>(_onDarkModeToggled);
    on<SettingsLogoutRequested>(_onLogout);
    on<SettingsLanguageChanged>(_onLanguageChanged);
  }

  static SettingsBloc get(BuildContext context) => context.read<SettingsBloc>();

  void _onLoad(SettingsLoad event, Emitter<SettingsState> emit) {
    final isDark = sl<AppControllerBloc>().state.isDark;
    emit(
      state.copyWith(
        profile: const UserProfileModel(
          name: 'أحمد السعيد',
          accountType: 'فرد',
          location: 'الرياض، السعودية',
        ),
        notificationsEnabled: true,
        selectedLanguage:MadarApp.navigatorKey.currentContext != null ? locale(MadarApp.navigatorKey.currentContext!).languageCode : 'ar',
        darkModeEnabled: isDark,
      ),
    );
  }

  void _onNotificationsToggled(
    SettingsNotificationsToggled event,
    Emitter<SettingsState> emit,
  ) {
    emit(state.copyWith(notificationsEnabled: !state.notificationsEnabled));
  }

  void _onDarkModeToggled(
    SettingsDarkModeToggled event,
    Emitter<SettingsState> emit,
  ) {
    sl<AppControllerBloc>().add(const AppControllerThemeToggled());
    emit(state.copyWith(darkModeEnabled: !state.darkModeEnabled));
  }

  void _onLanguageChanged(
    SettingsLanguageChanged event,
    Emitter<SettingsState> emit,
  ) {
    final label = event.langCode == 'ar' ? 'اللغة العربية' : 'English';
    emit(state.copyWith(selectedLanguage: label));
  }

  void _onLogout(SettingsLogoutRequested event, Emitter<SettingsState> emit) {}
}
