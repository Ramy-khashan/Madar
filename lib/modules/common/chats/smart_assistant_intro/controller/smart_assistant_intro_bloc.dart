import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'smart_assistant_intro_event.dart';
part 'smart_assistant_intro_state.dart';

class SmartAssistantIntroBloc
    extends Bloc<SmartAssistantIntroEvent, SmartAssistantIntroState> {
  SmartAssistantIntroBloc() : super(SmartAssistantIntroInitial()) {
    on<SmartAssistantIntroLoad>(_onLoad);
    on<SmartAssistantIntroModeToggled>(_onModeToggled);
  }

  static SmartAssistantIntroBloc get(BuildContext context) =>
      BlocProvider.of<SmartAssistantIntroBloc>(context);

  void _onLoad(
    SmartAssistantIntroLoad event,
    Emitter<SmartAssistantIntroState> emit,
  ) {
    emit(const SmartAssistantIntroReady());
  }

  void _onModeToggled(
    SmartAssistantIntroModeToggled event,
    Emitter<SmartAssistantIntroState> emit,
  ) {
    if (state is SmartAssistantIntroReady) {
      final current = state as SmartAssistantIntroReady;
      emit(current.copyWith(isMicMode: !current.isMicMode));
    }
  }
}
