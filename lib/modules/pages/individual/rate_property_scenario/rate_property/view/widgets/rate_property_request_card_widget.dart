import 'package:flutter/material.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/components/app_button.dart';
import '../../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/common_fun.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../model/rate_property_model.dart';

class RatePropertyRequestCard extends StatelessWidget {
  const RatePropertyRequestCard({super.key, required this.request});

  final RatePropertyRequestModel? request;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Container(
      padding: EdgeInsets.all(16.width),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(12.radius),
        border: Border.all(color: colors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Text(
                request?.title ?? 'Title of the request',
                style: TextStyle(
                  fontSize: context.responsiveFontScale(18),
                  fontWeight: FontWeight.w700,
                  fontFamily: AppConstant.appHeaderFont,
                  color: colors.textFieldTitle,
                ),
              ),
              const Spacer(),
              _StatusBadge(
                status: request?.status ?? 'newRequest',
                colors: colors,
              ),
            ],
          ),
          SizedBox(height: 8.height),
          Text(
            '${AppStrings.requestNumberLabel} ${request?.requestNumber ?? 'REQ-XXX'}',
            style: TextStyle(
              fontSize: context.responsiveFontScale(14),
              color: colors.textFieldTitle,
              fontFamily: AppConstant.appFont,
            ),
          ),

          SizedBox(height: 4.height),
          Row(
            children: [
              Icon(
                Icons.assignment_outlined,
                size: 14.width,
                color: colors.textSecondary,
              ),
              SizedBox(width: 4.width),

              Text(
                request?.type == 'certified'
                    ? AppStrings.ratePropertyCertifiedType
                    : AppStrings.ratePropertyEstimatedType,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(14),
                  color: colors.textSecondary,
                  fontFamily: AppConstant.appFont,
                ),
              ),
            ],
          ),

          SizedBox(height: 4.height),
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 14.width,
                color: colors.textSecondary,
              ),
              SizedBox(width: 4.width),

              Text(
                '${AppStrings.ratePropertyRequestDate} ${request?.requestDate ?? 'XX XXX XXXX'}',
                style: TextStyle(
                  fontSize: context.responsiveFontScale(14),
                  color: colors.textSecondary,
                  fontFamily: AppConstant.appFont,
                ),
              ),
            ],
          ),

          if (request?.estimatedValue != null) ...[
            SizedBox(height: 20.height),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12.width,
                vertical: 12.height,
              ),
              decoration: BoxDecoration(
                           color:colors.primaryBrand.withValues(alpha: .2),

                borderRadius: BorderRadius.circular(8.radius),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.ratePropertyEstimatedValueLabel,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(12),
                      color: colors.textSecondary,
                      fontFamily: AppConstant.appFont,
                    ),
                  ),
                  SizedBox(height: 4.height),
                  Text(
                    '${formatPrice(request?.estimatedValue ?? 0)} ${AppStrings.currency}',
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(18),
                      fontWeight: FontWeight.bold,
                      color: colors.primaryBrand,
                      fontFamily: AppConstant.appHeaderFont,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.height),
            AppButton(
              text: AppStrings.ratePropertyDownloadPdf,
              height: 44.height,
              textSize: 14,
              onTap: () {},
            ),
          ],
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status, required this.colors});

  final String status;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    Color color;
    String label;

    switch (status) {
      case 'ready':
        color = AppColors.successColor;
        label = AppStrings.ratePropertyReadyBadge;
        break;
      case 'underReview':
        color = Colors.orange;
        label = AppStrings.underReviewStatus;
        break;
      case 'newRequest':
        color = AppColors.secondBrand;
        label = AppStrings.newStatusBadge;
        break;
      default:
        color = colors.textSecondary;
        label = status;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.width, vertical: 3.height),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.radius),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: context.responsiveFontScale(12),
          color: color,
          fontFamily: AppConstant.appFont,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
