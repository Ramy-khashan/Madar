import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../business/real_estate_development/business_project_details/model/real_state_project_model.dart';
import '../../controller/phase_details_bloc.dart';

class TaskRowItem extends StatelessWidget {
  const TaskRowItem({
    super.key,
    required this.task,
    required this.isLast,
    required this.tc,
  });

  final SubStages task;
  final bool isLast;
  final AppThemeColors tc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhaseDetailsBloc, PhaseDetailsState>(
      builder: (context, state) {
        return Material(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              border: isLast
                  ? null
                  : Border(
                      bottom: BorderSide(
                        color: tc.borderColor,
                      ),
                    ),
            ),
            child: CheckboxListTile(
              value: state.selectedSubPhases.contains(task.id ?? ''),
              onChanged: (_) {
                print('Task ${task.id} progress: ${task.progress}');
                PhaseDetailsBloc.get(context)
                    .add(ToggleTaskEvent(task.id ?? ''));
              },
              title: Text(
                task.name ?? 'Task Name',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(13),
                  color: tc.textPrimary,
                ),
              ),
              activeColor: tc.primaryBrand,
              checkColor: tc.onPrimary,
              controlAffinity: ListTileControlAffinity.trailing,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12.width),
              dense: true,
            ),
          ),
        );
      },
    );
  }
}