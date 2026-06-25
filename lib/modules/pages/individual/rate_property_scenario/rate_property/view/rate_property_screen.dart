import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/components/app_appbar.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../rent_installment/view/widgets/service_tab_toggle_widget.dart';
import '../controller/rate_property_bloc.dart';
import 'widgets/rate_property_main_tab_widget.dart';
import 'widgets/rate_property_requests_tab_widget.dart';

class RatePropertyScreen extends StatelessWidget {
  const RatePropertyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(title: AppStrings.ratePropertyTitle),
      body: SafeArea(
        child: BlocBuilder<RatePropertyBloc, RatePropertyState>(
          builder: (context, state) {
            return Column(
              children: [
                ServiceTabToggleWidget(
                  labels: [
                    AppStrings.ratePropertyRequestsTab,
                    AppStrings.ratePropertyEvaluateTab,
                  ],
                  selectedIndex: state.currentTab,
                  onTabChanged: (index) {
                    context.read<RatePropertyBloc>().add(
                      RatePropertyTabChanged(index),
                    );
                  },
                ),

                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: state.currentTab == 0
                        ? const RatePropertyRequestsTabWidget(
                            key: ValueKey('requests'),
                          )
                        : const RatePropertyMainTabWidget(
                            key: ValueKey('info'),
                          ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
