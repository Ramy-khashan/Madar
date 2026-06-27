import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../controller/add_property_bloc.dart';
import 'steps/step1_type_screen.dart';
import 'steps/step2_period_screen.dart';
import 'steps/step3_location_screen.dart';
import 'steps/step4_images_screen.dart';
import 'steps/step5_details_screen.dart';
import 'steps/step6_review_screen.dart';

class AddPropertyScreen extends StatelessWidget {
  const AddPropertyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddPropertyBloc(),
      child: const _AddPropertyView(),
    );
  }
}

class _AddPropertyView extends StatelessWidget {
  const _AddPropertyView();

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        final bloc = AddPropertyBloc.get(context);
        if (bloc.state.step == AddPropertyStep.type) {
          Navigator.of(context).pop();
        } else {
          bloc.add(const PreviousStepEvent());
        }
      },
      child: Scaffold(
        backgroundColor: tc.backgroundPrimary,
        appBar: AppBar(
          backgroundColor: tc.backgroundPrimary,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          title: Text(
            AppStrings.addPropertyTitle,
            style: TextStyle(
              fontSize: context.responsiveFontScale(18),
              fontWeight: FontWeight.w700,
              color: tc.textPrimary,
            ),
          ),
          leading: InkWell(
            onTap: () {
              final bloc = AddPropertyBloc.get(context);
              if (bloc.state.step == AddPropertyStep.type) {
                Navigator.of(context).pop();
              } else {
                bloc.add(const PreviousStepEvent());
              }
            },
            child: Icon(Icons.arrow_back_ios_new_rounded,
                color: tc.textPrimary, size: 20),
          ),
        ),
        body: Column(
          children: [
            _StepIndicator(tc: tc),
            Expanded(
              child: BlocBuilder<AddPropertyBloc, AddPropertyState>(
                buildWhen: (prev, curr) => prev.step != curr.step,
                builder: (context, state) {
                  return switch (state.step) {
                    AddPropertyStep.type => const AddPropertyStep1Screen(),
                    AddPropertyStep.period => const AddPropertyStep2Screen(),
                    AddPropertyStep.location => const AddPropertyStep3Screen(),
                    AddPropertyStep.images => const AddPropertyStep4Screen(),
                    AddPropertyStep.details => const AddPropertyStep5Screen(),
                    AddPropertyStep.review => const AddPropertyStep6Screen(),
                  };
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepIndicator extends StatelessWidget {
  const _StepIndicator({required this.tc});
  final AppThemeColors tc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      buildWhen: (prev, curr) =>
          prev.indicatorIndex != curr.indicatorIndex,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.fromLTRB(16.width, 4.height, 16.width, 12.height),
          child: Row(
            children: List.generate(
              AddPropertyState.totalIndicatorSteps,
              (i) {
                final isActive = i <= state.indicatorIndex;
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.width),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      height: 4,
                      decoration: BoxDecoration(
                        color: isActive
                            ? tc.primaryBrand
                            : tc.borderColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
