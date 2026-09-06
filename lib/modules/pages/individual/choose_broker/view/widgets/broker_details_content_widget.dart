import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/components/outline_section.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart'; 
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/choose_broker_bloc.dart';
import '../../model/broker_model.dart';
import 'commission_fee_item.dart';

part 'broker_summary_card_item.dart';

class BrokerDetailsContentWidget extends StatelessWidget {
  const BrokerDetailsContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return BlocBuilder<ChooseBrokerBloc, ChooseBrokerState>(
      builder: (context, state) {
        final broker = state.selectedBroker;
        if (broker == null) return const SizedBox.shrink();
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: context.responsiveHorizontalPadding,
                  vertical: 12.height,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      AppStrings.reviewBeforeProceed,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(16),
                        fontFamily: AppConstant.appHeaderFont,
                        fontWeight: FontWeight.w500,
                        color: colors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 16.height),
                    Stack(
                      children: [
                        BrokerSummaryCard(broker: broker, colors: colors),
                        const Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: CommissionFeeItem(),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.height),
                      child: OutlinedSection(
                        title: AppStrings.brokerResponsibilities,
                        child: Column(
                          children: [
                            ...ChooseBrokerBloc.responsibilities.map(
                              (resp) => Padding(
                                padding: EdgeInsets.only(bottom: 8.height),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 28.width,
                                      height: 28.width,
                                      padding: EdgeInsets.all(4.width),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: colors.primaryBrand.withValues(
                                          alpha: 0.1,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.check_circle_outline,
                                        size: 20.width,
                                        color: AppColors.secondBrand,
                                      ),
                                    ),
                                    SizedBox(width: 8.width),

                                    Expanded(
                                      child: Text(
                                        resp,
                                        style: TextStyle(
                                          fontSize: context.responsiveFontScale(
                                            16,
                                          ),
                                          fontFamily: AppConstant.appFont,
                                          color: colors.textFieldTitle,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(14.width),
                      decoration: BoxDecoration(
                        color: colors.primaryBrand.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(12.radius),
                        border: Border.all(
                          color: colors.primaryBrand.withValues(alpha: 0.2),
                          width: 2,
                        ),
                      ),
                      child: Text(
                        AppStrings.brokerContactNote,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(14),
                          fontFamily: AppConstant.appHeaderFont,
                          color: colors.primaryBrand,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: AppButton(
                width: 560.width,
                text: AppStrings.sendToBrokerBtn,
                isLoading: state.confirmStatus.name == 'loading',
                onTap: () =>
                    context.read<ChooseBrokerBloc>().add(const ChooseBrokerConfirm()),
              ),
            ),
          ],
        );
      },
    );
  }
}
 