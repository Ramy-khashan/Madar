part of 'smart_assistant_chat_bloc.dart';

sealed class SmartAssistantChatState extends Equatable {
  const SmartAssistantChatState();

  @override
  List<Object> get props => [];
}

final class SmartAssistantChatInitial extends SmartAssistantChatState {}

final class SmartAssistantChatLoaded extends SmartAssistantChatState {
  const SmartAssistantChatLoaded({
    required this.messages,
    this.isFeedbackGiven = false,
    this.isFeedbackPositive = false,
  });

  final List<AiMessageModel> messages;
  final bool isFeedbackGiven;
  final bool isFeedbackPositive;

  SmartAssistantChatLoaded copyWith({
    List<AiMessageModel>? messages,
    bool? isFeedbackGiven,
    bool? isFeedbackPositive,
  }) {
    return SmartAssistantChatLoaded(
      messages: messages ?? this.messages,
      isFeedbackGiven: isFeedbackGiven ?? this.isFeedbackGiven,
      isFeedbackPositive: isFeedbackPositive ?? this.isFeedbackPositive,
    );
  }

  @override
  List<Object> get props => [messages, isFeedbackGiven, isFeedbackPositive];
}
