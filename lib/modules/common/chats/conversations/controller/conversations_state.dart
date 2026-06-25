part of 'conversations_bloc.dart';

  class ConversationsState extends Equatable {
 
  const ConversationsState({
    this.conversations = const [],
    this.searchQuery = '',
    this.loadingConversationsStatus = RequestStatus.init,
  });
final RequestStatus loadingConversationsStatus;
  final List<ConversationModel> conversations;
  final String searchQuery;

 

  ConversationsState copyWith({
    List<ConversationModel>? conversations,
    String? searchQuery,
    RequestStatus? loadingConversationsStatus,
  }) {
    return ConversationsState(
      conversations: conversations ?? this.conversations,
      searchQuery: searchQuery ?? this.searchQuery,
      loadingConversationsStatus: loadingConversationsStatus ?? this.loadingConversationsStatus,
    );
  }

  @override
  List<Object> get props => [conversations, searchQuery, loadingConversationsStatus];
}
