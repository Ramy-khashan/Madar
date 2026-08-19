part of 'conversation_detail_bloc.dart';

sealed class ConversationDetailEvent extends Equatable {
  const ConversationDetailEvent();

  @override
  List<Object?> get props => [];
}

final class ConversationDetailLoad extends ConversationDetailEvent {
  const ConversationDetailLoad({required this.conversationId});

  final String conversationId;

  @override
  List<Object?> get props => [conversationId];
}

final class ConversationDetailSendMessage extends ConversationDetailEvent {
  const ConversationDetailSendMessage(this.text);

  final String text;

  @override
  List<Object?> get props => [text];
}

final class ConversationDetailMessageReceived extends ConversationDetailEvent {
  const ConversationDetailMessageReceived(this.message);

  final ChatMessageModel message;

  @override
  List<Object?> get props => [message];
}

final class ConversationDetailPeerTyping extends ConversationDetailEvent {
  const ConversationDetailPeerTyping(this.isTyping);

  final bool isTyping;

  @override
  List<Object?> get props => [isTyping];
}

final class ConversationDetailLocalTyping extends ConversationDetailEvent {
  const ConversationDetailLocalTyping(this.text);

  final String text;

  @override
  List<Object?> get props => [text];
}
