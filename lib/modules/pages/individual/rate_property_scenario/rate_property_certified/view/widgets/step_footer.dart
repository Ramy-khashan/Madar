import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/components/app_button.dart';
import '../../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../controller/rate_property_certified_bloc.dart';

class StepFooter extends StatelessWidget {
  const StepFooter({super.key, required this.state, required this.colors});

  final RatePropertyCertifiedState state;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    final isLastStep = state.currentStep == 2;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsiveHorizontalPadding,
        vertical: 12.height,
      ),
      child: AppButton(
        text: isLastStep ? AppStrings.ratePropertySendBtn : AppStrings.next,
        isLoading: state.submitStatus == RequestStatus.loading,
        onTap: () {
          if (isLastStep) {
            context.read<RatePropertyCertifiedBloc>().add(
              const RatePropertyCertifiedSubmit(),
            );
          } else {
            if (state.currentStep == 1) {
              context.read<RatePropertyCertifiedBloc>().add(
                const RatePropertyCertifiedLoadCompanies(),
              );
            }
            context.read<RatePropertyCertifiedBloc>().add(
              const RatePropertyCertifiedNextStep(),
            );
          }
        },
      ),
    );
  }
}
