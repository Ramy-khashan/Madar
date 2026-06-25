part of 'conversation_detail_bloc.dart';

sealed class ConversationDetailEvent extends Equatable {
  const ConversationDetailEvent();

  @override
  List<Object> get props => [];
}

final class ConversationDetailLoad extends ConversationDetailEvent {
  const ConversationDetailLoad({required this.conversationId});

  final String conversationId;

  @override
  List<Object> get props => [conversationId];
}

final class ConversationDetailSendMessage extends ConversationDetailEvent {
  const ConversationDetailSendMessage(this.text);

  final String text;

  @override
  List<Object> get props => [text];
}
