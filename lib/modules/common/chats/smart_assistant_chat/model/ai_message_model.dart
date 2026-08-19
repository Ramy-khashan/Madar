import 'package:equatable/equatable.dart';

import '../../models/chat_models.dart';

class AiMessageModel extends Equatable {
  final String id;
  final String text;
  final bool isUser;

  const AiMessageModel({
    required this.id,
    required this.text,
    required this.isUser,
  });

  factory AiMessageModel.fromChatMessage(
    ChatMessageModel message, {
    String? aiUserId,
  }) {
    return AiMessageModel(
      id: message.id,
      text: message.text,
      isUser: message.isOutgoing(aiUserId: aiUserId),
    );
  }

  @override
  List<Object?> get props => [id, text, isUser];
}
