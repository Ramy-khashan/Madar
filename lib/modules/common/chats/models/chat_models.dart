import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/constants/app_strings.dart';
import '../../../../core/utils/constants/storage_keys.dart';
import '../../../../core/utils/functions/preference_utils.dart';
import '../../../../core/utils/functions/service_locator.dart';

class ChatUserModel extends Equatable {
  const ChatUserModel({
    required this.userId,
    required this.fullName,
    this.role,
    this.image,
  });

  final String userId;
  final String fullName;
  final String? role;
  final String? image;

  bool get isAiAssistant =>
      (role ?? '').toUpperCase() == 'AI_ASSISTANT';

  factory ChatUserModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const ChatUserModel(userId: '', fullName: '');
    }
    return ChatUserModel(
      userId: (json['user_id'] ?? json['userId'] ?? json['id'] ?? '')
          .toString(),
      fullName: (json['fullName'] ?? json['name'] ?? '').toString(),
      role: json['role']?.toString(),
      image: json['image']?.toString(),
    );
  }

  @override
  List<Object?> get props => [userId, fullName, role, image];
}

class ChatMemberModel extends Equatable {
  const ChatMemberModel({
    required this.id,
    required this.userId,
    required this.chatId,
    required this.user,
  });

  final String id;
  final String userId;
  final String chatId;
  final ChatUserModel user;

  factory ChatMemberModel.fromJson(Map<String, dynamic> json) {
    return ChatMemberModel(
      id: (json['id'] ?? '').toString(),
      userId: (json['userId'] ?? json['user_id'] ?? '').toString(),
      chatId: (json['chatId'] ?? '').toString(),
      user: ChatUserModel.fromJson(
        json['user'] is Map<String, dynamic>
            ? json['user'] as Map<String, dynamic>
            : json,
      ),
    );
  }

  @override
  List<Object?> get props => [id, userId, chatId, user];
}

class ChatMessageModel extends Equatable {
  const ChatMessageModel({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.text,
    this.createdAt,
    this.sender,
  });

  final String id;
  final String chatId;
  final String senderId;
  final String text;
  final DateTime? createdAt;
  final ChatUserModel? sender;

  bool isOutgoing({String? aiUserId}) {
    if (aiUserId != null && aiUserId.isNotEmpty) {
      return senderId != aiUserId;
    }
    final currentId = ChatSession.currentUserId;
    if (currentId.isNotEmpty) return senderId == currentId;
    return sender?.isAiAssistant != true;
  }

  bool get isFromCurrentUser => isOutgoing();

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: (json['id'] ?? json['messageId'] ?? '').toString(),
      chatId: (json['chatId'] ?? '').toString(),
      senderId: (json['senderId'] ?? json['sender_id'] ?? '').toString(),
      text: (json['text'] ?? json['reply'] ?? '').toString(),
      createdAt: DateTime.tryParse(
        (json['createdAt'] ?? json['updatedAt'] ?? '').toString(),
      )?.toLocal(),
      sender: json['sender'] is Map<String, dynamic>
          ? ChatUserModel.fromJson(json['sender'] as Map<String, dynamic>)
          : null,
    );
  }

  @override
  List<Object?> get props => [id, chatId, senderId, text, createdAt, sender];
}

class ChatModel extends Equatable {
  const ChatModel({
    required this.id,
    this.isGroup = false,
    this.name,
    this.createdAt,
    this.users = const [],
    this.messages = const [],
    this.unreadCount = 0,
  });

  final String id;
  final bool isGroup;
  final String? name;
  final DateTime? createdAt;
  final List<ChatMemberModel> users;
  final List<ChatMessageModel> messages;
  final int unreadCount;

  ChatUserModel? get otherUser {
    final currentId = ChatSession.currentUserId;
    ChatUserModel? fallback;
    for (final member in users) {
      final memberUserId = member.user.userId.isNotEmpty
          ? member.user.userId
          : member.userId;
      if (currentId.isNotEmpty && memberUserId != currentId) {
        return member.user;
      }
      if (member.user.isAiAssistant) return member.user;
      fallback = member.user;
    }
    return fallback;
  }

  bool get isAiChat => users.any((u) => u.user.isAiAssistant);

  String get displayName {
    if ((name ?? '').trim().isNotEmpty) return name!.trim();
    final other = otherUser;
    if (other != null && other.fullName.trim().isNotEmpty) {
      return other.fullName.trim();
    }
    return AppStrings.conversation;
  }

  ChatMessageModel? get lastMessage =>
      messages.isEmpty ? null : messages.last;

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    final usersJson = json['users'];
    final messagesJson = json['messages'];
    return ChatModel(
      id: (json['id'] ?? json['chatId'] ?? '').toString(),
      isGroup: json['isGroup'] == true,
      name: json['name']?.toString(),
      createdAt: DateTime.tryParse((json['createdAt'] ?? '').toString())
          ?.toLocal(),
      users: usersJson is List
          ? usersJson
                .whereType<Map>()
                .map(
                  (e) => ChatMemberModel.fromJson(Map<String, dynamic>.from(e)),
                )
                .toList()
          : const [],
      messages: messagesJson is List
          ? (messagesJson
                  .whereType<Map>()
                  .map(
                    (e) =>
                        ChatMessageModel.fromJson(Map<String, dynamic>.from(e)),
                  )
                  .toList()
                ..sort((a, b) {
                  final aDate = a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
                  final bDate = b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
                  return aDate.compareTo(bDate);
                }))
          : const [],
      unreadCount: (json['unreadCount'] as num?)?.toInt() ?? 0,
    );
  }

  @override
  List<Object?> get props => [
    id,
    isGroup,
    name,
    createdAt,
    users,
    messages,
    unreadCount,
  ];
}

class AiChatReplyModel {
  const AiChatReplyModel({
    required this.chatId,
    required this.reply,
    required this.messageId,
  });

  final String chatId;
  final String reply;
  final String messageId;

  factory AiChatReplyModel.fromJson(Map<String, dynamic> json) {
    return AiChatReplyModel(
      chatId: (json['chatId'] ?? '').toString(),
      reply: (json['reply'] ?? '').toString(),
      messageId: (json['messageId'] ?? '').toString(),
    );
  }
}

class ChatSession {
  ChatSession._();

  static String get currentUserId =>
      sl.get<PreferenceUtils>().getString(StorageKeys.userID);

  static void rememberFromChats(List<ChatModel> chats) {
    if (currentUserId.isNotEmpty || chats.isEmpty) return;
    Set<String>? shared;
    for (final chat in chats) {
      final ids = chat.users
          .map(
            (m) => m.user.userId.isNotEmpty ? m.user.userId : m.userId,
          )
          .where((id) => id.isNotEmpty)
          .toSet();
      if (ids.isEmpty) continue;
      shared = shared == null ? ids : shared.intersection(ids);
    }
    if (shared != null && shared.length == 1) {
      sl.get<PreferenceUtils>().setString(StorageKeys.userID, shared.first);
    }
  }

  static String formatListTime(DateTime? date) {
    if (date == null) return '';
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final day = DateTime(date.year, date.month, date.day);
    if (day == today) {
      return DateFormat('h:mm a').format(date);
    }
    if (day == today.subtract(const Duration(days: 1))) {
      return AppStrings.timeYesterday;
    }
    return DateFormat('d/M/yyyy').format(date);
  }

  static String formatBubbleTime(DateTime? date) {
    if (date == null) return '';
    return DateFormat('h:mm a').format(date);
  }
}
