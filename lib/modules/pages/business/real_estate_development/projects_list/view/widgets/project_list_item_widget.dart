import 'package:flutter/material.dart';
import '../../../../../../../core/components/image_item.dart';
 
import '../../../../../../../config/router/app_router_keys.dart';
import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/components/app_button.dart';
import '../../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../../core/utils/functions/router_handler.dart';
import '../../../../../../../core/utils/functions/translation.dart';
import '../../../../business_home/view/widget/business_portflio_property_item.dart';
import '../../../shared/models/real_estate_project_model.dart';
part 'property_development_status.dart';

class ProjectListItemWidget extends StatelessWidget {
  const ProjectListItemWidget({
    super.key,
    required this.project,
    required this.role,
  });

  final RealEstateProjectModel project;
  final String role;

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
                project.imageUrl,
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
                      project.name,
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
                            project.location,
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
              PropertyDevelopmentStatus(status: project.status),
            ],
          ),
          SizedBox(height: 12.height),
          PropertyInfo(
            info:
                '${AppStrings.occupancyRate}: ${project.completionPercentage.toInt()}%',
            icon: AppImages.occupancyIcon,
            colors: colors,
          ),
          PropertyInfo(
            info: '${AppStrings.lastUpdate}: ${project.lastUpdate}',
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
              extra: {'project': project, 'role': role},
            ),
          ),
        ],
      ),
    );
  }
}
