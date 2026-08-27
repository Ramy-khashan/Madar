import 'package:flutter/material.dart';

import '../../../../../../core/utils/functions/responsive.dart';
import '../../model/ai_message_model.dart';

class UserBubble extends StatelessWidget {
  const UserBubble({super.key, required this.message});

  final AiMessageModel message;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 38.width,
          height: 38.width,
          decoration: const BoxDecoration(
            color: Color(0xFFE3E3E3),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.person,
            color: const Color(0xFF607080),
            size: 22.fontSize,
          ),
        ),
        SizedBox(width: 8.width),
        Flexible(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.width,
              vertical: 12.height,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF3E62CB),
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(4.radius),
                topEnd: Radius.circular(20.radius),
                bottomStart: Radius.circular(20.radius),
                bottomEnd: Radius.circular(20.radius),
              ),
            ),
            child: Text(
              message.text,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: Colors.white,
                fontSize: context.responsiveFontScale(15),
                height: 1.4,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
