import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_textfield.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/smart_assistant_chat_bloc.dart';

class AiComposeBar extends StatelessWidget {
  const AiComposeBar({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = SmartAssistantChatBloc.get(context);
    final colors = AppThemeColors.of(context);
    return Row(
      children: [
      
        Expanded(
          child: Container(
            margin: EdgeInsets.fromLTRB(12.width, 0, 12.width,0),
            padding: EdgeInsets.symmetric(horizontal: 10.width, vertical: 8.height),
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
                    textAlign: TextAlign.end,
          
                    // bloc.add(SmartAssistantChatSendMessage(text)),
                  ),
                ),
                SizedBox(width: 12.width),

                   IconButton(
                  onPressed: () => bloc.add(
                    SmartAssistantChatSendMessage(bloc.messageController.text),
                  ),
                  icon: Icon(
                    Icons.mic_none_rounded,
                    color: colors.primaryBrand,
                    size: 30.fontSize,
                  ),
                ),
              ],
            ),
          ),
        ),
          Container(
     width: 55.width,
          height: 55.width,
          padding: EdgeInsets.all(12.width),
          margin: EdgeInsetsDirectional.only(end: 12.width,),
          decoration: BoxDecoration(
            color: colors.primaryBrand,
            borderRadius: BorderRadius.circular(100.radius),
          ),
          child:   ImageItem(
            AppImages.sendIcon,
          ),
        ),
      ],
    );
  }
}
