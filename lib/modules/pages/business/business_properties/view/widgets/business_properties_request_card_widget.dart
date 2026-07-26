import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/utils/constants/app_colors.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/business_properties_bloc.dart';
import '../../model/business_property_request_model.dart';

class BusinessPropertiesRequestCardWidget extends StatelessWidget {
  const BusinessPropertiesRequestCardWidget({
    super.key,
      this.item,
    this.isWithActionButtons = true,
  });
  final bool isWithActionButtons;
  final BusinessPropertyRequestModel? item;

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Property image
                  Center(
                    child: ImageItem(
                      item?.imageUrl ?? '',
                      width: 83.width,
                      height: 71.height,
                      fit: BoxFit.cover,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(width: 12.width),

                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Status badge
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            Expanded(
                              child: Text(
                                item?.title ?? 'Request Title',
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: context.responsiveFontScale(16),
                                  fontWeight: FontWeight.w700,
                                  fontFamily: AppConstant.appHeaderFont,
                                  color: colors.textPrimary,
                                ),
                              ),
                            ),

                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.width,
                                vertical: 4.height,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.amber.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(20.radius),
                              ),
                              child: Text(
                                item?.status ?? 'Pending',
                                style: TextStyle(
                                  fontSize: context.responsiveFontScale(12),
                                  fontWeight: FontWeight.w600,
                                  fontFamily: AppConstant.appHeaderFont,
                                  color: const Color(0xFFB45309),
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Title
                        // Location
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_on_rounded,
                              color: colors.textSecondary,
                            ),
                            SizedBox(width: 4.width),

                            Text(
                              item?.location ?? 'Unknown location',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(14),
                                color: colors.textSecondary,
                                fontFamily: AppConstant.appFont,
                              ),
                            ),
                          ],
                        ),
                        // Individual
                        Row(
                          children: [
                            Icon(
                              Icons.person,
                              size: 16.width,
                              color: colors.textSecondary,
                            ),
                            Expanded(
                              child: Text(
                                ' ${item?.individualName ?? 'Unknown'}',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: context.responsiveFontScale(14),
                                  color: colors.textSecondary,
                                  fontFamily: AppConstant.appFont,
                                ),
                              ),
                            ),
                            // Date
                            ImageItem(
                              AppImages.updateIcon,
                              color: colors.textSecondary,
                            ),
                            Text(
                              '  ${item?.requestDate ?? 'Unknown'}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(14),
                                color: colors.textSecondary,
                                fontFamily: AppConstant.appFont,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (isWithActionButtons) ...[
              SizedBox(height: 12.height),
              // Buttons
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      childText: AppStrings.businessPropertiesAccept,
                      childIcon: Icons.check,
                      colorBG: AppColors.successColor,
                      onTap: () => context.read<BusinessPropertiesBloc>().add(
                        BusinessPropertiesAccept(item?.id ?? ''),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.width),

                  Expanded(
                    child: AppButton(
                      childText: AppStrings.businessPropertiesReject,
                      childIcon: Icons.close,
                       colorBG: AppColors.errorColor.shade100,
                      textColor: AppColors.errorColor,
                      borderColor: AppColors.errorColor,
                      onTap: () => context.read<BusinessPropertiesBloc>().add(
                        BusinessPropertiesReject(item?.id ?? ''),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
