
import 'package:flutter/material.dart';

import '../../../../../../config/router/app_router_keys.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/router_handler.dart';
import '../../controller/property_file_bloc.dart';
import '../../model/property_file_model.dart';
import 'property_file_header_widget.dart';
import 'unit_card.dart';

class   PropertyFileContentItem extends StatelessWidget {
  const PropertyFileContentItem({super.key, 
    required this.property,
    required this.colors,
    required this.state,
    required this.bloc,
  });

  final PropertyFileModel property;
  final AppThemeColors colors;
  final PropertyFileState state;
  final PropertyFileBloc bloc;

  @override
  Widget build(BuildContext context) {
 

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.fromLTRB(16.width, 16.height, 16.width, 0),
          sliver: SliverToBoxAdapter(
            child: PropertyFileHeaderWidget(
              property: property,
              colors: colors,
              onBookmarkTap: () => bloc.add(const PropertyFileToggleBookmark()),
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(16.width, 20.height, 16.width, 8.height),
          sliver: SliverToBoxAdapter(
            child: Row(
              children: [
                Text(
                  AppStrings.apartments,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(16),
                    fontWeight: FontWeight.w700,
                    color: colors.textFieldTitle,
                   ),
                ),
                Text(
                  AppStrings.rentedFromTotal(
                    property.rentedCount,
                    property.totalUnits,
                  ),
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(13),
                    color: colors.textSecondary,
                   ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 8.0, end: 4),
                  child: CircleAvatar(
                    radius: 4.width,
                    backgroundColor: AppColors.lightSuccessColor,
                  ),
                ),
                Text(
                  AppStrings.rentedStatus,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(12),
                    color: colors.textFieldBorder,
                   ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 8.0, end: 4),
                  child: CircleAvatar(
                    radius: 4.width,
                    backgroundColor: colors.textFieldBorder,
                  ),
                ),
                Text(
                  AppStrings.vacantStatus,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(12),
                    color: colors.textFieldBorder,
                   ),
                ),
              ],
            ),
          ),
        ),

        SliverPadding(
          padding: EdgeInsets.fromLTRB(16.width, 0, 16.width, 24.height),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate((context, index) {
              final unit = state.property?.units[index];
              return UnitCard(
                unit: unit!,
                colors: colors,
                onTap: () => RouterHandler.navigate(
                  context,
                  AppRouterKeys.unitDetailsScreen,
                  extra: {'unit': unit, 'propertyName': property.name},
                ),
              );
            }, childCount: state.property?.units.length ?? 0),
            gridDelegate:   SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              mainAxisExtent: ResponsiveUtils.types(
                context,
                mobilePortrait: 130.height,
                mobileLandscape: 130.height,
                tabletPortrait: 160.height,
                tabletLandscape: 180.height,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
