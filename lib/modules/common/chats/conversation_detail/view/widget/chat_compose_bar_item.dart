import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_textfield.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/conversation_detail_bloc.dart';

class ChatComposeBar extends StatelessWidget {
  const ChatComposeBar({super.key});

  void _send(BuildContext context) {
    final bloc = ConversationDetailBloc.get(context);
    bloc.add(ConversationDetailSendMessage(bloc.messageController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.width, 0, 16.width, 14.height),

      child: BlocBuilder<ConversationDetailBloc, ConversationDetailState>(
        builder: (context, state) {
          return Row(
            children: [
              Expanded(
                child: AppTextField(
                  borderRadius: 12,
                  borderColor: Colors.transparent,
                  fillColor: AppThemeColors.of(
                    context,
                  ).textFieldHint.withValues(alpha: 0.2),
                  enabled: !state.isSending,
                  textInputAction: TextInputAction.send,
                  onChanged: (value) => ConversationDetailBloc.get(
                    context,
                  ).add(ConversationDetailLocalTyping(value)),
                  onSubmitted: (_) => _send(context),
                  suffixIconWidget: GestureDetector(
                    onTap: state.isSending ? null : () => _send(context),
                    child: Container(
                      margin: EdgeInsetsDirectional.only(
                        end: 5.width,
                        start: 1.width,
                      ),
                      width: 28.width,
                      height: 28.width,
                      padding: EdgeInsets.all(8.width),
                      decoration: BoxDecoration(
                        color: AppThemeColors.of(
                          context,
                        ).textPrimary.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: ImageItem(
                        AppImages.sendMsgIcon,
                        width: 12,
                        color: AppThemeColors.of(context).textPrimary,
                      ),
                    ),
                  ),
                  hint: AppStrings.typeYourMessage,
                  isWithTitle: false,
                  controller: ConversationDetailBloc.get(
                    context,
                  ).messageController,
                ),
              ),
              // SizedBox(width: 8.width),

              // IconButton(
              //   onPressed: () {},
              //   icon: ImageItem(AppImages.cameraIcon, width: 25.width),
              // ),
            ],
          );
        },
      ),
    );
  }
}
