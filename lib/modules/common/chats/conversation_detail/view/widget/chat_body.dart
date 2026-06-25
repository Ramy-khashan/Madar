
part of '../conversation_detail_screen.dart';
class ChatMessageList extends StatelessWidget {
  const ChatMessageList({super.key, required this.messages, required this.imageUrl});

  final List<MessageModel> messages;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final bloc = ConversationDetailBloc.get(context);
    return ListView.builder(
      controller: bloc.scrollController,
      padding: EdgeInsets.symmetric(horizontal: 16.width, vertical: 16.height),
      itemCount: messages.length,
      itemBuilder: (context, i) {
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

class IncomingBubble extends StatelessWidget {
  const IncomingBubble({super.key, required this.message, required this.imageUrl});

  final MessageModel message;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 34.width,
          height: 34.width,

          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: const BoxDecoration(
            color: Color(0xFF3D63CB),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: ImageItem(imageUrl, width: 34.width, height: 34.width,fit: BoxFit.fill,),
        ),
        SizedBox(width: 8.width),
        Flexible(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 14.width,
              vertical: 10.height,
            ),
            constraints: BoxConstraints(maxWidth: context.screenWidth*.65),

            decoration: BoxDecoration(
              color: const Color(0xFFD2D8E7),
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(18.radius),
                topEnd: Radius.circular(18.radius),
                bottomEnd: Radius.circular(18.radius),
                bottomStart: Radius.circular(4.radius),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.text,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(15),
                    color: const Color(0xFF222831),
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 4.height),
                Text(
                  message.time,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(11),
                    color: const Color(0xFF8A94A6),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class OutgoingBubble extends StatelessWidget {
  const OutgoingBubble({super.key, required this.message});

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 14.width,
              vertical: 10.height,
            ),
            constraints: BoxConstraints(maxWidth: context.screenWidth*.65),
            decoration: BoxDecoration(
              color: AppThemeColors.of(context).primaryBrand,
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(18.radius),
                topEnd: Radius.circular(18.radius),
                bottomStart: Radius.circular(18.radius),
                bottomEnd: Radius.circular(4.radius),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.text,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(15),
                    color: Colors.white,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 4.height),
                Text(
                  message.time,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(11),
                    color: Colors.white.withValues(alpha: 0.75),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
