import 'package:flutter/material.dart';

import '../../../../../../core/components/section_header_widget.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../individual/individual_home/model/smart_service_model.dart';
 import 'performance_summary_shape.dart';

class PerformanceSummaryItem extends StatelessWidget {
  final List<SmartServiceModel> performanceSummary;

  const PerformanceSummaryItem({super.key, required this.performanceSummary});

  @override
  Widget build(BuildContext context) {
    final isTablet = context.isTablet;
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 16.height),
          SectionHeaderWidget(title: AppStrings.performanceSummary),

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
                tabletPortrait: 3,
                tabletLandscape: 3,
              ).toInt(),
              crossAxisSpacing: 12.width,
              mainAxisSpacing: 12.height,
              mainAxisExtent: ResponsiveUtils.types(
                context,
                mobilePortrait: 115.height,
                mobileLandscape: 96.height,
                tabletPortrait: 95.height,
                tabletLandscape: 140.height,
              ),
            ),
            itemCount: performanceSummary.length - (isTablet ? 0 : 1),
            itemBuilder: (context, index) {
              final service = performanceSummary[index];
              return PerformanceSummaryShape(
                title: service.title,
                image: service.icon,
                value: service.description,
              );
            },
          ),
          if (!isTablet)
            Container(
              margin: EdgeInsets.only(
                top: 12.height,
                left: context.responsiveHorizontalPadding,
                right: context.responsiveHorizontalPadding,
              ),
              width: double.infinity,

              child: PerformanceSummaryShape(
                title: performanceSummary.last.title,
                image: performanceSummary.last.icon,
                value: performanceSummary.last.description,
              ),
            ),
        ],
      ),
    );
  }
}
