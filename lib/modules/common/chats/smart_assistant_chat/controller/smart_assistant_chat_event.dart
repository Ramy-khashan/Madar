part of 'smart_assistant_chat_bloc.dart';

sealed class SmartAssistantChatEvent extends Equatable {
  const SmartAssistantChatEvent();

  @override
  List<Object> get props => [];
}

final class SmartAssistantChatLoad extends SmartAssistantChatEvent {
  const SmartAssistantChatLoad();
}

final class SmartAssistantChatSendMessage extends SmartAssistantChatEvent {
  const SmartAssistantChatSendMessage(this.text);

  final String text;

  @override
  List<Object> get props => [text];
}

final class SmartAssistantChatFeedback extends SmartAssistantChatEvent {
  const SmartAssistantChatFeedback({required this.isPositive});

  final bool isPositive;

  @override
  List<Object> get props => [isPositive];
}
