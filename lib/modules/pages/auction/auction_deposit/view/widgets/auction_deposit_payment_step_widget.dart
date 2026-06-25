import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/auction_deposit_bloc.dart';
import 'auction_deposit_amount_card_widget.dart';
import 'payment_options_type.dart';

class AuctionDepositPaymentStepWidget extends StatelessWidget {
  const AuctionDepositPaymentStepWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuctionDepositBloc, AuctionDepositState>(
      builder: (context, state) {
        final colors = AppThemeColors.of(context);
        return Column(
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
                      AppStrings.depositSelectMethodSubtitle,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(16),
                        fontFamily: AppConstant.appFont,
                        color: colors.textSecondary,
                        height: 1.6,
                      ),
                    ),
                    SizedBox(height: 20.height),
                    AuctionDepositAmountCardWidget(
                      depositAmount: state.depositAmount,
                    ),
                    SizedBox(height: 24.height),
                    Text(
                      'طريقة الدفع',
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(15),
                        fontFamily: AppConstant.appHeaderFont,
                        fontWeight: FontWeight.w700,
                        color: colors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 12.height),
                    ...AuctionDepositBloc.paymentMethods.map(
                      (paymentMethod) => PaymentOptionCard(
                        onTap: () => context.read<AuctionDepositBloc>().add(
                          AuctionDepositMethodSelected(paymentMethod.method),
                        ),
                        label: paymentMethod.label,
                        subtitle: paymentMethod.subtitle,
                        icon: paymentMethod.iconPath,
                        method: paymentMethod.method,
                        isSelected:
                            state.selectedPaymentMethod == paymentMethod.method,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.responsiveHorizontalPadding,
                vertical: 16.height,
              ),
              child: AppButton(
                onTap: state.selectedPaymentMethod == null
                    ? null
                    : () => context.read<AuctionDepositBloc>().add(
                        const AuctionDepositConfirmPayment(),
                      ),
                text: AppStrings.depositConfirmBtn,
              ),
            ),
          ],
        );
      },
    );
  }
}
