
import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../model/project_model.dart';
import '../../controller/phase_details_bloc.dart';

class TaskRowItem extends StatelessWidget {
  const TaskRowItem({super.key, required this.task, required this.isLast, required this.tc});
  final TaskModel task;
  final bool isLast;
  final AppThemeColors tc;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(bottom: BorderSide(color: tc.borderColor)),
      ),
      child: CheckboxListTile(
        value: task.isCompleted,
        onChanged: (_) =>
            PhaseDetailsBloc.get(context).add(ToggleTaskEvent(task.id)),
        title: Text(
          task.label,
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: context.responsiveFontScale(13),
            color: tc.textPrimary,
            decorationColor: tc.textSecondary,
          ),
        ),
        activeColor: tc.primaryBrand,
        checkColor: tc.onPrimary,
        controlAffinity: ListTileControlAffinity.trailing,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.width, vertical: 0),
        dense: true,
      ),
    );
  }
}
