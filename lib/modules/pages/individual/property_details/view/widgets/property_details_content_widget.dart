import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/components/is_scrollable_widget.dart';
import '../../../../../../core/components/responsive_row_column.dart';
import '../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../common/chats/chat_navigator.dart';
import '../../controller/property_details_bloc.dart';
import '../../model/property_details_model.dart';
import 'advertiser_section_widget.dart';
 import 'features_part.dart';
import 'property_description_section_widget.dart';
import 'property_details_header_section_widget.dart';
import 'property_details_image_section_widget.dart';
import 'property_details_info_card_widget.dart';
import 'property_location_section_widget.dart';

part 'property_actions_part.dart';

class PropertyDetailsContentWidget extends StatelessWidget {
  const PropertyDetailsContentWidget({super.key, required this.property});

  final PropertyDetailsModel? property;

  @override
  Widget build(BuildContext context) {
    final isTablet = context.isTablet;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: IsScrollableWidget(
            isScroll: !isTablet,
            padding: EdgeInsets.symmetric(
              horizontal: context.responsiveHorizontalPadding,
              vertical: 16.height,
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
                        PropertyDetailsImageSectionWidget(property: property),
                        SizedBox(height: 16.height),
                        PropertyDetailsHeaderSectionWidget(property: property),
                        SizedBox(height: 16.height),
                        PropertyDescriptionSectionWidget(
                          description: property?.description,
                        ),
                        SizedBox(height: 16.height),
                        PropertyDetailsInfoCardWidget(property: property),

                        SizedBox(height: 16.height),
                        PropertyFeaturesWidget(
                          features: property?.features?.features,
                        ),
                        SizedBox(height: 16.height),
                        PropertyLocationSectionWidget(property: property),
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
                        AdvertiserSectionWidget(
                          //TODO: Implement AdvertiserModel and pass it to the widget
                          advertiser: property?.publisher,
                        ),
                        SizedBox(height: 16.height),
                        // BuyerRelatedServicesSectionWidget(property: property),
                        SizedBox(height: 24.height),
                        if (isTablet) const PropertyActionsPart(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (!isTablet) const PropertyActionsPart(),
      ],
    );
  }
}
