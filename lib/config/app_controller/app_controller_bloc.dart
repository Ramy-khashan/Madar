import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/functions/preference_utils.dart';
import '../../../core/utils/functions/service_locator.dart';

part 'app_controller_event.dart';
part 'app_controller_state.dart';

const _kThemeKey = 'app_theme_dark';

class AppControllerBloc extends Bloc<AppControllerEvent, AppControllerState> {
  AppControllerBloc() : super(const AppControllerState()) {
    on<AppControllerInit>(_onInit);
    on<AppControllerThemeToggled>(_onThemeToggled);
  }

  static AppControllerBloc get(BuildContext context) =>
      context.read<AppControllerBloc>();

  void _onInit(
    AppControllerInit event,
    Emitter<AppControllerState> emit,
  ) {
    final isDark = sl<PreferenceUtils>().getBool(_kThemeKey);
    emit(state.copyWith(
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
    ));
  }

  Future<void> _onThemeToggled(
    AppControllerThemeToggled event,
    Emitter<AppControllerState> emit,
  ) async {
    final newIsDark = !state.isDark;
    await sl<PreferenceUtils>().setBool(_kThemeKey, newIsDark);
    emit(state.copyWith(
      themeMode: newIsDark ? ThemeMode.dark : ThemeMode.light,
    ));
  }
}

