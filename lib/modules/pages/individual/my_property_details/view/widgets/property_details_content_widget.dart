import 'package:flutter/material.dart';

import '../../../../../../core/components/is_scrollable_widget.dart';
import '../../../../../../core/components/responsive_row_column.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../model/property_details_model.dart';
import 'contracts_section_widget.dart';
import 'property_header_section_widget.dart';
import 'property_image_section_widget.dart';
import 'property_info_card_widget.dart';
import 'related_services_section_widget.dart';

class PropertyDetailsContentWidget extends StatelessWidget {
  const PropertyDetailsContentWidget({super.key, required this.property});

  final PropertyDetailsModel? property;

  @override
  Widget build(BuildContext context) {
    final isTablet = context.isTablet;
    return Scaffold(
      body: IsScrollableWidget(
        isScroll: !isTablet,
        padding: EdgeInsets.symmetric(
          horizontal: context.responsiveHorizontalPadding,
        ),
        child: ResponsiveRowColumn(
          isTablet: isTablet,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: isTablet ? 1 : 0,
              child: IsScrollableWidget(
                isScroll: isTablet,
                child: Column(
                  children: [
                    PropertyImageSectionWidget(property: property),
                    SizedBox(height: 16.height),
                    PropertyHeaderSectionWidget(property: property),
                    SizedBox(height: 16.height),
                    PropertyInfoCardWidget(property: property),
                    SizedBox(height: 16.height),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: isTablet ? 1 : 0,
              child: IsScrollableWidget(
                isScroll: isTablet,
                child: Column(
                  children: [
                    ContractsSectionWidget(
                      contracts: property?.contracts ?? [],
                    ),
                    // SizedBox(height: 16.height),
                    // FinancialPerformanceSectionWidget(property: property),
                    SizedBox(height: 16.height),
                    const RelatedServicesSectionWidget(),
                    SizedBox(height: 32.height),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
