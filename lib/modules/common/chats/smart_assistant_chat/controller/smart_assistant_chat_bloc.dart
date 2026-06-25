import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  static const _welcome = AiMessageModel(
    id: 'welcome',
    text:
        'مرحباً، أنا مساعد مدار الذكي. يمكنني مساعدتك في أي استفسار عقاري وفقاً للوائح هيئة العقار السعودية. كيف يمكنني مساعدتك اليوم؟',
    isUser: false,
  );

  Future<void> _onLoad(
    SmartAssistantChatLoad event,
    Emitter<SmartAssistantChatState> emit,
  ) async {
    emit(const SmartAssistantChatLoaded(messages: [_welcome]));
  }

  Future<void> _onSendMessage(
    SmartAssistantChatSendMessage event,
    Emitter<SmartAssistantChatState> emit,
  ) async {
    if (state is! SmartAssistantChatLoaded || event.text.trim().isEmpty) return;
    final current = state as SmartAssistantChatLoaded;
    final userMsg = AiMessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: event.text,
      isUser: true,
    );
    messageController.clear();
    emit(current.copyWith(messages: [...current.messages, userMsg]));
    scrollToBottom();
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
