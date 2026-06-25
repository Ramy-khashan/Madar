import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../model/business_property_request_model.dart';

class BusinessPropertiesPublishedCardWidget extends StatelessWidget {
  const BusinessPropertiesPublishedCardWidget({
    super.key,
    required this.item,
  });

  final BusinessPropertyRequestModel item;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Container(
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(16.radius),
        border: Border.all(color: colors.borderColor.withValues(alpha: 0.6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(12.width),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Status badge
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.width,
                        vertical: 4.height,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.successColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20.radius),
                      ),
                      child: Text(
                        item.status,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(11),
                          fontWeight: FontWeight.w600,
                          fontFamily: AppConstant.appHeaderFont,
                          color: AppColors.successColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 6.height),
                  // Title
                  Text(
                    item.title,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(15),
                      fontWeight: FontWeight.w700,
                      fontFamily: AppConstant.appHeaderFont,
                      color: colors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 6.height),
                  // Location
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        item.location,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(12),
                          color: colors.textSecondary,
                          fontFamily: AppConstant.appFont,
                        ),
                      ),
                      SizedBox(width: 4.width),
                      Icon(
                        Icons.location_on_outlined,
                        size: 14.width,
                        color: colors.textSecondary,
                      ),
                    ],
                  ),
                  SizedBox(height: 4.height),
                  // Publish date
                  Text(
                    '${AppStrings.businessPropertiesPublishDateLabel}: ${item.requestDate}',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(12),
                      color: colors.textSecondary,
                      fontFamily: AppConstant.appFont,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.width),
            ClipRRect(
              borderRadius: BorderRadius.circular(12.radius),
              child: ImageItem(
                item.imageUrl,
                width: 90.width,
                height: 90.height,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
