import 'package:flutter/material.dart';

import '../../../config/router/app_router_keys.dart';
import '../../../core/repository/apis/chat_apis.dart';
import '../../../core/utils/constants/app_strings.dart';
import '../../../core/utils/functions/common_fun.dart';
import '../../../core/utils/functions/guest_mode.dart';
import '../../../core/utils/functions/router_handler.dart';
import 'conversation_detail/model/conversation_info.dart';

class ChatNavigator {
  ChatNavigator._();

  static Future<void> openPrivateChat(
    BuildContext context, {
    required String receiverId,
    required String participantName,
    String? participantAvatarUrl,
  }) async {
    if (!GuestMode.requireAuth(context, prompt: GuestAuthPrompt.toast)) {
      return;
    }
    if (receiverId.trim().isEmpty) {
      AppToast(AppStrings.somethingWentWrong, isError: true);
      return;
    }

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    final result = await ChatApis.createPrivateChat(receiverId.trim());

    if (!context.mounted) return;
    Navigator.of(context, rootNavigator: true).pop();

    await result.fold(
      (error) async {
        AppToast(error, isError: true);
      },
      (chat) async {
        await RouterHandler.navigate(
          context,
          AppRouterKeys.conversationDetail,
          extra: ConversationInfo(
            conversationId: chat.id,
            participantName: participantName.isEmpty
                ? chat.displayName
                : participantName,
            participantAvatarUrl: participantAvatarUrl ?? chat.otherUser?.image,
          ),
        );
      },
    );
  }
}
