import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/property_details_bloc.dart';
import 'broker_request_actions.dart';
import 'listing_actions.dart';

class PropertyActionsPart extends StatelessWidget {
  const PropertyActionsPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.radius),
        border: Border.all(color: AppThemeColors.of(context).borderColor),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: context.responsiveHorizontalPadding,
        vertical: 16.height,
      ),
      child: BlocBuilder<PropertyDetailsBloc, PropertyDetailsState>(
        builder: (context, state) {
          if (state.isBrokerRequest) {
            return BrokerRequestActions(state: state);
          }
          return ListingActions(state: state);
        },
      ),
    );
  }
}
