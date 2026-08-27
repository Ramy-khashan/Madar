import 'package:flutter/material.dart';

import '../../config/router/app_router_keys.dart';
import '../../config/theme/app_theme_colors.dart';
import '../utils/constants/app_colors.dart';
import '../utils/constants/app_images.dart';
import '../utils/functions/guest_mode.dart';
import '../utils/functions/router_handler.dart';
import 'image_item.dart';

class ChatbotItem extends StatelessWidget {
  const ChatbotItem({super.key});

  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      end: 10,
      bottom: 10,
      child: SafeArea(
        child: FloatingActionButton(
          key: const Key('chatbot_fab'),
          heroTag: null,
          onPressed: () {
            if (!GuestMode.requireAuth(
              context,
              prompt: GuestAuthPrompt.toast,
            )) {
              return;
            }
            RouterHandler.navigate(context, AppRouterKeys.smartAssistantChat);
          },
          backgroundColor: AppColors.primary300,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),

          child: ImageItem(
            AppImages.chatbotIcon,

            color: Theme.of(context).brightness == Brightness.light
                ? AppThemeColors.of(context).onPrimary
                : AppThemeColors.of(context).onPrimary.withValues(alpha: 0.8),
          ),
        ),
      ),
    );
  }
}
