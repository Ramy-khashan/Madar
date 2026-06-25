import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/rent_options_bloc.dart';
import 'plan_tile_item.dart';
import 'provider_tile_part.dart';
import 'rent_confirm_sheet_widget.dart';

class RentOptionsContentWidget extends StatelessWidget {
  const RentOptionsContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: context.responsiveHorizontalPadding,
              vertical: 16.height,
            ),
            child: BlocBuilder<RentOptionsBloc, RentOptionsState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: EdgeInsets.all(24.width),
                      decoration: BoxDecoration(
                        color: colors.backgroundPrimary,
                        borderRadius: BorderRadius.circular(16.radius),
                        border: Border.all(color: colors.borderColor),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.chooseInstallmentPlan,
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(16),
                              fontWeight: FontWeight.w500,
                              fontFamily: AppConstant.appHeaderFont,
                              color: colors.textFieldTitle,
                            ),
                          ),
                          SizedBox(height: 12.height),
                          Column(
                            children: List.generate(state.plans.length, (
                              index,
                            ) {
                              final plan = state.plans[index];
                              final isSelected =
                                  state.selectedPlanId == plan.id;
                              final isLast = index == state.plans.length - 1;
                              return PlanTileItem(
                                plan: plan,
                                isSelected: isSelected,
                                isLast: isLast,
                                onTap: () => context
                                    .read<RentOptionsBloc>()
                                    .add(RentOptionsPlanSelected(plan.id)),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20.height),
                      padding: EdgeInsets.all(24.width),
                      decoration: BoxDecoration(
                        color: colors.backgroundPrimary,
                        borderRadius: BorderRadius.circular(16.radius),
                        border: Border.all(color: colors.borderColor),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.chooseInstallmentProvider,
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(16),
                              fontWeight: FontWeight.w700,
                              fontFamily: AppConstant.appHeaderFont,
                              color: colors.textFieldTitle,
                            ),
                          ),
                          SizedBox(height: 12.height),
                          Column(
                            children: List.generate(state.providers.length, (
                              index,
                            ) {
                              final provider = state.providers[index];
                              final isSelected =
                                  state.selectedProviderId == provider.id;
                              final isLast =
                                  index == state.providers.length - 1;
                              return ProviderTilePart(
                                provider: provider,
                                isSelected: isSelected,
                                isLast: isLast,
                                onTap: () =>
                                    context.read<RentOptionsBloc>().add(
                                      RentOptionsProviderSelected(provider.id),
                                    ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                   
                  ],
                );
              },
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: context.responsiveHorizontalPadding,
            vertical: 12.height,
          ),
          decoration: BoxDecoration(color: colors.backgroundPrimary),
          child: BlocBuilder<RentOptionsBloc, RentOptionsState>(
            builder: (context, state) {
              final canProceed =
                  state.selectedPlanId != null &&
                  state.selectedProviderId != null;
              return AppButton(
                text: AppStrings.continueToConfirm,
                onTap: canProceed
                    ? () => showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(24.radius),
                          ),
                        ),
                        builder: (_) => BlocProvider.value(
                          value: context.read<RentOptionsBloc>(),
                          child: const RentConfirmSheetWidget(),
                        ),
                      )
                    : null,
                colorBG: canProceed ? null : Colors.grey.shade400,
              );
            },
          ),
        ),
      ],
    );
  }
}
