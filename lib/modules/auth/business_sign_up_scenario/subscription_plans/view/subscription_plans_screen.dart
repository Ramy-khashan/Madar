import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/loading_process.dart';
import '../../../../../core/utils/constants/app_constant.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../controller/subscription_bloc.dart';
import 'widgets/billing_cycle_toggle_widget.dart';
import 'widgets/subscription_plan_card_widget.dart';

class SubscriptionPlansScreen extends StatelessWidget {
  const SubscriptionPlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return BlocBuilder<SubscriptionBloc, SubscriptionState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: colors.backgroundPrimary,

          body: SafeArea(
            child: LoadingProcess(
              status: state.loadStatus,
              errorMsg: state.errorMsg,
              onTapRefresh: () => context.read<SubscriptionBloc>().add(
                const SubscriptionLoad(),
              ),
              emptyMsg: '',
              isEmptyList: false,
              childIsLoader: true,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: context.responsiveHorizontalPadding,
                  vertical: 16.height,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      AppStrings.subscriptionChoosePlanTitle,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(24),
                        fontWeight: FontWeight.w500,
                        fontFamily: AppConstant.appHeaderFont,
                        color: colors.primaryBrand,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 11.height),
                      child: Text(
                        AppStrings.subscriptionChoosePlanSubtitle,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(16),
                          fontFamily: AppConstant.appFont,
                          color: colors.textSecondary,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.height),
                    BillingCycleToggleWidget(
                      billingCycle: state.billingCycle,
                      onToggle: (cycle) => context.read<SubscriptionBloc>().add(
                        SubscriptionBillingCycleToggled(cycle),
                      ),
                    ),
                    SizedBox(height: 24.height),
                    ...state.plans.map(
                      (plan) => SubscriptionPlanCardWidget(
                        plan: plan,
                        isSelected: state.selectedPlanId == plan.id,
                        billingCycle: state.billingCycle,
                        onTap: () => context.read<SubscriptionBloc>().add(
                          SubscriptionPlanSelected(plan.id),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
