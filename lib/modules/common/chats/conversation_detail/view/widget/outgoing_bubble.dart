part of '../conversation_detail_screen.dart';

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
            constraints: BoxConstraints(maxWidth: context.screenWidth * .65),
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
                if (message.time.isNotEmpty) ...[
                  SizedBox(height: 4.height),
                  Text(
                    message.time,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(11),
                      color: Colors.white.withValues(alpha: 0.75),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
