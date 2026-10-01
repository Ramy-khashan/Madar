import 'package:flutter/material.dart';
import '../utils/constants/app_images.dart';
import '../utils/constants/app_strings.dart';
import '../utils/functions/responsive.dart';
import 'app_button.dart';

class PropertyCardChatFooter extends StatelessWidget {
  const PropertyCardChatFooter({super.key, this.onChat});

  final VoidCallback? onChat;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12.height),
      child: AppButton(
        onTap: onChat,
        childText: AppStrings.conversation,
        childImage: AppImages.chatIcon,
        height: 44,
        textSize: 15,
      ),
    );
  }
}
