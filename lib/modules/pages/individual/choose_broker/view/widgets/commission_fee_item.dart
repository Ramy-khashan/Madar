import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../add_property/model/property_enums.dart';
import '../../../add_property/view/widgets/counter_button_item.dart';
import '../../controller/choose_broker_bloc.dart';

class CommissionFeeItem extends StatelessWidget {
  const CommissionFeeItem({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return BlocBuilder<ChooseBrokerBloc, ChooseBrokerState>(
      buildWhen: (prev, curr) =>
          prev.commissionRate != curr.commissionRate ||
          prev.commissionPayer != curr.commissionPayer,
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(top: 16.height),
          padding: EdgeInsets.all(16.width),
          decoration: BoxDecoration(
            color: colors.cardBackground,
            borderRadius: BorderRadius.circular(24.radius),
            border: Border.all(color: colors.borderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CounterButton(
                    icon: Icons.add_rounded,
                    onTap: () => context.read<ChooseBrokerBloc>().add(
                      ChooseBrokerCommissionChanged(
                        (state.commissionRate + 0.5).clamp(0.5, 20).toDouble(),
                      ),
                    ),
                    tc: colors,
                    enabled: true,
                    isPrimery: true,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.width),
                    child: Column(
                      children: [
                        Text(
                          AppStrings.commissionFee,
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(14),
                            fontFamily: AppConstant.appHeaderFont,
                            fontWeight: FontWeight.w700,
                            color: colors.primaryBrand,
                          ),
                        ),
                        SizedBox(height: 12.height),
                        Text(
                          '${state.commissionRate}%',
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(20),
                            fontFamily: AppConstant.appHeaderFont,
                            fontWeight: FontWeight.bold,
                            color: colors.primaryBrand,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CounterButton(
                    icon: Icons.remove_rounded,
                    onTap: () => context.read<ChooseBrokerBloc>().add(
                      ChooseBrokerCommissionChanged(
                        (state.commissionRate - 0.5).clamp(0.5, 20).toDouble(),
                      ),
                    ),
                    iconColor: colors.onPrimary,
                    tc: colors,
                    enabled: true,
                    isPrimery: false,
                  ),
                ],
              ),
              SizedBox(height: 16.height),
              Text(
                '${AppStrings.defaultRate} 2%',
                style: TextStyle(
                  fontSize: context.responsiveFontScale(14),
                  fontFamily: AppConstant.appHeaderFont,
                  fontWeight: FontWeight.w600,
                  color: colors.primaryBrand.withValues(alpha: 0.8),
                ),
              ),
              SizedBox(height: 4.height),
              Text(
                AppStrings.youCanAdjustRate,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(14),
                  fontFamily: AppConstant.appHeaderFont,
                  fontWeight: FontWeight.w600,
                  color: colors.primaryBrand.withValues(alpha: 0.8),
                ),
              ),
              SizedBox(height: 16.height),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      text: AppStrings.propertySeeker,
                      isOutline:
                          state.commissionPayer !=
                          PropertyApiEnums.commissionPayerIndividual,
                      onTap: () => context.read<ChooseBrokerBloc>().add(
                        const ChooseBrokerPayerChanged(
                          PropertyApiEnums.commissionPayerIndividual,
                        ),
                      ),
                      textSize: context.responsiveFontScale(12),
                    ),
                  ),
                  SizedBox(width: 8.width),
                  Expanded(
                    child: AppButton(
                      text: AppStrings.propertyOwner,
                      isOutline:
                          state.commissionPayer !=
                          PropertyApiEnums.commissionPayerOwner,
                      onTap: () => context.read<ChooseBrokerBloc>().add(
                        const ChooseBrokerPayerChanged(
                          PropertyApiEnums.commissionPayerOwner,
                        ),
                      ),
                      textSize: context.responsiveFontScale(12),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
