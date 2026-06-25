import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class BillingCycleToggleWidget extends StatelessWidget {
  const BillingCycleToggleWidget({
    super.key,
    required this.billingCycle,
    required this.onToggle,
  });

  final SubscriptionBillingCycle billingCycle;
  final ValueChanged<SubscriptionBillingCycle> onToggle;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    final isMonthly = billingCycle == SubscriptionBillingCycle.monthly;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => onToggle(SubscriptionBillingCycle.monthly),
          child: Text(
            AppStrings.subscriptionMonthly,
            style: TextStyle(
               fontSize: context.responsiveFontScale(20),
              fontWeight:  FontWeight.w500,
              fontFamily: AppConstant.appHeaderFont,
              color: colors.textFieldTitle,
            ),
          ),
        ),
        SizedBox(width: 8.width),
        Switch(
          value: !isMonthly,
          onChanged: (val) => onToggle(
            val
                ? SubscriptionBillingCycle.yearly
                : SubscriptionBillingCycle.monthly,
          ),
          activeThumbColor: colors.onPrimary,
          activeTrackColor: colors.primaryBrand,
        ),
        SizedBox(width: 8.width),
        GestureDetector(
          onTap: () => onToggle(SubscriptionBillingCycle.yearly),
          child: Text(
            AppStrings.subscriptionYearly,
            style: TextStyle(
              fontSize: context.responsiveFontScale(20),
              fontWeight:  FontWeight.w500,
              fontFamily: AppConstant.appHeaderFont,
              color: colors.textFieldTitle,
            ),
          ),
        ),
      ],
    );
  }
}
