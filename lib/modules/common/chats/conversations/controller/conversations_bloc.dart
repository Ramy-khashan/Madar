import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
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

  static List<ConversationModel> get _mockConversations => [
    ConversationModel(
      id: '1',
      title: 'مكتب الرياض العقاري',
      subtitle: 'شكراً لك، سنتواصل معك قريباً بخصوص العقار',
      time: '2 min ago',
      initial: 'م',
      unreadCount: 3,
      imageUrl: 'https://example.com/avatar1.png',
      isOnline: true,
    ),
    ConversationModel(
      id: '2',
      title: 'شركة الأندلس العقارية',
      subtitle: 'شكراً لك، سنتواصل معك قريباً بخصوص العقار',
      time: AppStrings.timeYesterday,
      initial: 'ش',
      imageUrl: 'https://example.com/avatar2.png',
      isOnline: false,
    ),
    ConversationModel(
      id: '3',
      title: 'مكتب النخبة للعقارات',
      subtitle: 'سيتم التواصل معك خلال 24 ساعة',
      time: AppStrings.timeMonday,
      initial: 'ن',
      imageUrl: 'https://example.com/avatar3.png',
      isOnline: true,
    ),
  ];

  Future<void> _onLoad(
    ConversationsLoad event,
    Emitter<ConversationsState> emit,
  ) async {
    emit(state.copyWith(loadingConversationsStatus: RequestStatus.loading));
     emit(
      state.copyWith(
        conversations: _mockConversations,
        loadingConversationsStatus: RequestStatus.success,
      ),
    );
  }

  Future<void> _onSearchChanged(
    ConversationsSearchChanged event,
    Emitter<ConversationsState> emit,
  ) async {
    emit(state.copyWith(searchQuery: event.query));
  }
}
