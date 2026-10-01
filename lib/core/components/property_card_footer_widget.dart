import 'package:flutter/material.dart';
import '../utils/constants/app_images.dart';
import '../utils/constants/app_strings.dart';
import '../utils/functions/responsive.dart';
import 'app_button.dart';

class PropertyCardDualFooter extends StatelessWidget {
  const PropertyCardDualFooter({
    super.key,
    this.onSendRequest,
    this.onChat,
    this.isWithChatButton = true,
  });

  final VoidCallback? onSendRequest;
  final VoidCallback? onChat;
  final bool isWithChatButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12.height),
      child: Row(
        children: [
          Expanded(
            child: AppButton(
              key: const Key('property_card_send_request_btn'),
              onTap: onSendRequest,
              childText: AppStrings.sendRequest,
              height: 44,
              textSize: 14,
            ),
          ),
          if (isWithChatButton) ...[
            SizedBox(width: 8.width),
            Expanded(
              child: AppButton(
                key: const Key('property_card_chat_btn'),
                onTap: onChat,
                isOutline: true,
                childText: AppStrings.conversation,
                childImage: AppImages.chatIcon,
                height: 44,
                textSize: 14,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
