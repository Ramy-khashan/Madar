import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/router/app_router_keys.dart';
import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/utils/constants/app_colors.dart';
import '../../../../../core/utils/constants/app_constant.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../../../../../core/utils/functions/router_handler.dart';
import '../../subscription_plans/controller/subscription_bloc.dart';

class LoadingPayScreen extends StatefulWidget {
  const LoadingPayScreen({super.key});

  @override
  State<LoadingPayScreen> createState() => _LoadingPayScreenState();
}

class _LoadingPayScreenState extends State<LoadingPayScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _dotController;

  @override
  void initState() {
    super.initState();
    _dotController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _dotController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return BlocListener<SubscriptionBloc, SubscriptionState>(
      listenWhen: (prev, curr) => prev.confirmStatus != curr.confirmStatus,
      listener: (ctx, state) {
        if (state.confirmStatus == RequestStatus.success) {
          RouterHandler.navigate(
            context,
            AppRouterKeys.subscriptionSummary,
            routerType: RouterType.pushReplacementNamed,
            extra: SubscriptionBloc.get(context),
          );
        }
      },
      child: Scaffold(
        backgroundColor: colors.backgroundPrimary,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.responsiveHorizontalPadding,
              vertical: 24.height,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100.width,
                  height: 100.width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.primary300.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: SizedBox(
                    width: 52.width,
                    height: 52.width,
                    child: CircularProgressIndicator(
                      color: colors.primaryBrand,
                      strokeWidth: 3.5,
                    ),
                  ),
                ),
                SizedBox(height: 32.height),
                Text(
                  AppStrings.subscriptionProcessingTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(24),
                    fontWeight: FontWeight.w700,
                    fontFamily: AppConstant.appHeaderFont,
                    color: colors.textFieldTitle,
                  ),
                ),
                SizedBox(height: 10.height),
                Text(
                  AppStrings.subscriptionProcessingSubtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(16),
                    fontFamily: AppConstant.appFont,
                    color: colors.textSecondary,
                    height: 1.6,
                  ),
                ),
                SizedBox(height: 32.height),
                AnimatedBuilder(
                  animation: _dotController,
                  builder: (context, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (index) {
                        final delay = index / 3;
                        final value = (_dotController.value - delay) % 1.0;
                        final opacity =
                            (value < 0.5 ? value * 2 : (1 - value) * 2)
                                .clamp(0.3, 1.0);
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 4.width),
                          width: 10.width,
                          height: 10.width,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: colors.primaryBrand
                                .withValues(alpha: opacity),
                          ),
                        );
                      }),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
