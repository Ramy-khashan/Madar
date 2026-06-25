import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/constants/app_enums.dart';
import '../model/message_model.dart';

part 'conversation_detail_event.dart';
part 'conversation_detail_state.dart';

class ConversationDetailBloc
    extends Bloc<ConversationDetailEvent, ConversationDetailState> {
  ConversationDetailBloc() : super(const ConversationDetailState()) {
    on<ConversationDetailLoad>(_onLoad);
    on<ConversationDetailSendMessage>(_onSendMessage);
  }

  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

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

  static const List<MessageModel> _mockMessages = [
    MessageModel(
      id: '1',
      text: 'السلام عليكم ممكن اسالك ع عقار',
      isOutgoing: false,
      time: '10:22 ص',
    ),
    MessageModel(
      id: '2',
      text: 'اتفضل حضرتك ؟',
      isOutgoing: true,
      time: '10:24 ص',
    ),
    MessageModel(
      id: '3',
      text: 'أريد الاستفسار عن شقة في حي الملقا',
      isOutgoing: false,
      time: '10:25 ص',
    ),
    MessageModel(
      id: '4',
      text: 'بكل سرور، لدينا عدة وحدات متاحة هناك. هل تفضل غرفتين أم ثلاث؟',
      isOutgoing: true,
      time: '10:26 ص',
    ),
  ];

  Future<void> _onLoad(
    ConversationDetailLoad event,
    Emitter<ConversationDetailState> emit,
  ) async {
    emit(state.copyWith(loadingMessagesStatus: RequestStatus.loading));
     emit(state.copyWith(
      messages: _mockMessages,
      loadingMessagesStatus: RequestStatus.success,
    ));
    scrollToBottom();
  }

  Future<void> _onSendMessage(
    ConversationDetailSendMessage event,
    Emitter<ConversationDetailState> emit,
  ) async {
    if (state.loadingMessagesStatus != RequestStatus.success || event.text.trim().isEmpty) return;
    final current = state.messages;
    final now = DateTime.now();
    final newMsg = MessageModel(
      id: now.millisecondsSinceEpoch.toString(),
      text: event.text,
      isOutgoing: true,
      time: '${now.hour}:${now.minute.toString().padLeft(2, '0')}',
    );
    messageController.clear();
    emit(state.copyWith(messages: [...current, newMsg]));
    scrollToBottom();
  }

  @override
  Future<void> close() {
    messageController.dispose();
    scrollController.dispose();
    return super.close();
  }
}
