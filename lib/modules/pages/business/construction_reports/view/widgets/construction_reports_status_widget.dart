import 'package:flutter/material.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/components/statistic_circle_shape_item.dart';
import '../../../../../../core/model/statistic_circle_model.dart';

class ConstructionReportsStatusWidget extends StatelessWidget {
  const ConstructionReportsStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.width, vertical: 8.height),
      child: Row(
        children: [
          Expanded(
            child: StatisticCircleShapeItem(
              title: AppStrings.contractsStatus,
              sections: [
                StatisticCircleModel(
                  label: AppStrings.activeTab,
                  value: 0.50,
                  color: const Color(0xFF6C63FF),
                ),
                StatisticCircleModel(
                  label: AppStrings.endedLabel,
                  value: 0.15,
                  color: const Color(0xFFFF6B9D),
                ),
                StatisticCircleModel(
                  label: AppStrings.renewalPendingStatus,
                  value: 0.35,
                  color: const Color(0xFFB39DDB),
                ),
              ],
              colors: colors,
            ),
          ),
          SizedBox(width: 12.width),
          Expanded(
            child: StatisticCircleShapeItem(
              title: AppStrings.propertiesStatus,
              sections: [
                StatisticCircleModel(
                  label: AppStrings.rented,
                  value: 0.50,
                  color: const Color(0xFF6C63FF),
                ),
                StatisticCircleModel(
                  label: AppStrings.vacant,
                  value: 0.15,
                  color: const Color(0xFFFF6B9D),
                ),
                StatisticCircleModel(
                  label: AppStrings.underMaintenance,
                  value: 0.35,
                  color: const Color(0xFFB39DDB),
                ),
              ],
              colors: colors,
            ),
          ),
        ],
      ),
    );
  }
}
