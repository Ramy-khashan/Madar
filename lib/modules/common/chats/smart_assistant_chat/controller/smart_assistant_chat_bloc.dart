import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/repository/apis/chat_apis.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/common_fun.dart';
import '../model/ai_message_model.dart';

part 'smart_assistant_chat_event.dart';
part 'smart_assistant_chat_state.dart';

class SmartAssistantChatBloc
    extends Bloc<SmartAssistantChatEvent, SmartAssistantChatState> {
  SmartAssistantChatBloc() : super(SmartAssistantChatInitial()) {
    on<SmartAssistantChatLoad>(_onLoad);
    on<SmartAssistantChatSendMessage>(_onSendMessage);
    on<SmartAssistantChatFeedback>(_onFeedback);
  }

  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  static SmartAssistantChatBloc get(BuildContext context) =>
      BlocProvider.of<SmartAssistantChatBloc>(context);

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

  AiMessageModel get _welcome => AiMessageModel(
    id: 'welcome',
    text: AppStrings.smartAssistantWelcome,
    isUser: false,
  );

  Future<void> _onLoad(
    SmartAssistantChatLoad event,
    Emitter<SmartAssistantChatState> emit,
  ) async {
    emit(SmartAssistantChatLoaded(messages: [_welcome], isLoadingHistory: true));

    final result = await ChatApis.getMyChats();
    if (isClosed) return;

    result.fold(
      (_) {
        emit(SmartAssistantChatLoaded(messages: [_welcome]));
      },
      (chats) {
        final aiChat = chats.where((c) => c.isAiChat).firstOrNull;
        if (aiChat == null || aiChat.messages.isEmpty) {
          emit(
            SmartAssistantChatLoaded(
              messages: [_welcome],
              chatId: aiChat?.id,
            ),
          );
          return;
        }

        final aiUserId = aiChat.users
            .where((u) => u.user.isAiAssistant)
            .map((u) => u.user.userId.isNotEmpty ? u.user.userId : u.userId)
            .firstOrNull;
        emit(
          SmartAssistantChatLoaded(
            chatId: aiChat.id,
            messages: aiChat.messages
                .map(
                  (m) => AiMessageModel.fromChatMessage(m, aiUserId: aiUserId),
                )
                .toList(),
          ),
        );
        scrollToBottom();
      },
    );
  }

  Future<void> _onSendMessage(
    SmartAssistantChatSendMessage event,
    Emitter<SmartAssistantChatState> emit,
  ) async {
    if (state is! SmartAssistantChatLoaded) return;
    final current = state as SmartAssistantChatLoaded;
    final text = event.text.trim();
    if (text.isEmpty || current.isSending || current.isLoadingHistory) return;

    final userMsg = AiMessageModel(
      id: 'local-${DateTime.now().millisecondsSinceEpoch}',
      text: text,
      isUser: true,
    );
    messageController.clear();
    emit(
      current.copyWith(
        messages: [...current.messages, userMsg],
        isSending: true,
      ),
    );
    scrollToBottom();

    final result = await ChatApis.sendAiMessage(text);
    if (isClosed) return;

    result.fold(
      (error) {
        AppToast(error, isError: true);
        messageController.text = text;
        messageController.selection = TextSelection.collapsed(
          offset: text.length,
        );
        final messages = List<AiMessageModel>.from(
          (state as SmartAssistantChatLoaded).messages,
        )..removeWhere((m) => m.id == userMsg.id);
        emit(
          (state as SmartAssistantChatLoaded).copyWith(
            messages: messages,
            isSending: false,
          ),
        );
      },
      (reply) {
        final loaded = state as SmartAssistantChatLoaded;
        emit(
          loaded.copyWith(
            chatId: reply.chatId.isNotEmpty ? reply.chatId : loaded.chatId,
            isSending: false,
            messages: [
              ...loaded.messages,
              AiMessageModel(
                id: reply.messageId.isNotEmpty
                    ? reply.messageId
                    : 'ai-${DateTime.now().millisecondsSinceEpoch}',
                text: reply.reply,
                isUser: false,
              ),
            ],
          ),
        );
        scrollToBottom();
      },
    );
  }

  void _onFeedback(
    SmartAssistantChatFeedback event,
    Emitter<SmartAssistantChatState> emit,
  ) {
    if (state is SmartAssistantChatLoaded) {
      emit(
        (state as SmartAssistantChatLoaded).copyWith(
          isFeedbackGiven: true,
          isFeedbackPositive: event.isPositive,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    messageController.dispose();
    scrollController.dispose();
    return super.close();
  }
}
