part of 'conversation_detail_bloc.dart';

class ConversationDetailState extends Equatable {
  const ConversationDetailState({
    this.messages = const [],
    this.loadingMessagesStatus = RequestStatus.init,
    this.isSending = false,
    this.isPeerTyping = false,
    this.errorMsg = '',
  });

  final List<MessageModel> messages;
  final RequestStatus loadingMessagesStatus;
  final bool isSending;
  final bool isPeerTyping;
  final String errorMsg;

  ConversationDetailState copyWith({
    List<MessageModel>? messages,
    RequestStatus? loadingMessagesStatus,
    bool? isSending,
    bool? isPeerTyping,
    String? errorMsg,
  }) {
    return ConversationDetailState(
      messages: messages ?? this.messages,
      loadingMessagesStatus:
          loadingMessagesStatus ?? this.loadingMessagesStatus,
      isSending: isSending ?? this.isSending,
      isPeerTyping: isPeerTyping ?? this.isPeerTyping,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }

  @override
  List<Object> get props => [
    messages,
    loadingMessagesStatus,
    isSending,
    isPeerTyping,
    errorMsg,
  ];
}
