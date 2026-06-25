import 'package:flutter/material.dart';
import '../../../../../../../core/components/outline_section.dart';
import '../../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/components/app_button.dart';
import '../../../../../../../core/components/image_item.dart';
import '../../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../../core/utils/functions/responsive.dart';

class ProjectAttachmentsSectionWidget extends StatelessWidget {
  const ProjectAttachmentsSectionWidget({
    super.key,
    required this.smartNotes,
    required this.isManager,
    this.attachmentUrl,
  });

  final List<String> smartNotes;
  final bool isManager;
  final String? attachmentUrl;

  static const List<bool> _noteHasPdf = [false, false, false, true];

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);

    return OutlinedSection(
    title:  AppStrings.attachmentsSection,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
         
          
          if (isManager) ...[
             _FilePickerRow(colors: colors),
            SizedBox(height: 16.height),
          ],
           Text(
            AppStrings.smartNotesLabel,
            style: TextStyle(
              fontSize: context.responsiveFontScale(16),
              fontWeight: FontWeight.w600,
              fontFamily: AppConstant.appHeaderFont,
              color: colors.textFieldTitle,
            ),
          ),
          SizedBox(height: 16.height),
          ...List.generate(smartNotes.length, (i) {
            final isPdf = i < _noteHasPdf.length && _noteHasPdf[i];
            return _SmartNoteItem(
              note: smartNotes[i],
              isPdfNote: isPdf,
              colors: colors,
            );
          }),
          SizedBox(height: 16.height),
          AppButton(
            text: AppStrings.downloadPdfReport,
            height: 46,
            textSize: 15,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _FilePickerRow extends StatelessWidget {
  const _FilePickerRow({required this.colors});

  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.width, vertical: 12.height),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.radius),
        border: Border.all(color: colors.borderColor, style: BorderStyle.solid),
      ),
      child: Row(
        children: [
         
          Expanded(
            child: Text(
              AppStrings.chooseFile,
              style: TextStyle(
                fontSize: context.responsiveFontScale(14),
                color: colors.textSecondary,
                fontFamily: AppConstant.appFont,
              ),
            ),
          ),
           ImageItem(
            AppImages.chooseDocumentIcon,
             color: colors.textSecondary,
          ),
         ],
      ),
    );
  }
}

class _SmartNoteItem extends StatelessWidget {
  const _SmartNoteItem({
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
            radius: isPdfNote?null: 15.width,
            backgroundColor: isPdfNote
                ? AppColors.transparent
                : colors.primaryBrand.withValues(alpha: 0.1),
            child: Padding(
              padding: isPdfNote
                  ? EdgeInsets.zero
                  : EdgeInsets.all( 5.height),
              child: ImageItem(
                isPdfNote
                    ? AppImages.attachmentIcon
                    : AppImages.doneIcon,
                 color:  isPdfNote ? colors.textFieldTitle : colors.primaryBrand,
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
