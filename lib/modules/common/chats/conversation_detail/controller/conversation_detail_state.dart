part of 'conversation_detail_bloc.dart';

class ConversationDetailState extends Equatable {
  const ConversationDetailState({this.messages = const [], this.loadingMessagesStatus = RequestStatus.init});

  final List<MessageModel> messages;
  final RequestStatus loadingMessagesStatus;
  ConversationDetailState copyWith({
    List<MessageModel>? messages,
    RequestStatus? loadingMessagesStatus,
  }) {
    return ConversationDetailState(
      messages: messages ?? this.messages,
      loadingMessagesStatus: loadingMessagesStatus ?? this.loadingMessagesStatus,
    );
  }
  @override
  List<Object> get props => [messages, loadingMessagesStatus];
}
