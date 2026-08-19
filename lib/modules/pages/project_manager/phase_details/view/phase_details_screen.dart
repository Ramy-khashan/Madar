import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madar_app/core/utils/functions/translation.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/app_appbar.dart';
import '../../../../../core/components/app_textfield.dart';
import '../../../../../core/utils/constants/app_colors.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/common_fun.dart';
import '../../../../../core/utils/functions/image_picker_helper.dart';
import '../../../../../core/utils/functions/print_state.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../../../../../core/utils/functions/router_handler.dart';
import '../../../business/real_estate_development/add_project/shared/widgets/file_upload_widget.dart';
import '../../../business/real_estate_development/business_project_details/model/real_state_project_model.dart';
import '../../project_details/view/widgets/project_status_badge.dart';
import '../controller/phase_details_bloc.dart';
import 'widgets/approve_button_item.dart';
import 'widgets/image_upload_handle.dart';
import 'widgets/task_row_item.dart';

class PhaseDetailsScreen extends StatelessWidget {
  const PhaseDetailsScreen({
    super.key,
    required this.phase,
    required this.timeline,
    required this.projectId,
  });
  final ProjectStages phase;
  final List<Timeline> timeline;
  final String projectId;

  @override
  Widget build(BuildContext context) {
    printState('PhaseDetailsScreen build called $projectId');
    final tc = AppThemeColors.of(context);
    return Scaffold(
      backgroundColor: tc.backgroundPrimary,
      appBar: AppAppbar(title: AppStrings.projectPhasesSection),
      body: SafeArea(
        child: BlocConsumer<PhaseDetailsBloc, PhaseDetailsState>(
          listener: (context, state) {
            if (state.loadingStatus == RequestStatus.success) {
              AppToast(AppStrings.phaseApproved);

              Future.delayed(const Duration(milliseconds: 500), () {
                if (context.mounted) RouterHandler.pop(context, true);
              });
            }
          },
          builder: (context, state) {
            final phase = state.phase;
            printState('Phase ID: ${phase.id ??= this.phase.id}');
            printState('Phase state id : ${phase.id}');
            printState('Phase class id : ${this.phase.id}');
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
                                phase.stageName ?? 'Phase Name',
                                style: TextStyle(
                                  fontSize: context.responsiveFontScale(20),
                                  fontWeight: FontWeight.w800,
                                  color: tc.textPrimary,
                                ),
                              ),
                            ),
                            ProjectStatusBadge(
                              status: phase.progress == 100
                                  ? AppStrings.completed
                                  : 'in_progress'.trans,
                            ),
                          ],
                        ),
                        SizedBox(height: 12.height),

                        LinearProgressIndicator(
                          value: phase.progress != null
                              ? double.parse(phase.progress.toString()) / 100
                              : 0,

                          backgroundColor: tc.borderColor,
                          color: AppColors.lightSuccessColor,
                        ),
                        SizedBox(height: 6.height),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppStrings.progress,
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(12),
                                fontWeight: FontWeight.w600,
                                color: tc.textPrimary,
                              ),
                            ),
                            Text(
                              '${phase.progress ?? 0}%',
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(10),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
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
                              ...(phase.subStages ?? []).asMap().entries.map((
                                e,
                              ) {
                                final isLast =
                                    e.key == (phase.subStages?.length ?? 0) - 1;
                                return TaskRowItem(
                                  task: e.value,
                                  isLast: isLast,
                                  tc: tc,
                                );
                              }),

                              // Divider(color: tc.borderColor, height: 10),
                              // Padding(
                              //   padding: EdgeInsets.fromLTRB(
                              //     12.width,
                              //     0,
                              //     12.width,
                              //     12.height,
                              //   ),
                              //   child: AppTextField(
                              //     title: AppStrings.other,
                              //     isWithTitle: true,
                              //     controller: bloc.customTaskController,
                              //     hint: AppStrings.otherHint,
                              //     onChanged: (v) =>
                              //         bloc.add(UpdateCustomTaskEvent(v)),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.height),

                        ImagesSection(timeline: timeline, tc: tc, bloc: bloc),
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
                ApproveButtonItem(state: state, tc: tc, projectId: projectId),
              ],
            );
          },
        ),
      ),
    );
  }
}
