import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/app_appbar.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../individual/rent_installment/view/widgets/service_tab_toggle_widget.dart';
import '../controller/business_properties_bloc.dart';
import 'widgets/business_properties_published_list_widget.dart';
import 'widgets/business_properties_requests_list_widget.dart';

class BusinessPropertiesScreen extends StatelessWidget {
  const BusinessPropertiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Scaffold(
      backgroundColor: colors.backgroundPrimary,
      appBar: AppAppbar(title: AppStrings.businessPropertiesTitle),
      body: BlocBuilder<BusinessPropertiesBloc, BusinessPropertiesState>(
        builder: (context, state) {
          return SafeArea(
            child: Column(
              children: [
                ServiceTabToggleWidget(
                  labels: [
                    AppStrings.businessPropertiesRequestsTab,
                    AppStrings.businessPropertiesPublishedTab,
                  ],
                  selectedIndex: state.currentTab,
                  onTabChanged: (i) => context
                      .read<BusinessPropertiesBloc>()
                      .add(BusinessPropertiesTabChanged(i)),
                ),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: state.currentTab == 0
                        ? BusinessPropertiesRequestsListWidget(
                            key: const ValueKey('requests'),
                            items: state.requests,
                          )
                        : BusinessPropertiesPublishedListWidget(
                            key: const ValueKey('published'),
                            items: state.published,
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
