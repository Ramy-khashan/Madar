import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import 'animated_dots.dart';
import 'deposit_dots_cubit.dart';

class AuctionDepositProcessingWidget extends StatelessWidget {
  const AuctionDepositProcessingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DepositDotsCubit(),
      child: Builder(
        builder: (context) {
          final dotController = context.read<DepositDotsCubit>().controller;
          return Padding(
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
                      color: AppThemeColors.of(context).primaryBrand,
                      strokeWidth: 3.5,
                    ),
                  ),
                ),
                SizedBox(height: 32.height),
                Text(
                  AppStrings.depositProcessingTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(20),
                    fontWeight: FontWeight.w700,
                    fontFamily: AppConstant.appHeaderFont,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 10.height),
                Text(
                  AppStrings.depositProcessingSub,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(13),
                    fontFamily: AppConstant.appFont,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.55),
                    height: 1.6,
                  ),
                ),
                SizedBox(height: 32.height),
                AnimatedDots(controller: dotController),
              ],
            ),
          );
        },
      ),
    );
  }
}
