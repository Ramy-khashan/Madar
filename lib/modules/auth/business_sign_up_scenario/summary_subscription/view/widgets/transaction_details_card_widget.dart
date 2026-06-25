import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/common_fun.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../subscription_plans/controller/subscription_bloc.dart';

class TransactionDetailsCardWidget extends StatelessWidget {
  const TransactionDetailsCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return BlocBuilder<SubscriptionBloc, SubscriptionState>(
      builder: (context, state) {
        final methodLabel =
            state.paymentMethod == SubscriptionPaymentMethod.applePay
                ? AppStrings.subscriptionApplePayLabel
                : AppStrings.subscriptionVisaLabel;

        return Container(
          padding: EdgeInsets.all(16.width),
          decoration: BoxDecoration(
            color: colors.cardBackground,
            borderRadius: BorderRadius.circular(16.radius),
            border: Border.all(color: colors.textFieldBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                AppStrings.subscriptionTransactionDetails,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(15),
                  fontWeight: FontWeight.w700,
                  fontFamily: AppConstant.appHeaderFont,
                  color: colors.textFieldTitle,
                ),
              ),
              SizedBox(height: 8.height),
              Divider(color: colors.textFieldBorder, height: 1),
              _DetailRow(
                label: AppStrings.subscriptionPaidAmountLabel,
                value:
                    '${formatPrice(20000)} ${AppStrings.currency}',
                valueColor:AppColors.successColor,
              ),
              Divider(color: colors.textFieldBorder, height: 1),
              _DetailRow(
                label: AppStrings.subscriptionPaymentMethodLabel,
                value: methodLabel,
              ),
              Divider(color: colors.textFieldBorder, height: 1),
              _DetailRow(
                label: AppStrings.subscriptionTransactionIdLabel,
                value: state.transactionId,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.height),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: context.responsiveFontScale(13),
              fontFamily: AppConstant.appFont,
              color: colors.textSecondary,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: context.responsiveFontScale(14),
              fontFamily: AppConstant.appHeaderFont,
              fontWeight: FontWeight.w700,
              color: valueColor ?? colors.textFieldTitle,
            ),
          ),
        ],
      ),
    );
  }
}
