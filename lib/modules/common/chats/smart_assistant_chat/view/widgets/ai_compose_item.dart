import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_textfield.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/smart_assistant_chat_bloc.dart';

class AiComposeBar extends StatelessWidget {
  const AiComposeBar({super.key});

  void _send(BuildContext context) {
    final bloc = SmartAssistantChatBloc.get(context);
    final state = bloc.state;
    if (state is SmartAssistantChatLoaded &&
        (state.isSending || state.isLoadingHistory)) {
      return;
    }
    final text = bloc.messageController.text.trim();
    if (text.isEmpty) return;
    bloc.add(SmartAssistantChatSendMessage(text));
  }

  @override
  Widget build(BuildContext context) {
    final bloc = SmartAssistantChatBloc.get(context);
    final colors = AppThemeColors.of(context);
    return BlocBuilder<SmartAssistantChatBloc, SmartAssistantChatState>(
      builder: (context, state) {
        final isSending =
            state is SmartAssistantChatLoaded && state.isSending;
        final isBusy =
            isSending ||
            (state is SmartAssistantChatLoaded && state.isLoadingHistory);
        return Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.fromLTRB(12.width, 0, 12.width, 0),
                padding: EdgeInsets.symmetric(
                  horizontal: 10.width,
                  vertical: 8.height,
                ),
                decoration: BoxDecoration(
                  color: colors.backgroundPrimary,
                  borderRadius: BorderRadius.circular(30.radius),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        isWithTitle: false,
                        borderColor: Colors.transparent,
                        fillColor: Colors.transparent,
                        controller: bloc.messageController,
                        textAlign: TextAlign.start,
                        enabled: !isBusy,
                        hint: AppStrings.typeYourMessage,
                        textInputAction: TextInputAction.send,
                        onSubmitted: (_) => _send(context),
                      ),
                    ),
                    SizedBox(width: 12.width),
                    // IconButton(
                    //   onPressed: isBusy ? null : () {},
                    //   icon: Icon(
                    //     Icons.mic_none_rounded,
                    //     color: colors.primaryBrand,
                    //     size: 30.fontSize,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: isBusy ? null : () => _send(context),
              child: Container(
                width: 55.width,
                height: 55.width,
                padding: EdgeInsets.all(12.width),
                margin: EdgeInsetsDirectional.only(end: 12.width),
                decoration: BoxDecoration(
                  color: isBusy
                      ? colors.primaryBrand.withValues(alpha: 0.5)
                      : colors.primaryBrand,
                  borderRadius: BorderRadius.circular(100.radius),
                ),
                child: isSending
                    ? Padding(
                        padding: EdgeInsets.all(4.width),
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const ImageItem(AppImages.sendIcon),
              ),
            ),
          ],
        );
      },
    );
  }
}
