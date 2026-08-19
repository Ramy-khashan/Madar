import 'package:equatable/equatable.dart';

import '../../models/chat_models.dart';

class MessageModel extends Equatable {
  final String id;
  final String text;
  final bool isOutgoing;
  final String time;

  const MessageModel({
    required this.id,
    required this.text,
    required this.isOutgoing,
    required this.time,
  });

  factory MessageModel.fromChatMessage(ChatMessageModel message) {
    return MessageModel(
      id: message.id,
      text: message.text,
      isOutgoing: message.isFromCurrentUser,
      time: ChatSession.formatBubbleTime(message.createdAt),
    );
  }

  @override
  List<Object?> get props => [id, text, isOutgoing, time];
}
