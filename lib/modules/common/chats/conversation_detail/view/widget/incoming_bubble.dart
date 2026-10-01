part of '../conversation_detail_screen.dart';

class IncomingBubble extends StatelessWidget {
  const IncomingBubble({
    super.key,
    required this.message,
    required this.imageUrl,
  });

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
          child: ImageItem(
            imageUrl,
            width: 34.width,
            height: 34.width,
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(width: 8.width),
        Flexible(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 14.width,
              vertical: 10.height,
            ),
            constraints: BoxConstraints(maxWidth: context.screenWidth * .65),

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
                if (message.time.isNotEmpty) ...[
                  SizedBox(height: 4.height),
                  Text(
                    message.time,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(11),
                      color: const Color(0xFF8A94A6),
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
