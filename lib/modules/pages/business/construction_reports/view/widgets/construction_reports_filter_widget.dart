import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/components/statistic_filter_card.dart';
import '../../controller/construction_reports_bloc.dart';

class ConstructionReportsFilterWidget extends StatelessWidget {
  const ConstructionReportsFilterWidget({super.key});

  List<Map<String, String>> get _periods => [
    {'id': 'monthly', 'label': AppStrings.monthly},
    {'id': 'quarterly', 'label': AppStrings.quarterly},
    {'id': 'yearly', 'label': AppStrings.yearly},
  ];

  List<Map<String, String>> get _scopes => [
    {'id': 'all', 'label': AppStrings.allPropertiesScope},
    {'id': 'single', 'label': AppStrings.singlePropertyScope},
  ];

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return BlocBuilder<ConstructionReportsBloc, ConstructionReportsState>(
      buildWhen: (p, c) =>
          p.selectedPeriod != c.selectedPeriod ||
          p.selectedScope != c.selectedScope,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.width,
            vertical: 8.height,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              FilterCard(
                title: AppStrings.timePeriod,
                options: _periods,
                selectedId: state.selectedPeriod,
                colors: colors,
                onChanged: (id) => context.read<ConstructionReportsBloc>().add(
                  ConstructionReportsPeriodChanged(id),
                ),
              ),
              SizedBox(height: 8.height),
              FilterCard(
                title: AppStrings.chooseScope,
                options: _scopes,
                selectedId: state.selectedScope,
                colors: colors,
                onChanged: (id) => context.read<ConstructionReportsBloc>().add(
                  ConstructionReportsScopeChanged(id),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

