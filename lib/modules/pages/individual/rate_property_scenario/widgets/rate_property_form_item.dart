import 'package:flutter/material.dart';
import '../../../../../core/utils/constants/app_constant.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/app_drop_down.dart';
import '../../../../../core/components/app_textfield.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/responsive.dart';

class RatePropertyFormItem extends StatelessWidget {
  const RatePropertyFormItem({
    super.key,
    required this.ratePropertyArea,
    required this.propertyLocation,
    this.propertyAge,
    this.finishingLevel,
    this.purpose,
    this.selectedType,
    required this.onPropertyAgeChanged,
    required this.onFinishingLevelChanged,
    required this.onPurposeChanged,
    required this.onTapPropertyType,
  });
  final TextEditingController ratePropertyArea;
  final TextEditingController propertyLocation;
  final String? propertyAge;
  final String? finishingLevel;
  final String? purpose;
  final String? selectedType;
  final Function(String?) onPropertyAgeChanged;
  final Function(String?) onFinishingLevelChanged;
  final Function(String?) onPurposeChanged;
  final Function(String) onTapPropertyType;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Column(
      children: [
        SizedBox(
          height: 40.height,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: AppConstant.propertyTypes.length,
            separatorBuilder: (_, __) => SizedBox(width: 8.width),
            itemBuilder: (ctx, i) {
              final t = AppConstant.propertyTypes[i];
              final isSelected = selectedType == t['id'];
              return GestureDetector(
                onTap: () => onTapPropertyType(t['id']!),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.width),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? colors.primaryBrand
                        : colors.cardBackground,
                    borderRadius: BorderRadius.circular(20.radius),
                    border: Border.all(
                      color: isSelected
                          ? colors.primaryBrand
                          : colors.borderColor,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    t['label']!,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(13),
                      color: isSelected
                          ? colors.onPrimary
                          : colors.textFieldTitle,
                      fontFamily: AppConstant.appFont,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 10.height),
        AppTextField(
          title: AppStrings.propertyLocationLabel,
          hint: AppStrings.ratePropertyLocationHint,
          suffixIcon: Icons.location_on_outlined,
          controller: propertyLocation,
        ),

        AppTextField(
          title: AppStrings.ratePropertyAreaLabel,
          hint: AppStrings.ratePropertyAreaHint,
          suffixIcon: Icons.crop_free_outlined,
          textInputType: TextInputType.number,
          controller: ratePropertyArea,
        ),

        AppDropDownItem(
          title: AppStrings.propertyAgeLabel,
          hintText: AppStrings.choosePropertyAge,
          value: propertyAge,
          items: AppConstant.propertyAges,
          onChanged: onPropertyAgeChanged,
        ),

        AppDropDownItem(
          title: AppStrings.ratePropertyFinishingLabel,
          hintText: AppStrings.ratePropertyFinishingHint,
          value: finishingLevel,
          items: AppConstant.finishingLevels,
          onChanged: onFinishingLevelChanged,
        ),

        AppDropDownItem(
          title: AppStrings.ratePropertyPurposeLabel,
          hintText: AppStrings.ratePropertyPurposeHint,
          value: purpose,
          items: AppConstant.purposes,
          onChanged: onPurposeChanged,
        ),
        SizedBox(height: 12.height),
      ],
    );
  }
}
