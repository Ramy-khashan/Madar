import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/property_insurance_bloc.dart';
import 'insurance_request_card_widget.dart';

class InsuranceRequestsTabWidget extends StatelessWidget {
  const InsuranceRequestsTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return BlocBuilder<PropertyInsuranceBloc, PropertyInsuranceState>(
      builder: (context, state) {
        if (state.requests.isEmpty) {
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 48.height),
              child: Text(
                AppStrings.noInsuranceRequests,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(15),
                  color: colors.textSecondary,
                ),
              ),
            ),
          );
        }
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: ResponsiveUtils.types(
              context,
              mobilePortrait: 1,
              mobileLandscape: 2,
              tabletPortrait: 2,
              tabletLandscape: 3,
            ).toInt(),
            mainAxisSpacing: 12.height,
            crossAxisSpacing: 12.width,
            mainAxisExtent: ResponsiveUtils.types(
              context,
              mobilePortrait: 200.height,
              mobileLandscape: 210.height,
              tabletPortrait: 220.height,
              tabletLandscape: 240.height,
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: context.responsiveHorizontalPadding,
            vertical: 8.height,
          ),
          itemCount: state.requests.length,
          itemBuilder: (context, index) =>
              InsuranceRequestCardWidget(request: state.requests[index]),
        );
      },
    );
  }
}
