import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/app_appbar.dart';
import '../../../../../core/components/loading_process.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/common_fun.dart';
import '../../../individual/rent_installment/view/widgets/service_tab_toggle_widget.dart';
import '../controller/business_properties_bloc.dart';
import '../model/business_property_request_model.dart';
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
      body: BlocConsumer<BusinessPropertiesBloc, BusinessPropertiesState>(
        listenWhen: (prev, curr) => prev.actionStatus != curr.actionStatus,
        listener: (context, state) {
          if (state.actionStatus == RequestStatus.failed &&
              state.actionMessage.isNotEmpty) {
            AppToast(state.actionMessage, isError: true);
          } else if (state.actionStatus == RequestStatus.success &&
              state.actionMessage.isNotEmpty) {
            AppToast(state.actionMessage);
          }
        },
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
                        ? LoadingProcess(
                            key: const ValueKey('requests'),
                            status: state.requestsStatus,
                            errorMsg: state.requestsErrorMessage,
                            emptyMsg: AppStrings.businessPropertiesNoRequests,
                            isEmptyList: state.requests.isEmpty,
                            childIsLoader: true,
                            onTapRefresh: () => context
                                .read<BusinessPropertiesBloc>()
                                .add(const BusinessPropertiesLoad()),
                            child: BusinessPropertiesRequestsListWidget(
                              items:
                                  state.requestsStatus == RequestStatus.loading
                                  ? List.generate(
                                      4,
                                      (_) => BusinessPropertyRequestModel(
                                        title: 'Property title',
                                        owner: 'Owner',
                                        status: 'PENDING',
                                        city: 'City',
                                        district: 'District',
                                      ),
                                    )
                                  : state.requests,
                              actionRequestId: state.actionRequestId,
                              isActionLoading:
                                  state.actionStatus == RequestStatus.loading,
                            ),
                          )
                        : LoadingProcess(
                            key: const ValueKey('published'),
                            status: state.publishedStatus,
                            errorMsg: state.publishedErrorMessage,
                            emptyMsg: AppStrings.businessPropertiesNoPublished,
                            isEmptyList: state.published.isEmpty,
                            childIsLoader: true,
                            onTapRefresh: () => context
                                .read<BusinessPropertiesBloc>()
                                .add(const BusinessPropertiesLoad()),
                            child: BusinessPropertiesPublishedListWidget(
                              items: state.published,
                              actionRequestId: state.actionRequestId,
                              isActionLoading:
                                  state.actionStatus == RequestStatus.loading,
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
