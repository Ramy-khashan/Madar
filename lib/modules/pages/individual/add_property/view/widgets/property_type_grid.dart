import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';
import 'property_type_card.dart';

class PropertyTypeGrid extends StatelessWidget {
  const PropertyTypeGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      buildWhen: (prev, curr) =>
          prev.model.propertyType != curr.model.propertyType,
      builder: (context, state) {
        final items = AddPropertyBloc.propertyTypeItems;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: ResponsiveUtils.types(
              context,
              mobilePortrait: 2,
              mobileLandscape: 3,
              tabletPortrait: 3,
              tabletLandscape: 4,
            ).toInt(),

            crossAxisSpacing: 10,
            mainAxisSpacing: 10,

            mainAxisExtent: ResponsiveUtils.types(
              context,
              mobilePortrait: 140.height,
              mobileLandscape: 130.height,
              tabletPortrait: 140.height,
              tabletLandscape: 105.height,
            ),
          ),
          itemCount: items.length,
          itemBuilder: (context, i) {
            final item = items[i];
            return PropertyTypeCard(
              id: item['id'] as String,
              label: item['label'] as String,
              icon: item['icon'] as String,
              isSelected: state.model.propertyType == item['id'],
              tc: AppThemeColors.of(context),
            );
          },
        );
      },
    );
  }
}
