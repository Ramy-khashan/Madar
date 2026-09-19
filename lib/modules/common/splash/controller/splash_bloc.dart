import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/constants/app_enums.dart';
import '../../../../core/utils/constants/storage_keys.dart';
import '../../../../core/utils/functions/handle_multi_callback.dart';
import '../../../../core/utils/functions/preference_utils.dart';
import '../../../../core/utils/functions/service_locator.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc(TickerProvider vsync) : super(const SplashState()) {
    _controller = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 1600),
    );

    logoScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.65, curve: Curves.elasticOut),
      ),
    );

    logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
      ),
    );

    ringScale = Tween<double>(begin: 0.5, end: 2.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.15, 0.75, curve: Curves.easeOut),
      ),
    );

    ringOpacity = Tween<double>(begin: 0.45, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.15, 0.75, curve: Curves.easeOut),
      ),
    );

    textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 0.9, curve: Curves.easeIn),
      ),
    );

    textSlide = Tween<Offset>(begin: const Offset(0, 0.6), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.6, 1.0, curve: Curves.easeOutCubic),
          ),
        );

    on<InitAppEvent>(_initApp);
  }

  late final AnimationController _controller;

  late final Animation<double> logoScale;
  late final Animation<double> logoOpacity;
  late final Animation<double> ringScale;
  late final Animation<double> ringOpacity;
  late final Animation<double> textOpacity;
  late final Animation<Offset> textSlide;

  Future<void> _initApp(InitAppEvent event, Emitter<SplashState> emit) async {
    _controller.forward();
    bool isHaveToken = false;
    await Future.delayed(const Duration(seconds: 2), () async {
      isHaveToken =
          await sl.get<HandleMultiCallLocal>().getLocalData(
            keyType: LocalEnumKey.accessToken,
          ) !=
          null;
    });
    final bool isOnboardingCompleted = PreferenceUtils().getBool(
      StorageKeys.onboardingCompleted,
    );

    emit(
      state.copyWith(
        isDoneSplash: true,
        isOnboardingCompleted: isOnboardingCompleted,
        isHaveToken: isHaveToken,
        isGuest: PreferenceUtils().getBool(StorageKeys.isGuest),
        role: PreferenceUtils().getString(StorageKeys.accountType),
      ),
    );
  }

  @override
  Future<void> close() {
    _controller.dispose();
    return super.close();
  }
}
