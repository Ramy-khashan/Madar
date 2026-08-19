import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/utils/constants/app_constant.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../controller/smart_assistant_chat_bloc.dart';
import 'widgets/ai_compose_item.dart';
import 'widgets/ai_typing_bubble.dart';
import 'widgets/feed_back_item.dart';
import 'widgets/messages_bubble_item.dart';

class SmartAssistantChatScreen extends StatelessWidget {
  const SmartAssistantChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppThemeColors.of(context).textPrimary.withValues(alpha: 0.05),

        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(
                  18.width,
                  12.height,
                  18.width,
                  16.height,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24.radius),
                    bottomRight: Radius.circular(24.radius),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10.height),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).maybePop(),
                          child: Icon(
                            Icons.chevron_left_rounded,
                            size: 30.fontSize,
                            color: AppThemeColors.of(context).textPrimary,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            AppStrings.smartAssistant,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppThemeColors.of(context).textFieldTitle,
                              fontSize: context.responsiveFontScale(20),
                              fontWeight: FontWeight.w600,
                              fontFamily: AppConstant.appHeaderFont,
                            ),
                          ),
                        ),
                        SizedBox(width: 30.width),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child:
                    BlocBuilder<
                      SmartAssistantChatBloc,
                      SmartAssistantChatState
                    >(
                      builder: (context, state) {
                        if (state is! SmartAssistantChatLoaded) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final extra = (state.isSending ? 1 : 0) + 1;
                        return ListView.builder(
                          controller: SmartAssistantChatBloc.get(
                            context,
                          ).scrollController,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.width,
                            vertical: 16.height,
                          ),
                          itemCount: state.messages.length + extra,
                          itemBuilder: (context, i) {
                            if (i < state.messages.length) {
                              final msg = state.messages[i];
                              return Padding(
                                padding: EdgeInsets.only(bottom: 14.height),
                                child: msg.isUser
                                    ? UserBubble(message: msg)
                                    : BotBubble(message: msg),
                              );
                            }
                            if (state.isSending && i == state.messages.length) {
                              return const Padding(
                                padding: EdgeInsets.only(bottom: 14),
                                child: AiTypingBubble(),
                              );
                            }
                            return FeedbackRow(
                              isFeedbackGiven: state.isFeedbackGiven,
                              isFeedbackPositive: state.isFeedbackPositive,
                              onFeedback: (isPositive) =>
                                  SmartAssistantChatBloc.get(context).add(
                                    SmartAssistantChatFeedback(
                                      isPositive: isPositive,
                                    ),
                                  ),
                            );
                          },
                        );
                      },
                    ),
              ),
              const AiComposeBar(),
            ],
          ),
        ),
      ),
    );
  }
}
