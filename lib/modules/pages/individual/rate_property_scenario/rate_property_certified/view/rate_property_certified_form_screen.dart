import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_appbar.dart';
import '../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../controller/rate_property_certified_bloc.dart';
import 'widgets/rate_property_certified_success_dialog.dart';
import 'widgets/step1_property_data.dart';
import 'widgets/step2_documents.dart';
import 'widgets/step3_companies.dart';
import 'widgets/step_footer.dart';
import 'widgets/stepper_header.dart';

class RatePropertyCertifiedFormScreen extends StatelessWidget {
  final RatePropertyCertifiedBloc bloc;
  const RatePropertyCertifiedFormScreen({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return BlocProvider.value(
      value: bloc,
      child:
          BlocConsumer<RatePropertyCertifiedBloc, RatePropertyCertifiedState>(
            listenWhen: (prev, curr) => prev.submitStatus != curr.submitStatus,
            listener: (ctx, state) {
              if (state.submitStatus == RequestStatus.success) {
                showDialog(
                  context: ctx,
                  builder: (_) => RatePropertyCertifiedSuccessDialog(
                    requestNumber: state.requestNumber,
                  ),
                );
              }
            },
            builder: (context, state) {
              return Scaffold(
                backgroundColor: colors.backgroundPrimary,
                appBar: AppAppbar(title: AppStrings.ratePropertyCertifiedTitle),
                body: SafeArea(
                  child: Column(
                    children: [
                      StepperHeader(
                        currentStep: state.currentStep,
                        colors: colors,
                      ),
                      Expanded(
                        child: IndexedStack(
                          index: state.currentStep,
                          children: [
                            Step1PropertyData(colors: colors, state: state),
                            Step2Documents(colors: colors, state: state),
                            Step3Companies(colors: colors, state: state),
                          ],
                        ),
                      ),
                      StepFooter(state: state, colors: colors),
                    ],
                  ),
                ),
              );
            },
          ),
    );
  }
}
