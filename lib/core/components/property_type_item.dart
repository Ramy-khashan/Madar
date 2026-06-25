import 'package:flutter/material.dart';

import '../../config/theme/app_theme_colors.dart';
import '../utils/constants/app_constant.dart';
import '../utils/constants/app_strings.dart';
import '../utils/functions/responsive.dart';
 
class PropertyTypeSection extends StatelessWidget {
  const PropertyTypeSection({super.key, required this.onTap, required this.selectedItem});
  final void Function(String) onTap;
  final String? selectedItem;
  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppStrings.propertyType,
          style: TextStyle(
            fontSize: context.responsiveFontScale(16),
            fontWeight: FontWeight.w600,
            fontFamily: AppConstant.appHeaderFont,
            color: colors.textFieldTitle,
          ),
        ),
        SizedBox(height: 10.height),
       SizedBox(
              height: 40.height,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: AppConstant.propertyTypes.length,
                itemBuilder: (context, index) {
                  final type = AppConstant.propertyTypes[index];
                  final isSelected = selectedItem == type['id'];
                  return Padding(
                    padding: EdgeInsetsDirectional.only(start: 8.width),
                    child: GestureDetector(
                      onTap: () => onTap(type['id']!),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.width,
                          vertical: 10.height,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? colors.primaryBrand
                              : colors.cardBackground,
                          borderRadius: BorderRadius.circular(24.radius),
                          border: Border.all(
                            color: isSelected
                                ? colors.primaryBrand
                                : colors.borderColor,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            type['label']!,
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(14),
                              fontWeight: FontWeight.w500,
                              fontFamily: AppConstant.appHeaderFont,
                              color: isSelected
                                  ? colors.onPrimary
                                  : colors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ) ,
        SizedBox(height: 8.height),
      ],
    );
  }
}
