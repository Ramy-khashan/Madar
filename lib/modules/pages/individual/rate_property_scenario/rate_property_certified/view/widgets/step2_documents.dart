import 'package:flutter/material.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../controller/rate_property_certified_bloc.dart';
import 'file_upload_item.dart';

class Step2Documents extends StatelessWidget {
  const Step2Documents({super.key, required this.colors, required this.state});

  final AppThemeColors colors;
  final RatePropertyCertifiedState state;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsiveHorizontalPadding,
        vertical: 16.height,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(14.width),
            decoration: BoxDecoration(
              color: colors.primaryBrand.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12.radius),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.description_outlined,
                  color: Theme.brightnessOf(context) == Brightness.dark
                      ? colors.onPrimary
                      : colors.primaryBrand,
                  size: 20.width,
                ),
                SizedBox(width: 8.width),

                Expanded(
                  child: Text(
                    AppStrings.ratePropertyDocsNotice,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(14),
                      color: Theme.brightnessOf(context) == Brightness.dark
                          ? colors.onPrimary
                          : colors.primaryBrand,
                      fontFamily: AppConstant.appFont,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.height),
          Text(
            AppStrings.ratePropertyRequiredDocsLabel,
            style: TextStyle(
              fontSize: context.responsiveFontScale(15),
              fontWeight: FontWeight.w700,
              fontFamily: AppConstant.appHeaderFont,
              color: colors.textFieldTitle,
            ),
          ),
          SizedBox(height: 16.height),
          FileUploadItem(
            label: AppStrings.ratePropertyOwnershipDeed,
            fileKey: 'ownership_deed',
            isRequired: true,
            uploadedFile: state.ownershipDeedFile,
            hasError: false,
            colors: colors,
          ),
          SizedBox(height: 16.height),
          FileUploadItem(
            label: AppStrings.ratePropertyOwnerId,
            fileKey: 'owner_id',
            isRequired: true,
            uploadedFile: state.ownerIdFile,
            hasError: state.ownerIdError,
            colors: colors,
          ),
          if (state.ownerIdError)
            Padding(
              padding: EdgeInsets.only(top: 4.height),
              child: Text(
                AppStrings.ratePropertyOwnerIdError,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(12),
                  color: Colors.red,
                  fontFamily: AppConstant.appFont,
                ),
              ),
            ),
          SizedBox(height: 16.height),
          FileUploadItem(
            label: AppStrings.ratePropertyPropertyPlan,
            fileKey: 'property_plan',
            isRequired: false,
            uploadedFile: state.propertyPlanFile,
            hasError: false,
            colors: colors,
          ),
          SizedBox(height: 32.height),
        ],
      ),
    );
  }
}
