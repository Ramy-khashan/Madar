import 'package:flutter/material.dart';
 
import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/components/app_button.dart';
import '../../../../../../../core/components/app_textfield.dart';
import '../../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../../core/utils/functions/router_handler.dart';
 
class AddTimelineDialog extends StatefulWidget {
  const AddTimelineDialog({super.key});

  @override
  State<AddTimelineDialog> createState() => _AddTimelineDialogState();
}

class _AddTimelineDialogState extends State<AddTimelineDialog> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_dateController.text.trim().isEmpty ||
        _descController.text.trim().isEmpty) {
      return;
    }

    // context.read<BusinessProjectDetailsBloc>().add(
    //       BusinessProjectDetailsAddTimeline(
    //         date: _dateController.text.trim(),
    //         description: _descController.text.trim(),
    //       ),
    //     );
    RouterHandler.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);

    return Dialog(
      backgroundColor: colors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.radius),
        side: BorderSide(color: colors.borderColor),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 20.width),
      child: Padding(
        padding: EdgeInsets.all(20.width),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppStrings.addTimelineDialogTitle,
               style: TextStyle(
                fontSize: context.responsiveFontScale(18),
                fontWeight: FontWeight.w700,
                fontFamily: AppConstant.appHeaderFont,
                color: colors.textFieldTitle,
              ),
            ),
            SizedBox(height: 4.height),
            Text(
              AppStrings.addTimelineDialogSubtitle,
               style: TextStyle(
                fontSize: context.responsiveFontScale(12),
                color: colors.textSecondary,
                fontFamily: AppConstant.appFont,
              ),
            ),
            AppTextField(
              title: AppStrings.dateLabel,
              hint: '2/8/2023',
              controller: _dateController,
              isReadOnly: true,
              suffixIconWidget: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: colors.textSecondary,
                size: 22.width,
              ),
              onTapField: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
                if (picked != null) {
                  _dateController.text =
                      '${picked.day}/${picked.month}/${picked.year}';
                }
              },
            ),
            SizedBox(height: 12.height),
            AppTextField(
              title: AppStrings.timelineUpdatesLabel,
              hint: AppStrings.timelineUpdatesHint,
              controller: _descController,
              maxLines: 4,
             ),
            SizedBox(height: 20.height),
            Row(
              children: [
                  Expanded(
                  child: AppButton(
                    text: AppStrings.doneUpdate,
                    height: 48,
                    textSize: 15,
                    onTap: _submit,
                  ),
                ),
               
                SizedBox(width: 12.width),
               Expanded(
                  child: AppButton(
                    text: AppStrings.cancel,
                    isOutline: true,
                    height: 48,
                    textSize: 15,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
