import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/router/app_router_keys.dart';
import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/app_button.dart';
import '../../../../../core/utils/constants/app_constant.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../../../../../core/utils/functions/router_handler.dart';
import '../../subscription_plans/controller/subscription_bloc.dart';
import 'widgets/transaction_details_card_widget.dart';

class SummarySubscriptionScreen extends StatelessWidget {
  const SummarySubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return BlocBuilder<SubscriptionBloc, SubscriptionState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: colors.backgroundPrimary,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: context.responsiveHorizontalPadding,
                vertical: 24.height,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 24.height),
                  Center(
                    child: Container(
                      width: 90.width,
                      height: 90.width,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: colors.primaryBrand.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check_rounded,
                        size: 48.width,
                        color: colors.primaryBrand,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.height),
                  Text(
                    AppStrings.subscriptionSuccessTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(22),
                      fontWeight: FontWeight.w700,
                      fontFamily: AppConstant.appHeaderFont,
                      color: colors.textFieldTitle,
                    ),
                  ),
                  SizedBox(height: 24.height),
                  const TransactionDetailsCardWidget(),
                  SizedBox(height: 32.height),
                  AppButton(
                    onTap: () => RouterHandler.navigate(
                      context,
                      AppRouterKeys.navbar,
                      routerType: RouterType.goName,
                    ),
                    text: AppStrings.subscriptionBackToHome,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
