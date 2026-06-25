import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/app_appbar.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../controller/construction_reports_bloc.dart';
import 'widgets/construction_reports_charts_widget.dart';
import 'widgets/construction_reports_filter_widget.dart';
import 'widgets/construction_reports_performance_widget.dart';
import 'widgets/construction_reports_status_widget.dart';

class ConstructionReportsScreen extends StatelessWidget {
  const ConstructionReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Scaffold(
      backgroundColor: colors.backgroundPrimary,
      appBar: AppAppbar(title: AppStrings.performanceReports),
      body: BlocBuilder<ConstructionReportsBloc, ConstructionReportsState>(
        builder: (context, state) {
          if (state.status == RequestStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const ConstructionReportsFilterWidget(),
                  const ConstructionReportsPerformanceWidget(),
                  const ConstructionReportsLineChartWidget(),
                  const ConstructionReportsStatusWidget(),
                  const ConstructionReportsBarChartWidget(),
                  SizedBox(height: 16, child: Container()),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
