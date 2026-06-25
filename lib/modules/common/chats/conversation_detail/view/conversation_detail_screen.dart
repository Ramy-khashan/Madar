import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/image_item.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../controller/conversation_detail_bloc.dart';
import '../model/conversation_info.dart';
import '../model/message_model.dart';
import 'widget/chat_compose_bar_item.dart';
import 'widget/conversation_header.dart';

part 'widget/chat_body.dart';
class ConversationDetailScreen extends StatelessWidget {
  const ConversationDetailScreen({super.key, required this.conversation});

  final ConversationInfo conversation;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ConversationHeader(conversation: conversation, colors: colors),
            Expanded(
              child:
                  BlocBuilder<ConversationDetailBloc, ConversationDetailState>(
                    builder: (context, state) {
                      if (state.loadingMessagesStatus == RequestStatus.loading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state.loadingMessagesStatus == RequestStatus.success) {
                        return ChatMessageList(
                          messages: state.messages,
                          imageUrl: conversation.participantAvatarUrl ?? '',
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
            ),
            const ChatComposeBar(),
          ],
        ),
      ),
    );
  }
}
