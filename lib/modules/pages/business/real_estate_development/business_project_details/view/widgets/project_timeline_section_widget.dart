import 'package:flutter/material.dart';
import '../../../../../../../core/components/outline_section.dart';
import '../../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/components/app_button.dart';
import '../../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../../shared/models/project_timeline_model.dart';
import '../../controller/business_project_details_bloc.dart';
import 'add_timeline_dialog.dart';
 import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectTimelineSectionWidget extends StatelessWidget {
  const ProjectTimelineSectionWidget({
    super.key,
    required this.timeline,
    required this.isManager,
  });

  final List<ProjectTimelineModel> timeline;
  final bool isManager;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);

    return OutlinedSection(
      title: AppStrings.timelineUpdatesSection,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (timeline.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.height),
              child: Text(
                AppStrings.noTimelineUpdates,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(13),
                  color: colors.textSecondary,
                  fontFamily: AppConstant.appFont,
                ),
              ),
            )
          else
            ...List.generate(timeline.length, (i) {
              final item = timeline[i];
              return _TimelineItem(index: i + 1, item: item, colors: colors);
            }),
          if (isManager) ...[
            SizedBox(height: 12.height),
            AppButton(
              text: AppStrings.addTimelineUpdate,
              height: 46,
              textSize: 15,
              onTap: () => showDialog<void>(
                context: context,
                builder: (_) => BlocProvider.value(
                  value: context.read<BusinessProjectDetailsBloc>(),
                  child: const AddTimelineDialog(),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({
    required this.index,
    required this.item,
    required this.colors,
  });

  final int index;
  final ProjectTimelineModel item;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.height),
      padding: EdgeInsets.symmetric(horizontal: 12.width, vertical: 8.height),
      decoration: BoxDecoration(
        color: colors.borderColor.withValues(alpha: 0.28),
        borderRadius: BorderRadius.circular(12.radius),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 12.width,
            backgroundColor: AppColors.secondBrand,

            child: Padding(
              padding:   EdgeInsets.only(top:2.height),
              child: Text(
                '$index',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(16),
                  fontWeight: FontWeight.w700,
                  color: colors.onPrimary,
                  fontFamily: AppConstant.appHeaderFont,
                ),
              ),
            ),
          ),
          SizedBox(width: 10.width),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.date,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(16),
                    fontWeight: FontWeight.w600,
                    fontFamily: AppConstant.appHeaderFont,
                    color: colors.primaryBrand,
                  ),
                ),
                SizedBox(height: 2.height),
                Text(
                  item.description,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(16),
                    color: colors.textSecondary,
                    fontFamily: AppConstant.appFont,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
