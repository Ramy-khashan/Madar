import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/repository/apis/chat_apis.dart';
import '../../../../../core/repository/socket/chat_socket_service.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../model/conversation_model.dart';

part 'conversations_event.dart';
part 'conversations_state.dart';

class ConversationsBloc extends Bloc<ConversationsEvent, ConversationsState> {
  ConversationsBloc() : super(const ConversationsState()) {
    on<ConversationsLoad>(_onLoad);
    on<ConversationsSearchChanged>(_onSearchChanged);
  }

  static ConversationsBloc get(BuildContext context) =>
      BlocProvider.of<ConversationsBloc>(context);

  Future<void> _onLoad(
    ConversationsLoad event,
    Emitter<ConversationsState> emit,
  ) async {
    emit(state.copyWith(loadingConversationsStatus: RequestStatus.loading));
    unawaited(ChatSocketService.instance.connect());

    final result = await ChatApis.getMyChats();
    result.fold(
      (error) {
        emit(
          state.copyWith(
            loadingConversationsStatus: RequestStatus.failed,
            errorMsg: error,
          ),
        );
      },
      (chats) {
        emit(
          state.copyWith(
            conversations: chats
                .where((chat) => !chat.isAiChat)
                .map<ConversationModel>(ConversationModel.fromChat)
                .toList(),
            loadingConversationsStatus: RequestStatus.success,
          ),
        );
      },
    );
  }

  Future<void> _onSearchChanged(
    ConversationsSearchChanged event,
    Emitter<ConversationsState> emit,
  ) async {
    emit(state.copyWith(searchQuery: event.query));
  }
}
