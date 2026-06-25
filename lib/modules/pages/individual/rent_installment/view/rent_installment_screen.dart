import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/app_appbar.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../controller/rent_installment_bloc.dart';
import 'widgets/installment_info_tab_widget.dart';
import 'widgets/installment_requests_tab_widget.dart';
import 'widgets/service_tab_toggle_widget.dart';

class RentInstallmentScreen extends StatelessWidget {
  const RentInstallmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<RentInstallmentBloc, RentInstallmentState>(
        builder: (context, state) {
          final colors = AppThemeColors.of(context);
          return Scaffold(
            backgroundColor: colors.backgroundPrimary,
            appBar: AppAppbar(title: AppStrings.rentInstallment),
            body: SafeArea(
              child: Column(
                children: [
                  ServiceTabToggleWidget(
                    labels: [AppStrings.installmentRequestsTab, AppStrings.installmentInfoTab],
                    selectedIndex: state.selectedTab,
                    onTabChanged: (index) => context
                        .read<RentInstallmentBloc>()
                        .add(RentInstallmentTabChanged(index)),
                  ),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: state.selectedTab == 0
                          ? const InstallmentRequestsTabWidget(
                              key: ValueKey('requests'),
                            )
                          : const InstallmentInfoTabWidget(
                              key: ValueKey('info'),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
    
    );
  }
}
