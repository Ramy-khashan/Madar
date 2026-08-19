import 'dart:async';
import 'dart:convert';

import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../connection/concept/end_points.dart';
import '../../utils/constants/app_enums.dart';
import '../../utils/functions/handle_multi_callback.dart';
import '../../utils/functions/print_state.dart';
import '../../utils/functions/service_locator.dart';
import '../../../modules/common/chats/models/chat_models.dart';

class ChatSocketService {
  ChatSocketService._();

  static final ChatSocketService instance = ChatSocketService._();

  io.Socket? _socket;
  String? _openChatId;

  final _messagesController = StreamController<ChatMessageModel>.broadcast();
  final _typingController = StreamController<(String chatId, bool isTyping)>.broadcast();

  Stream<ChatMessageModel> get incomingMessages => _messagesController.stream;
  Stream<(String chatId, bool isTyping)> get typing => _typingController.stream;

  bool get isConnected => _socket?.connected ?? false;

  Future<void> connect() async {
    if (_socket?.connected == true) return;

    final token = await sl<HandleMultiCallLocal>().getLocalData(
      keyType: LocalEnumKey.accessToken,
    );
    if (token == null || token.isEmpty) return;

    _socket?.dispose();
    _socket = io.io(
      EndPoints.socketUrl,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .enableReconnection()
          .setAuth({'token': token, 'authorization': 'Bearer $token'})
          .setExtraHeaders({'Authorization': 'Bearer $token'})
          .build(),
    );

    _socket!
      ..onConnect((_) => printState('Chat socket connected'))
      ..onDisconnect((_) => printState('Chat socket disconnected'))
      ..onConnectError((e) => printState('Chat socket connect error: $e'))
      ..onError((e) => printState('Chat socket error: $e'));

    for (final event in [
      'new_message',
      'message',
      'receive_message',
      'chat_message',
      'send_message',
    ]) {
      _socket!.on(event, _onIncomingMessage);
    }

    _socket!.on('typing', (data) {
      final chatId = _readChatId(data);
      if (chatId != null) _typingController.add((chatId, true));
    });
    _socket!.on('stop_typing', (data) {
      final chatId = _readChatId(data);
      if (chatId != null) _typingController.add((chatId, false));
    });

    if (!(_socket!.connected)) {
      _socket!.connect();
    }
  }

  void openChat(String chatId) {
    if (chatId.isEmpty) return;
    _openChatId = chatId;
    _emit('open_chat', chatId);
  }

  void closeChat(String chatId) {
    if (chatId.isEmpty) return;
    _emit('close_chat', chatId);
    if (_openChatId == chatId) _openChatId = null;
  }

  void sendMessage({required String chatId, required String text}) {
    if (chatId.isEmpty || text.trim().isEmpty) return;
    _emit('send_message', {'chatId': chatId, 'text': text.trim()});
  }

  void startTyping(String chatId) {
    if (chatId.isEmpty) return;
    _emit('typing', {'chatId': chatId});
  }

  void stopTyping(String chatId) {
    if (chatId.isEmpty) return;
    _emit('stop_typing', {'chatId': chatId});
  }

  void _emit(String event, dynamic payload) {
    final socket = _socket;
    if (socket == null || !socket.connected) {
      printState('Chat socket emit skipped ($event): not connected');
      return;
    }
    socket.emit(event, payload);
  }

  void _onIncomingMessage(dynamic data) {
    final map = _asMap(data);
    if (map == null) return;
    final payload = map['data'] is Map
        ? Map<String, dynamic>.from(map['data'] as Map)
        : map;
    final message = ChatMessageModel.fromJson(payload);
    if (message.id.isEmpty && message.text.isEmpty) return;
    _messagesController.add(message);
  }

  Map<String, dynamic>? _asMap(dynamic data) {
    if (data is Map) return Map<String, dynamic>.from(data);
    if (data is String) {
      try {
        final decoded = jsonDecode(data);
        if (decoded is Map) return Map<String, dynamic>.from(decoded);
      } catch (_) {}
    }
    return null;
  }

  String? _readChatId(dynamic data) {
    if (data is String && data.isNotEmpty) return data;
    final map = _asMap(data);
    final id = (map?['chatId'] ?? map?['id'])?.toString();
    if (id != null && id.isNotEmpty) return id;
    return null;
  }

  Future<void> disconnect() async {
    if (_openChatId != null) {
      closeChat(_openChatId!);
    }
    _socket?.dispose();
    _socket = null;
  }
}
