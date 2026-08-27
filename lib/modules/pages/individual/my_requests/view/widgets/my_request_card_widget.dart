import 'package:flutter/material.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/translation.dart';
import '../../model/my_property_request_model.dart';

class MyRequestCardWidget extends StatelessWidget {
  const MyRequestCardWidget({
    super.key,
    this.item,
    this.isActionLoading = false,
  });

  final MyPropertyRequestModel? item;
  final bool isActionLoading;

  Color _statusColor() {
    switch ((item?.status ?? '').toUpperCase()) {
      case 'ACCEPTED':
      case 'APPROVED':
        return AppColors.successColor;
      case 'REJECTED':
        return AppColors.errorColor;
      default:
        return const Color(0xFFB45309);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    final statusColor = _statusColor();
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
      padding: EdgeInsets.all(12.width),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageItem(
                (item?.propertyImage ?? '').isEmpty
                    ? AppImages.propertyImage
                    : item!.propertyImage,
                width: 92.width,
                height: 92.height,
                fit: BoxFit.cover,
                borderRadius: BorderRadius.circular(12.radius),
              ),
              SizedBox(width: 12.width),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            (item?.propertyTitle ?? '').isEmpty
                                ? AppStrings.myRequestsTitle
                                : item!.propertyTitle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(14),
                              fontWeight: FontWeight.w700,
                              fontFamily: AppConstant.appHeaderFont,
                              color: colors.textPrimary,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.width,
                            vertical: 4.height,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(20.radius),
                          ),
                          child: Text(
                            (item?.statusKey ?? 'request_status_in_progress')
                                .trans,
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(11),
                              fontWeight: FontWeight.w600,
                              color: statusColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if ((item?.requestType ?? '').isNotEmpty) ...[
                      SizedBox(height: 6.height),
                      Text(
                        item!.requestType.trans,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(12),
                          color: colors.textFieldTitle.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                    if ((item?.createdAtLabel ?? '').isNotEmpty) ...[
                      SizedBox(height: 4.height),
                      Text(
                        '${AppStrings.businessPropertiesRequestDateLabel}: ${item!.createdAtLabel}',
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(12),
                          color: colors.textFieldTitle.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
