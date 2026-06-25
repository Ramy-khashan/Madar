import 'package:flutter/material.dart';

import '../../../../../../core/components/section_header_widget.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/router_handler.dart';
import '../../../../individual/individual_home/view/widgets/smart_service_card_widget.dart';
import '../../controller/business_home_bloc.dart';

class SmartServicesPart extends StatelessWidget {
  const SmartServicesPart({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = context.isTablet;
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(bottom: 24.height),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SectionHeaderWidget(title: AppStrings.smartServices),
            if (!isTablet)
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 12.height,
                  horizontal: context.responsiveHorizontalPadding,
                ),
                width: double.infinity,
                height: 210.height,
                child: SmartServiceCardWidget(
                  service: BusinessHomeBloc.mockSmartServices.first,
                  onTap: () {
                    if (BusinessHomeBloc
                        .mockSmartServices
                        .first
                        .route
                        .isNotEmpty) {
                      RouterHandler.navigate(
                        context,
                        BusinessHomeBloc.mockSmartServices.first.route,
                      );
                    }
                  },
                ),
              ),
            GridView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: context.responsiveHorizontalPadding,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: ResponsiveUtils.types(
                  context,
                  mobilePortrait: 2,
                  mobileLandscape: 3,
                  tabletPortrait: 5,
                  tabletLandscape: 5,
                ).toInt(),
                crossAxisSpacing: 12.width,
                mainAxisSpacing: 12.height,
                mainAxisExtent: ResponsiveUtils.types(
                  context,
                  mobilePortrait: 230.height,
                  mobileLandscape: 210.height,
                  tabletPortrait: 145.height,
                  tabletLandscape: 210.height,
                ),
              ),
              itemCount:
                  BusinessHomeBloc.mockSmartServices.length -
                  (isTablet ? 0 : 1),
              itemBuilder: (context, index) {
                final int selectedIndex = isTablet ? index : index + 1;
                final service =
                    BusinessHomeBloc.mockSmartServices[selectedIndex];
                return SmartServiceCardWidget(
                  service: service,
                  onTap: () {
                    if (service.route.isNotEmpty) {
                      RouterHandler.navigate(context, service.route);
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}