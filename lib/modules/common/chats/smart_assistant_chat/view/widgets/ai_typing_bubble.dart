import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import 'typing_dot.dart';

class AiTypingBubble extends StatelessWidget {
  const AiTypingBubble({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.width,
              vertical: 12.height,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(20.radius),
                bottomStart: Radius.circular(20.radius),
                bottomEnd: Radius.circular(20.radius),
                topEnd: Radius.circular(4.radius),
              ),
              color: AppThemeColors.of(
                context,
              ).primaryBrand.withValues(alpha: .1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (i) {
                return Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: i == 0 ? 0 : 4.width,
                  ),
                  child: TypingDot(delay: Duration(milliseconds: 180 * i)),
                );
              }),
            ),
          ),
        ),
        SizedBox(width: 8.width),
        Container(
          width: 38.width,
          height: 38.width,
          decoration: BoxDecoration(
            color: AppThemeColors.of(context).primaryBrand,
            shape: BoxShape.circle,
          ),
          padding: EdgeInsets.all(4.width),
          child: const ImageItem(AppImages.chatbotIcon),
        ),
      ],
    );
  }
}
