import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class PropertyFileOverflowMenu extends StatelessWidget {
  const PropertyFileOverflowMenu({
    super.key,
    required this.showSend,
    required this.onSend,
    required this.onDelete,
    this.deleteLabel,
  });

  final bool showSend;
  final VoidCallback onSend;
  final VoidCallback onDelete;
  final String? deleteLabel;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      onSelected: (value) {
        if (value == 'send') {
          onSend();
        } else if (value == 'delete') {
          onDelete();
        }
      },
      itemBuilder: (_) => [
        if (showSend)
          PopupMenuItem(
            value: 'send',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.sendPropertyFileToBroker,
                  style: TextStyle(
                    color: colors.textFieldTitle,
                    fontFamily: AppConstant.appFont,
                    fontSize: context.responsiveFontScale(14),
                  ),
                ),
                SizedBox(width: 10.width),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16.width,
                  color: colors.textFieldTitle,
                ),
              ],
            ),
          ),
        PopupMenuItem(
          value: 'delete',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                deleteLabel ?? AppStrings.deleteProperty,
                style: TextStyle(
                  color: AppColors.errorColor,
                  fontFamily: AppConstant.appFont,
                  fontSize: context.responsiveFontScale(13),
                ),
              ),
              SizedBox(width: 8.width),
              const ImageItem(AppImages.deleteIcon, color: AppColors.errorColor),
            ],
          ),
        ),
      ],
    );
  }
}
