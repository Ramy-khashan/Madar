part of 'smart_assistant_intro_bloc.dart';

sealed class SmartAssistantIntroState extends Equatable {
  const SmartAssistantIntroState();

  @override
  List<Object> get props => [];
}

final class SmartAssistantIntroInitial extends SmartAssistantIntroState {}

final class SmartAssistantIntroReady extends SmartAssistantIntroState {
  const SmartAssistantIntroReady({this.isMicMode = true});

  final bool isMicMode;

  SmartAssistantIntroReady copyWith({bool? isMicMode}) =>
      SmartAssistantIntroReady(isMicMode: isMicMode ?? this.isMicMode);

  @override
  List<Object> get props => [isMicMode];
}
