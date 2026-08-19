import 'package:equatable/equatable.dart';

import '../../models/chat_models.dart';

class ConversationModel extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String time;
  final String initial;
  final String imageUrl;
  final int unreadCount;
  final bool isOnline;
  final bool isAiChat;

  const ConversationModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.initial,
    required this.imageUrl,
    this.unreadCount = 0,
    this.isOnline = false,
    this.isAiChat = false,
  });

  factory ConversationModel.fromChat(ChatModel chat) {
    final title = chat.displayName;
    final last = chat.lastMessage;
    return ConversationModel(
      id: chat.id,
      title: title,
      subtitle: last?.text ?? '',
      time: ChatSession.formatListTime(last?.createdAt ?? chat.createdAt),
      initial: title.isNotEmpty ? title.substring(0, 1) : '',
      imageUrl: chat.otherUser?.image ?? '',
      unreadCount: chat.unreadCount,
      isAiChat: chat.isAiChat,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    subtitle,
    time,
    initial,
    unreadCount,
    isOnline,
    imageUrl,
    isAiChat,
  ];
}
