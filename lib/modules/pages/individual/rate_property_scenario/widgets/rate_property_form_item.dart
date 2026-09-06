import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/app_drop_down.dart';
import '../../../../../core/components/app_textfield.dart';
import '../../../../../core/utils/constants/app_constant.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../../../../../core/utils/functions/translation.dart';

class RatePropertyFormItem extends StatelessWidget {
  const RatePropertyFormItem({
    super.key,
    required this.ratePropertyArea,
    required this.propertyLocation,
    this.propertyAge,
    this.finishingLevel,
    this.purpose,
    this.selectedType,
    required this.propertyController,
    this.properties = const [],
    required this.onPropertyAgeChanged,
    required this.onFinishingLevelChanged,
    required this.onPurposeChanged,
    required this.onTapPropertyType,
    this.onSearch,
    this.onSelectProperty,
  });

  final TextEditingController ratePropertyArea;
  final TextEditingController propertyLocation;
  final String? propertyAge;
  final TextEditingController propertyController;
  final List<String> properties;
  final String? finishingLevel;
  final String? purpose;
  final String? selectedType;
  final Function(String?) onPropertyAgeChanged;
  final Function(String?) onFinishingLevelChanged;
  final Function(String?) onPurposeChanged;
  final Function(String) onTapPropertyType;
  final Function(String)? onSearch;
  final Function(String)? onSelectProperty;

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
            separatorBuilder: (_, _) => SizedBox(width: 8.width),
            itemBuilder: (ctx, i) {
              final propertyType = AppConstant.propertyTypes[i];
              final isSelected = selectedType == propertyType;
              return GestureDetector(
                onTap: () => onTapPropertyType(propertyType),
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
                    propertyType.trans,
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
        // PropertySearchField(
        //   controller: propertyController,
        //   suggestions: properties,
        //   onSearch: onSearch,
        //   onSelectProperty: onSelectProperty,
        //   colors: colors,
        // ),
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
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
        ),
        AppDropDownItem(
          title: AppStrings.propertyAgeLabel,
          hintText: AppStrings.choosePropertyAge,

          value: propertyAge!.isEmpty ? null : propertyAge,
          items: AppConstant.propertyAges,
          onChanged: onPropertyAgeChanged,
        ),
        // AppDropDownItem(
        //   title: AppStrings.ratePropertyFinishingLabel,
        //   hintText: AppStrings.ratePropertyFinishingHint,
        //   value: finishingLevel,
        //   items: AppConstant.finishingLevels,
        //   onChanged: onFinishingLevelChanged,
        // ),
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
