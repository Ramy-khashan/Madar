import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/app_appbar.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../rent_installment/view/widgets/service_tab_toggle_widget.dart';
import '../controller/property_insurance_bloc.dart';
import 'widgets/insurance_info_tab_widget.dart';
import 'widgets/insurance_requests_tab_widget.dart';

class PropertyInsuranceScreen extends StatelessWidget {
  const PropertyInsuranceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<PropertyInsuranceBloc, PropertyInsuranceState>(
        builder: (context, state) {
          final colors = AppThemeColors.of(context);
          return Scaffold(
            backgroundColor: colors.backgroundPrimary,
            appBar: AppAppbar(title: AppStrings.propertyInsuranceScreenTitle),
            body: SafeArea(
              child: Column(
                children: [
                  ServiceTabToggleWidget(
                    labels: [ AppStrings.insuranceRequestsTab, AppStrings.insuranceInfoTab],
                     selectedIndex: state.selectedTab,
                    onTabChanged: (index) => context
                        .read<PropertyInsuranceBloc>()
                        .add(PropertyInsuranceTabChanged(index)),
                  ),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: state.selectedTab == 0
                          ? const InsuranceRequestsTabWidget(
                              key: ValueKey('requests'),
                            )
                          : const InsuranceInfoTabWidget(
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
