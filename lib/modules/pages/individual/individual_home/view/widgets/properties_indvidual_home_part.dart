import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/router/app_router_keys.dart';
import '../../../../../../core/components/loading_process.dart';
import '../../../../../../core/components/property_card_widget.dart';
import '../../../../../../core/components/section_header_widget.dart';
import '../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/router_handler.dart';
import '../../controller/individual_home_bloc.dart';

class PropertiesIndvidualHomePart extends StatelessWidget {
  const PropertiesIndvidualHomePart({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<IndividualHomeBloc, IndividualHomeState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(bottom: 20.height, top: 20.height),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SectionHeaderWidget(
                  title: AppStrings.allProperties,
                  onViewAll: () {
                    RouterHandler.navigate(
                      context,
                      AppRouterKeys.propertiesListing,
                    );
                  },
                ),
                SizedBox(
                  height: ResponsiveUtils.types(
                    context,
                    mobilePortrait: 365.height,
                    mobileLandscape: 360.height,
                    tabletPortrait: 310.height,
                    tabletLandscape: 380.height,
                  ),
                  child: LoadingProcess(
                    status: state.propertiesStatus,
                    errorMsg: state.propertiesErrorMsg,
                    onTapRefresh: () {
                      IndividualHomeBloc.get(
                        context,
                      ).add(const IndividualHomeLoadProperties());
                    },
                    childIsLoader: true,
                    emptyMsg: AppStrings.noPropertyFound,
                    isEmptyList: state.properties.isEmpty,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(
                        horizontal: context.responsiveHorizontalPadding,
                        vertical: 10.height,
                      ),
                      itemCount: state.propertiesStatus == RequestStatus.loading
                          ? 10
                          : state.properties.length,
                      separatorBuilder: (_, _) => SizedBox(width: 16.width),
                      itemBuilder: (context, index) {
                        final property =
                            state.propertiesStatus == RequestStatus.loading
                            ? null
                            : state.properties[index];
                        return PropertyCardWidget(
                          isWithWidth: true,
                          property: property,
                        );
                      },
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
