import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/router/app_router_keys.dart';
import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/app_appbar.dart';
import '../../../../../core/utils/constants/app_constant.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../../../../../core/utils/functions/router_handler.dart';
import '../../subscription_plans/controller/subscription_bloc.dart';
import 'widgets/subscription_payment_option_card.dart';

class PaymentTypeScreen extends StatelessWidget {
  const PaymentTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return BlocListener<SubscriptionBloc, SubscriptionState>(
      listenWhen: (prev, curr) => prev.confirmStatus != curr.confirmStatus,
      listener: (ctx, state) {
        if (state.confirmStatus == RequestStatus.loading) {
          RouterHandler.navigate(
            context,
            AppRouterKeys.subscriptionLoadingPay,
            extra: SubscriptionBloc.get(context),
          );
        }
      },
      child: BlocBuilder<SubscriptionBloc, SubscriptionState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: colors.backgroundPrimary,
            appBar: AppAppbar(title: AppStrings.subscriptionPaymentTitle),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.responsiveHorizontalPadding,
                        vertical: 16.height,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            AppStrings.subscriptionPaymentSubtitle,
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(14),
                              fontFamily: AppConstant.appFont,
                              color: colors.textSecondary,
                              height: 1.6,
                            ),
                          ),
                          SizedBox(height: 24.height),
                          Text(
                            AppStrings.subscriptionPaymentOptionsTitle,
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(15),
                              fontFamily: AppConstant.appHeaderFont,
                              fontWeight: FontWeight.w700,
                              color: colors.textPrimary,
                            ),
                          ),
                          SizedBox(height: 12.height),
                          SubscriptionPaymentOptionCard(
                            label: AppStrings.subscriptionApplePayLabel,
                            subtitle: AppStrings.subscriptionApplePaySubtitle,
                            iconPath: 'assets/icons/apple_pay.svg',
                            method: SubscriptionPaymentMethod.applePay,
                             onTap: () {
                              context
                                .read<SubscriptionBloc>()
                                .add(const SubscriptionPaymentMethodSelected(
                                  SubscriptionPaymentMethod.applePay,
                                ));
                                context
                              .read<SubscriptionBloc>()
                              .add(const SubscriptionConfirmPayment());
                            },
                          ),
                          SubscriptionPaymentOptionCard(
                            label: AppStrings.subscriptionVisaLabel,
                            subtitle: AppStrings.subscriptionVisaSubtitle,
                            iconPath: 'assets/icons/visa.svg',
                            method: SubscriptionPaymentMethod.visa,
                             onTap: () {
                              context
                                .read<SubscriptionBloc>()
                                .add(const SubscriptionPaymentMethodSelected(
                                  SubscriptionPaymentMethod.visa,
                                ));
                                context
                              .read<SubscriptionBloc>()
                              .add(const SubscriptionConfirmPayment());
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                 
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
