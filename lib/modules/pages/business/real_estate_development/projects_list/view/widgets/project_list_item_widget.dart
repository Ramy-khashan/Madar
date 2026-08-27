import 'package:flutter/material.dart';

import '../../../../../../../config/router/app_router_keys.dart';
import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/components/app_button.dart';
import '../../../../../../../core/components/image_item.dart';
import '../../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../../core/utils/functions/router_handler.dart';
import '../../../../../../../core/utils/functions/translation.dart';
import '../../../../business_properties/view/widgets/property_info.dart';
import '../../model/realstate_projects_model.dart';

part 'property_development_status.dart';

class ProjectListItemWidget extends StatelessWidget {
  const ProjectListItemWidget({super.key, this.project});

  final RealStateProjectsModel? project;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);

    return Container(
      padding: EdgeInsets.all(8.width),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(20.radius),
        border: Border.all(color: colors.borderColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              ImageItem(
                project?.attachments == null || project == null
                    ? ''
                    : project!.attachments!.isEmpty
                    ? ''
                    : project?.attachments?.first ?? '',
                width: 66.width,
                height: 58.height,
                borderRadius: BorderRadius.circular(24.radius),
              ),
              SizedBox(width: 12.width),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project?.name ?? 'Project Name',
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(16),
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
                        Expanded(
                          child: Text(
                            project?.location ?? 'Location',
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(14),
                              color: colors.textSecondary,
                              fontFamily: AppConstant.appFont,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              PropertyDevelopmentStatus(
                status: (project?.status ?? 'IN_PROGRESS').toLowerCase(),
              ),
            ],
          ),
          SizedBox(height: 12.height),
          PropertyInfo(
            info: '${AppStrings.occupancyRate}: ${project?.progress ?? 0}%',
            icon: AppImages.occupancyRateIcon,
            colors: colors,
          ),
          PropertyInfo(
            info: '${AppStrings.lastUpdate}: ${project?.lastUpdate ?? ''}',
            icon: AppImages.updateIcon,
            colors: colors,
          ),
          SizedBox(height: 16.height),
          AppButton(
            text: AppStrings.viewDetails,
            height: 46,
            textSize: 15,
            onTap: () => RouterHandler.navigate(
              context,
              AppRouterKeys.realEstateDevelopmentDetails,
              extra: {'projectId': project?.id ?? ''},
            ),
          ),
        ],
      ),
    );
  }
}
