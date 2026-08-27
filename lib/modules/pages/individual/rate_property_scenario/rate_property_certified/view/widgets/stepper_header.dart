import 'package:flutter/material.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';

class StepperHeader extends StatelessWidget {
  const StepperHeader({
    super.key,
    required this.currentStep,
    required this.colors,
  });

  final int currentStep;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    final steps = [
      AppStrings.ratePropertyStep1,
      AppStrings.ratePropertyStep2,
      AppStrings.ratePropertyStep3,
    ];

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsiveHorizontalPadding,
        vertical: 12.height,
      ),
      child: Row(
        children: List.generate(steps.length * 2 - 1, (i) {
          if (i.isOdd) {
            final stepIndex = i ~/ 2;
            return Expanded(
              child: Container(
                height: 2,
                color: stepIndex < currentStep
                    ? colors.primaryBrand
                    : colors.borderColor,
              ),
            );
          }
          final stepIndex = i ~/ 2;
          final isDone = stepIndex < currentStep;
          final isActive = stepIndex == currentStep;
          return Column(
            children: [
              Container(
                width: 24.width,
                height: 24.width,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDone || isActive
                      ? colors.primaryBrand
                      : colors.borderColor,
                ),
                child: isDone
                    ? Icon(Icons.check, color: colors.onPrimary, size: 14.width)
                    : Center(
                        child: Text(
                          '${stepIndex + 1}',
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(11),
                            color: isActive
                                ? colors.onPrimary
                                : colors.textSecondary,
                            fontFamily: AppConstant.appFont,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
              ),
              SizedBox(height: 4.height),
              Text(
                steps[stepIndex],
                style: TextStyle(
                  fontSize: context.responsiveFontScale(10),
                  color: isActive || isDone
                      ? colors.primaryBrand
                      : colors.textSecondary,
                  fontFamily: AppConstant.appFont,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
