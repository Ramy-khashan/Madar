part of 'conversations_bloc.dart';

sealed class ConversationsEvent extends Equatable {
  const ConversationsEvent();

  @override
  List<Object> get props => [];
}

final class ConversationsLoad extends ConversationsEvent {
  const ConversationsLoad();
}

final class ConversationsSearchChanged extends ConversationsEvent {
  const ConversationsSearchChanged(this.query);

  final String query;

  @override
  List<Object> get props => [query];
}
