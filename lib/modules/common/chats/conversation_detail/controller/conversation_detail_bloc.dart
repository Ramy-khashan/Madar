import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/repository/apis/chat_apis.dart';
import '../../../../../core/repository/socket/chat_socket_service.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/functions/common_fun.dart';
import '../../models/chat_models.dart';
import '../model/message_model.dart';

part 'conversation_detail_event.dart';
part 'conversation_detail_state.dart';

class ConversationDetailBloc
    extends Bloc<ConversationDetailEvent, ConversationDetailState> {
  ConversationDetailBloc() : super(const ConversationDetailState()) {
    on<ConversationDetailLoad>(_onLoad);
    on<ConversationDetailSendMessage>(_onSendMessage);
    on<ConversationDetailMessageReceived>(_onMessageReceived);
    on<ConversationDetailPeerTyping>(_onPeerTyping);
    on<ConversationDetailLocalTyping>(_onLocalTyping);
  }

  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  StreamSubscription<ChatMessageModel>? _messagesSub;
  StreamSubscription<(String chatId, bool isTyping)>? _typingSub;
  Timer? _stopTypingTimer;
  String _chatId = '';

  static ConversationDetailBloc get(BuildContext context) =>
      BlocProvider.of<ConversationDetailBloc>(context);

  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 120), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _onLoad(
    ConversationDetailLoad event,
    Emitter<ConversationDetailState> emit,
  ) async {
    _chatId = event.conversationId;
    emit(state.copyWith(loadingMessagesStatus: RequestStatus.loading));
    await ChatSocketService.instance.connect();
    ChatSocketService.instance.openChat(_chatId);
    _bindSocket();

    final result = await ChatApis.getMyChats();
    if (isClosed) return;
    result.fold(
      (error) {
        emit(
          state.copyWith(
            loadingMessagesStatus: RequestStatus.failed,
            errorMsg: error,
          ),
        );
      },
      (chats) {
        final chat = chats.where((c) => c.id == _chatId).firstOrNull;
        emit(
          state.copyWith(
            messages:
                chat?.messages.map(MessageModel.fromChatMessage).toList() ??
                const [],
            loadingMessagesStatus: RequestStatus.success,
          ),
        );
        scrollToBottom();
      },
    );
  }

  void _bindSocket() {
    _messagesSub?.cancel();
    _typingSub?.cancel();
    _messagesSub = ChatSocketService.instance.incomingMessages.listen((
      message,
    ) {
      if (message.chatId.isNotEmpty && message.chatId != _chatId) return;
      add(ConversationDetailMessageReceived(message));
    });
    _typingSub = ChatSocketService.instance.typing.listen((event) {
      if (event.$1 != _chatId) return;
      add(ConversationDetailPeerTyping(event.$2));
    });
  }

  Future<void> _onSendMessage(
    ConversationDetailSendMessage event,
    Emitter<ConversationDetailState> emit,
  ) async {
    if (state.loadingMessagesStatus != RequestStatus.success) return;
    final text = event.text.trim();
    if (text.isEmpty || state.isSending || _chatId.isEmpty) return;

    final localId = 'local-${DateTime.now().millisecondsSinceEpoch}';
    final localMsg = MessageModel(
      id: localId,
      text: text,
      isOutgoing: true,
      time: ChatSession.formatBubbleTime(DateTime.now()),
    );
    messageController.clear();
    ChatSocketService.instance.stopTyping(_chatId);
    emit(
      state.copyWith(
        messages: [...state.messages, localMsg],
        isSending: true,
        isPeerTyping: false,
      ),
    );
    scrollToBottom();

    ChatSocketService.instance.sendMessage(chatId: _chatId, text: text);
    final result = await ChatApis.sendMessage(chatId: _chatId, text: text);
    if (isClosed) return;

    result.fold(
      (error) {
        AppToast(error, isError: true);
        messageController.text = text;
        messageController.selection = TextSelection.collapsed(
          offset: text.length,
        );
        emit(
          state.copyWith(
            isSending: false,
            messages: state.messages.where((m) => m.id != localId).toList(),
          ),
        );
      },
      (message) {
        final mapped = MessageModel.fromChatMessage(message);
        emit(
          state.copyWith(
            isSending: false,
            messages: [
              for (final m in state.messages)
                if (m.id == localId) mapped else m,
            ],
          ),
        );
        scrollToBottom();
      },
    );
  }

  void _onMessageReceived(
    ConversationDetailMessageReceived event,
    Emitter<ConversationDetailState> emit,
  ) {
    final incoming = MessageModel.fromChatMessage(event.message);
    if (incoming.id.isNotEmpty &&
        state.messages.any((m) => m.id == incoming.id)) {
      return;
    }
    if (incoming.isOutgoing) {
      return;
    }
    emit(
      state.copyWith(
        messages: [...state.messages, incoming],
        isPeerTyping: false,
      ),
    );
    scrollToBottom();
  }

  void _onPeerTyping(
    ConversationDetailPeerTyping event,
    Emitter<ConversationDetailState> emit,
  ) {
    emit(state.copyWith(isPeerTyping: event.isTyping));
    if (event.isTyping) scrollToBottom();
  }

  void _onLocalTyping(
    ConversationDetailLocalTyping event,
    Emitter<ConversationDetailState> emit,
  ) {
    if (_chatId.isEmpty) return;
    if (event.text.trim().isEmpty) {
      ChatSocketService.instance.stopTyping(_chatId);
      _stopTypingTimer?.cancel();
      return;
    }
    ChatSocketService.instance.startTyping(_chatId);
    _stopTypingTimer?.cancel();
    _stopTypingTimer = Timer(const Duration(seconds: 2), () {
      ChatSocketService.instance.stopTyping(_chatId);
    });
  }

  @override
  Future<void> close() {
    ChatSocketService.instance.closeChat(_chatId);
    ChatSocketService.instance.stopTyping(_chatId);
    _stopTypingTimer?.cancel();
    _messagesSub?.cancel();
    _typingSub?.cancel();
    messageController.dispose();
    scrollController.dispose();
    return super.close();
  }
}
