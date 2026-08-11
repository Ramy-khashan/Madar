import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_images.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_appbar.dart';
import '../../../../../../core/components/failed_shape.dart';
import '../../../../../../core/components/loading_item.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../controller/business_project_details_bloc.dart';
import 'widgets/project_attachments_section_widget.dart';
import 'widgets/project_completion_chart_widget.dart';
import 'widgets/project_phases_section_widget.dart';
import 'widgets/project_stats_row_widget.dart';
import 'widgets/project_timeline_section_widget.dart';

class BusinessProjectDetailsScreen extends StatelessWidget {
  const BusinessProjectDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);

    return Scaffold(
      backgroundColor: colors.backgroundPrimary,
      appBar: AppAppbar(title: AppStrings.realEstateDevelopment),
      body:
          BlocBuilder<BusinessProjectDetailsBloc, BusinessProjectDetailsState>(
            builder: (context, state) {
              if (state.status == RequestStatus.loading ||
                  state.status == RequestStatus.init) {
                return const LoadingItem();
              }

              if (state.status == RequestStatus.failed ||
                  state.project == null) {
                return FailedShape(
                  msg: AppStrings.failedLoadProjectDetails,
                  onTapRefresh: () {
                    context.read<BusinessProjectDetailsBloc>().add(
                          BusinessProjectDetailsLoad(
                            projectId: state.projectId,
                          ),
                        );
                  },
                );
              }

              final p = state.project!;

              return SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.width,
                    vertical: 12.height,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        p.project?.name ?? 'Project Name',
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(18),
                          fontWeight: FontWeight.w700,
                          fontFamily: AppConstant.appHeaderFont,
                          color: colors.textFieldTitle,
                        ),
                      ),
                      SizedBox(height: 4.height),
                      Row(
                        children: [
                          ImageItem(
                            AppImages.locationIcon,
                            color: colors.textSecondary,
                          ),
                          SizedBox(width: 4.width),
                          Text(
                            p.project?.location ?? 'Location',
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(14),
                              color: colors.textSecondary,
                              fontFamily: AppConstant.appFont,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.height),
                      ProjectCompletionChartWidget(
                        percentage: double.parse(
                          p.project?.overallProgress.toString() ?? '0',
                        ),
                      ),
                      SizedBox(height: 14.height),
                      ProjectStatsRowWidget(
                        inProgressCount: p.stats?.inProgress ?? 0,
                        delayedCount: p.stats?.delayed ?? 0,
                      ),
                      SizedBox(height: 14.height),
                      ProjectTimelineSectionWidget(timeline: p.timeline ?? []),
                      SizedBox(height: 14.height),
                      ProjectPhasesSectionWidget(phases: p.stages ?? []),
                      SizedBox(height: 14.height),
                      ProjectAttachmentsSectionWidget(
                        smartNotes: [],
                        attachmentUrl: p.project?.attachments ?? [],
                      ),
                      SizedBox(height: 24.height),
                    ],
                  ),
                ),
              );
            },
          ),
    );
  }
}
