part of '../conversation_detail_screen.dart';

class ChatMessageList extends StatelessWidget {
  const ChatMessageList({
    super.key,
    required this.messages,
    required this.imageUrl,
    this.isPeerTyping = false,
  });

  final List<MessageModel> messages;
  final String imageUrl;
  final bool isPeerTyping;

  @override
  Widget build(BuildContext context) {
    final bloc = ConversationDetailBloc.get(context);
    final extra = isPeerTyping ? 1 : 0;
    return ListView.builder(
      controller: bloc.scrollController,
      padding: EdgeInsets.symmetric(horizontal: 16.width, vertical: 16.height),
      itemCount: messages.length + extra,
      itemBuilder: (context, i) {
        if (i >= messages.length) {
          return Padding(
            padding: EdgeInsets.only(bottom: 14.height),
            child: IncomingBubble(
              message: const MessageModel(
                id: 'typing',
                text: '...',
                isOutgoing: false,
                time: '',
              ),
              imageUrl: imageUrl,
            ),
          );
        }
        final msg = messages[i];
        return Padding(
          padding: EdgeInsets.only(bottom: 14.height),
          child: msg.isOutgoing
              ? OutgoingBubble(message: msg)
              : IncomingBubble(message: msg, imageUrl: imageUrl),
        );
      },
    );
  }
}
