import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/common_fun.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/auction_deposit_bloc.dart';

class AuctionDepositSuccessWidget extends StatelessWidget {
  const AuctionDepositSuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuctionDepositBloc, AuctionDepositState>(
      builder: (context, state) {
        final colors = AppThemeColors.of(context);
        final methodLabel =
            state.selectedPaymentMethod == AuctionDepositPaymentMethod.applePay
            ? AppStrings.depositApplePayLabel
            : AppStrings.depositVisaLabel;

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: context.responsiveHorizontalPadding,
            vertical: 24.height,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20.height),
              Center(
                child: Container(
                  width: 90.width,
                  height: 90.width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppThemeColors.of(
                      context,
                    ).primaryBrand.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_circle_outline_rounded,
                    size: 56.width,
                    color: AppThemeColors.of(context).primaryBrand,
                  ),
                ),
              ),
              SizedBox(height: 20.height),
              Text(
                AppStrings.depositSuccessDone,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(22),
                  fontWeight: FontWeight.w700,
                  fontFamily: AppConstant.appHeaderFont,
                  color: colors.textPrimary,
                ),
              ),
              SizedBox(height: 8.height),
              Text(
                AppStrings.depositSuccessNote,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(13),
                  fontFamily: AppConstant.appFont,
                  color: colors.textSecondary,
                  height: 1.6,
                ),
              ),
              SizedBox(height: 24.height),
              Container(
                padding: EdgeInsets.all(16.width),
                decoration: BoxDecoration(
                  color: colors.cardBackground,
                  borderRadius: BorderRadius.circular(16.radius),
                  border: Border.all(color: colors.textFieldBorder),
                ),
                child: Column(
                  children: [
                    ListTile(
                      minLeadingWidth: 0,
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        AppStrings.depositPaidAmountLabel,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(13),
                          fontFamily: AppConstant.appFont,
                          color: colors.textSecondary,
                        ),
                      ),
                      trailing: Text(
                        '${formatPrice(state.depositAmount)} ${AppStrings.currency}',
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(14),
                          fontFamily: AppConstant.appHeaderFont,
                          fontWeight: FontWeight.w700,
                          color: colors.primaryBrand,
                        ),
                      ),
                    ),
                    Divider(color: colors.textFieldBorder, height: 1),
                    ListTile(
                      minLeadingWidth: 0,
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        AppStrings.depositPaymentMethodLabel,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(13),
                          fontFamily: AppConstant.appFont,
                          color: colors.textSecondary,
                        ),
                      ),
                      trailing: Text(
                        methodLabel,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(14),
                          fontFamily: AppConstant.appHeaderFont,
                          fontWeight: FontWeight.w700,
                          color: colors.textPrimary,
                        ),
                      ),
                    ),
                    Divider(color: colors.textFieldBorder, height: 1),
                    ListTile(
                      minLeadingWidth: 0,
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        AppStrings.depositTransactionIdLabel,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(13),
                          fontFamily: AppConstant.appFont,
                          color: colors.textSecondary,
                        ),
                      ),
                      trailing: Text(
                        state.transactionId,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(14),
                          fontFamily: AppConstant.appHeaderFont,
                          fontWeight: FontWeight.w700,
                          color: colors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.height),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 14.width,
                  vertical: 12.height,
                ),
                decoration: BoxDecoration(
                  color: AppThemeColors.of(
                    context,
                  ).primaryBrand.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12.radius),
                  border: Border.all(
                    color: AppThemeColors.of(
                      context,
                    ).primaryBrand.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '✅   ${AppStrings.depositSuccessEligible}',
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(12),
                          fontFamily: AppConstant.appFont,
                          color: AppThemeColors.of(context).primaryBrand,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.height),
              AppButton(
                onTap: () => Navigator.of(context).pop(),
                text: AppStrings.depositBackToAuction,
              ),
              SizedBox(height: 16.height),
            ],
          ),
        );
      },
    );
  }
}
