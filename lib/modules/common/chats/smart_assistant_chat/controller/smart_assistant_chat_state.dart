part of 'smart_assistant_chat_bloc.dart';

sealed class SmartAssistantChatState extends Equatable {
  const SmartAssistantChatState();

  @override
  List<Object?> get props => [];
}

final class SmartAssistantChatInitial extends SmartAssistantChatState {}

final class SmartAssistantChatLoaded extends SmartAssistantChatState {
  const SmartAssistantChatLoaded({
    required this.messages,
    this.chatId,
    this.isSending = false,
    this.isLoadingHistory = false,
    this.isFeedbackGiven = false,
    this.isFeedbackPositive = false,
  });

  final List<AiMessageModel> messages;
  final String? chatId;
  final bool isSending;
  final bool isLoadingHistory;
  final bool isFeedbackGiven;
  final bool isFeedbackPositive;

  SmartAssistantChatLoaded copyWith({
    List<AiMessageModel>? messages,
    String? chatId,
    bool? isSending,
    bool? isLoadingHistory,
    bool? isFeedbackGiven,
    bool? isFeedbackPositive,
  }) {
    return SmartAssistantChatLoaded(
      messages: messages ?? this.messages,
      chatId: chatId ?? this.chatId,
      isSending: isSending ?? this.isSending,
      isLoadingHistory: isLoadingHistory ?? this.isLoadingHistory,
      isFeedbackGiven: isFeedbackGiven ?? this.isFeedbackGiven,
      isFeedbackPositive: isFeedbackPositive ?? this.isFeedbackPositive,
    );
  }

  @override
  List<Object?> get props => [
    messages,
    chatId,
    isSending,
    isLoadingHistory,
    isFeedbackGiven,
    isFeedbackPositive,
  ];
}
