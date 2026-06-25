import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/rent_installment_bloc.dart';
import 'installment_request_card_widget.dart';

class InstallmentRequestsTabWidget extends StatelessWidget {
  const InstallmentRequestsTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return BlocBuilder<RentInstallmentBloc, RentInstallmentState>(
      builder: (context, state) {
        if (state.requests.isEmpty) {
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 48.height),
              child: Text(
                AppStrings.noInstallmentRequests,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(15),
                  color: colors.textSecondary,
                ),
              ),
            ),
          );
        }
        return GridView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.responsiveHorizontalPadding,
                      vertical: 8.height,
                    ),
                    itemCount: state.requests.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: ResponsiveUtils.types(
                        context,
                        mobilePortrait: 1,
                        mobileLandscape: 2,
                        tabletPortrait: 2,
                        tabletLandscape: 3,
                      ).toInt(),
                      crossAxisSpacing: 8.width,
                      mainAxisSpacing: 8.height,
                      mainAxisExtent: ResponsiveUtils.types(
                        context,
                        mobilePortrait: 310.height,
                        mobileLandscape: 325.height,
                        tabletPortrait: 330.height,
                        tabletLandscape: 345.height,
                      ),
                    ),
          itemBuilder: (context, index) => InstallmentRequestCardWidget(
            request: state.requests[index],
          ),
        );
      },
    );
  }
}
