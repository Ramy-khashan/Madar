import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../model/conversation_info.dart';

class ConversationHeader extends StatelessWidget {
  const ConversationHeader({
    super.key,
    required this.conversation,
    required this.colors,
  });
  final ConversationInfo conversation;
  final AppThemeColors colors;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(4.width, 12.height, 16.width, 12.height),

      child: Column(
        children: [
          SizedBox(height: 8.height),
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).maybePop(),
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 30.fontSize,
                  color: colors.textPrimary,
                ),
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 46.width,
                    height: 46.width,
                    decoration: const BoxDecoration(
                      color: Color(0xFF3D63CB),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child:
                        conversation.participantAvatarUrl == null ||
                            conversation.participantAvatarUrl!.isEmpty
                        ? Text(
                            conversation.participantName.isNotEmpty
                                ? conversation.participantName[0]
                                : '',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: context.responsiveFontScale(18),
                              fontFamily: 'app-header-font',
                            ),
                          )
                        : ImageItem(
                            conversation.participantAvatarUrl!,
                            width: 46.width,
                            height: 46.width,
                            borderRadius: BorderRadius.circular(23.radius),
                            fit: BoxFit.fill,
                          ),
                  ),
                  if (true)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        width: 13.width,
                        height: 13.width,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2BE15D),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(width: 12.width),

              Text(
                conversation.participantName,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(14),
                  fontWeight: FontWeight.w500,
                  color: colors.textFieldTitle,
                  fontFamily: AppConstant.appHeaderFont,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.height),
          Divider(color: colors.borderColor, height: 1),
        ],
      ),
    );
  }
}
