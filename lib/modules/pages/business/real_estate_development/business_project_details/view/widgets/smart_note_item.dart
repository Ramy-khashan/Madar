import 'package:flutter/material.dart';
import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/components/image_item.dart';
import '../../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../../core/utils/functions/responsive.dart';

class SmartNoteItem extends StatelessWidget {
  const SmartNoteItem({
    super.key,
    required this.note,
    required this.isPdfNote,
    required this.colors,
  });

  final String note;
  final bool isPdfNote;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.height),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: isPdfNote ? null : 15.width,
            backgroundColor: isPdfNote
                ? AppColors.transparent
                : colors.primaryBrand.withValues(alpha: 0.1),
            child: Padding(
              padding: isPdfNote ? EdgeInsets.zero : EdgeInsets.all(5.height),
              child: ImageItem(
                isPdfNote ? AppImages.attachmentIcon : AppImages.doneIcon,
                color: isPdfNote ? colors.textFieldTitle : colors.primaryBrand,
              ),
            ),
          ),
          SizedBox(width: 8.width),
          Expanded(
            child: Text(
              note,
              style: TextStyle(
                fontSize: context.responsiveFontScale(16),
                color: colors.textFieldTitle,
                fontFamily: AppConstant.appFont,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
