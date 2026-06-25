import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/app_appbar.dart';
import '../../../../../core/components/app_textfield.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../../model/project_model.dart';
import '../../project_details/view/widgets/project_status_badge.dart';
import '../controller/phase_details_bloc.dart';
import 'widgets/approve_button_item.dart';
import 'widgets/image_upload_handle.dart';
import 'widgets/task_row_item.dart';

class PhaseDetailsScreen extends StatelessWidget {
  const PhaseDetailsScreen({super.key, required this.phase});
  final PhaseModel phase;

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return Scaffold(
      backgroundColor: tc.backgroundPrimary,
      appBar: AppAppbar(title: AppStrings.projectPhasesSection),
      body: SafeArea(
        child: BlocBuilder<PhaseDetailsBloc, PhaseDetailsState>(
          builder: (context, state) {
            final phase = state.phase;
            final bloc = PhaseDetailsBloc.get(context);
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.width,
                      vertical: 12.height,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                phase.title,
                                style: TextStyle(
                                  fontSize: context.responsiveFontScale(20),
                                  fontWeight: FontWeight.w800,
                                  color: tc.textPrimary,
                                ),
                              ),
                            ),
                            ProjectStatusBadge(status: phase.status),
                          ],
                        ),
                        SizedBox(height: 6.height),
                        Text(
                          phase.description,
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(13),
                            color: tc.textSecondary,
                          ),
                        ),
                        SizedBox(height: 24.height),

                        Text(
                          AppStrings.tasks,
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(16),
                            fontWeight: FontWeight.w700,
                            color: tc.textPrimary,
                          ),
                        ),

                        SizedBox(height: 12.height),
                        Container(
                          decoration: BoxDecoration(
                            color: tc.cardBackground,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: tc.borderColor),
                          ),
                          child: Column(
                            children: [
                              ...phase.tasks.asMap().entries.map((e) {
                                final isLast =
                                    e.key == phase.tasks.length - 1 &&
                                    phase.customTask.isEmpty;
                                return TaskRowItem(
                                  task: e.value,
                                  isLast: isLast,
                                  tc: tc,
                                );
                              }),
                              Divider(color: tc.borderColor, height: 10),
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                  12.width,
                                  0,
                                  12.width,
                                  12.height,
                                ),
                                child: AppTextField(
                                  title: AppStrings.other,
                                  isWithTitle: true,
                                  controller: bloc.customTaskController,
                                  hint: AppStrings.otherHint,
                                  onChanged: (v) =>
                                      bloc.add(UpdateCustomTaskEvent(v)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.height),

                        ImagesSection(phase: phase, tc: tc, bloc: bloc),
                        SizedBox(height: 20.height),

                        AppTextField(
                          title: AppStrings.notes,
                          controller: bloc.noteController,
                          hint: AppStrings.notes,
                          maxLines: 4,
                          minLines: 3,
                          onChanged: (v) => bloc.add(UpdateNoteEvent(v)),
                        ),
                        SizedBox(height: 20.height),
                      ],
                    ),
                  ),
                ),
                ApproveButtonItem(state: state, tc: tc),
              ],
            );
          },
        ),
      ),
    );
  }
}
