part of 'conversations_bloc.dart';

  class ConversationsState extends Equatable {
 
  const ConversationsState({
    this.conversations = const [],
    this.searchQuery = '',
    this.loadingConversationsStatus = RequestStatus.init,
    this.errorMsg = '',
  });
  final RequestStatus loadingConversationsStatus;
  final List<ConversationModel> conversations;
  final String searchQuery;
  final String errorMsg;

  List<ConversationModel> get filteredConversations {
    final query = searchQuery.trim().toLowerCase();
    if (query.isEmpty) return conversations;
    return conversations
        .where(
          (c) =>
              c.title.toLowerCase().contains(query) ||
              c.subtitle.toLowerCase().contains(query),
        )
        .toList();
  }

  ConversationsState copyWith({
    List<ConversationModel>? conversations,
    String? searchQuery,
    RequestStatus? loadingConversationsStatus,
    String? errorMsg,
  }) {
    return ConversationsState(
      conversations: conversations ?? this.conversations,
      searchQuery: searchQuery ?? this.searchQuery,
      loadingConversationsStatus:
          loadingConversationsStatus ?? this.loadingConversationsStatus,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }

  @override
  List<Object> get props => [
    conversations,
    searchQuery,
    loadingConversationsStatus,
    errorMsg,
  ];
}
