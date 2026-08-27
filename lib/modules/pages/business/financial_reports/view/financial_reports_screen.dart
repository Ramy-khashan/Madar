import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/app_appbar.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../controller/financial_reports_bloc.dart';
import 'widgets/financial_reports_expenses_tab_widget.dart';
import 'widgets/financial_reports_filter_widget.dart';
import 'widgets/financial_reports_overview_tab_widget.dart';
import 'widgets/financial_reports_revenue_tab_widget.dart';
import 'widgets/financial_reports_tab_bar.dart';

class FinancialReportsScreen extends StatelessWidget {
  const FinancialReportsScreen({super.key});

  List<String> get _tabLabels => [
    AppStrings.overviewTab,
    AppStrings.financialTabRevenue,
    AppStrings.financialTabExpenses,
  ];

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Scaffold(
      backgroundColor: colors.backgroundPrimary,
      appBar: AppAppbar(title: AppStrings.financialReportsTitle),
      body: BlocBuilder<FinancialReportsBloc, FinancialReportsState>(
        buildWhen: (p, c) =>
            p.status != c.status || p.selectedTab != c.selectedTab,
        builder: (context, state) {
          return SafeArea(
            child: Column(
              children: [
                FinancialReportsTabBar(
                  labels: _tabLabels,
                  selectedIndex: state.selectedTab,
                  colors: colors,
                  onTabChanged: (i) => context.read<FinancialReportsBloc>().add(
                    FinancialReportsTabChanged(i),
                  ),
                ),
                Expanded(
                  child: state.status == RequestStatus.loading
                      ? const Center(child: CircularProgressIndicator())
                      : state.status == RequestStatus.failed
                      ? Center(
                          child: Text(
                            state.errorMessage ?? AppStrings.somethingWentWrong,
                          ),
                        )
                      : AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          child: SingleChildScrollView(
                            key: ValueKey(state.selectedTab),
                            child: Column(
                              children: [
                                const FinancialReportsFilterWidget(),
                                if (state.selectedTab == 0)
                                  const FinancialReportsOverviewTabWidget()
                                else if (state.selectedTab == 1)
                                  const FinancialReportsRevenueTabWidget()
                                else
                                  const FinancialReportsExpensesTabWidget(),
                              ],
                            ),
                          ),
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
