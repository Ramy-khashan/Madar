part of 'smart_assistant_intro_bloc.dart';

sealed class SmartAssistantIntroEvent extends Equatable {
  const SmartAssistantIntroEvent();

  @override
  List<Object> get props => [];
}

final class SmartAssistantIntroLoad extends SmartAssistantIntroEvent {
  const SmartAssistantIntroLoad();
}

final class SmartAssistantIntroModeToggled extends SmartAssistantIntroEvent {
  const SmartAssistantIntroModeToggled();
}
