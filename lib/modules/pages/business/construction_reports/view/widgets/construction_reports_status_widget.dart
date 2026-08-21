import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/components/statistic_circle_shape_item.dart';
import '../../../../../../core/model/statistic_circle_model.dart';
import '../../controller/construction_reports_bloc.dart';

class ConstructionReportsStatusWidget extends StatelessWidget {
  const ConstructionReportsStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return BlocBuilder<ConstructionReportsBloc, ConstructionReportsState>(
      buildWhen: (p, c) => p.report != c.report,
      builder: (context, state) {
        final report = state.report;
        final contractSections = [
          if (report.contractActive.percent > 0)
            StatisticCircleModel(
              label: AppStrings.activeTab,
              value: report.contractActive.ratio,
              color: const Color(0xFF6C63FF),
            ),
          if (report.contractCompleted.percent > 0)
            StatisticCircleModel(
              label: AppStrings.endedLabel,
              value: report.contractCompleted.ratio,
              color: const Color(0xFFFF6B9D),
            ),
          if (report.contractRenewing.percent > 0)
            StatisticCircleModel(
              label: AppStrings.renewalPendingStatus,
              value: report.contractRenewing.ratio,
              color: const Color(0xFFB39DDB),
            ),
        ];
        final propertySections = [
          if (report.rented.percent > 0)
            StatisticCircleModel(
              label: AppStrings.rented,
              value: report.rented.ratio,
              color: const Color(0xFF6C63FF),
            ),
          if (report.vacant.percent > 0)
            StatisticCircleModel(
              label: AppStrings.vacant,
              value: report.vacant.ratio,
              color: const Color(0xFFFF6B9D),
            ),
        ];
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.width,
            vertical: 8.height,
          ),
          child: Row(
            children: [
              Expanded(
                child: StatisticCircleShapeItem(
                  title: AppStrings.contractsStatus,
                  sections: contractSections,
                  colors: colors,
                ),
              ),
              SizedBox(width: 12.width),
              Expanded(
                child: StatisticCircleShapeItem(
                  title: AppStrings.propertiesStatus,
                  sections: propertySections,
                  colors: colors,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
