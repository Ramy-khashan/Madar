import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../model/property_insurance_model.dart';
import '../../model/property_insurance_status_model.dart';
import 'property_insurance_request_info.dart';

class InsuranceRequestCardWidget extends StatelessWidget {
  const InsuranceRequestCardWidget({super.key, required this.request});

  final InsuranceRequestModel request;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    final statusInfo = PropertyInsuranceStatusModel.statusInfo(
      request.status,
      context,
    );

    return Container(
       padding: EdgeInsets.all(16.width),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(16.radius),
        border: Border.all(color: colors.borderColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                request.propertyName,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(16),
                  fontWeight: FontWeight.w700,
                  fontFamily: AppConstant.appHeaderFont,
                  color: colors.textFieldTitle,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.width,
                  vertical: 4.height,
                ),
                decoration: BoxDecoration(
                  color: statusInfo.bgColor,
                  borderRadius: BorderRadius.circular(20.radius),
                ),
                child: Text(
                  statusInfo.label,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(12),
                    fontWeight: FontWeight.w600,
                    color: statusInfo.textColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.height),
          PropertyInsuranceRequestInfo(
            label: AppStrings.insuranceTypeFieldLabel,
            value: request.insuranceType,
            colors: colors,
            context: context,
          ),
          SizedBox(height: 6.height),
          PropertyInsuranceRequestInfo(
            label: AppStrings.insuranceCompanyFieldLabel,
            value: request.companyName,
            colors: colors,
            context: context,
          ),
          SizedBox(height: 6.height),
          PropertyInsuranceRequestInfo(
            label: AppStrings.startDateFieldLabel,
            value: request.startDate,
            colors: colors,
            context: context,
          ),
          SizedBox(height: 6.height),
          PropertyInsuranceRequestInfo(
            label: AppStrings.endDateFieldLabel,
            value: request.endDate,
            colors: colors,
            context: context,
          ),
        ],
      ),
    );
  }
}
