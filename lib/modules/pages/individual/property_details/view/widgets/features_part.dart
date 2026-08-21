import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class PropertyFeaturesWidget extends StatelessWidget {
  final Map<String, bool>? features;

  const PropertyFeaturesWidget({super.key, this.features});

  List<({String title, List<({List<String> keys, String title})> items})>
  get _groups => [
    (
      title: AppStrings.featureCategoryBasicServices,
      items: [
        (
          keys: ['ELECTRICITY', 'hasElectricity'],
          title: AppStrings.featureElectricity,
        ),
        (keys: ['SEWAGE', 'hasSewage'], title: AppStrings.featureSewage),
        (keys: ['WATER', 'hasWater'], title: AppStrings.featureWater),
        (keys: ['INTERNET', 'hasInternet'], title: AppStrings.featureInternet),
        (keys: ['PARKING', 'hasParking'], title: AppStrings.featureParking),
        (keys: ['FENCE', 'hasFence'], title: AppStrings.featureFence),
        (
          keys: ['IRRIGATION', 'hasIrrigation'],
          title: AppStrings.featureIrrigation,
        ),
      ],
    ),
    (
      title: AppStrings.featureCategoryInterior,
      items: [
        (
          keys: ['CENTRAL_AC', 'hasCentralAC'],
          title: AppStrings.featureCentralAc,
        ),
        (keys: ['ELEVATOR', 'hasElevator'], title: AppStrings.featureElevator),
        (keys: ['MAID_ROOM', 'hasMaidRoom'], title: AppStrings.featureMaidRoom),
        (
          keys: ['TWO_ENTRANCES', 'hasTwoEntrances'],
          title: AppStrings.featureTwoEntrances,
        ),
        (
          keys: ['DRIVER_ROOM', 'hasDriverRoom'],
          title: AppStrings.featureDriverRoom,
        ),
        (keys: ['BASEMENT', 'hasBasement'], title: AppStrings.featureBasement),
        (keys: ['ROOF', 'hasRoof'], title: AppStrings.featureRoof),
        (keys: ['STORAGE', 'hasStorage'], title: AppStrings.featureWarehouse),
      ],
    ),
    (
      title: AppStrings.featureCategoryExteriorSecurity,
      items: [
        (keys: ['POOL', 'hasPool'], title: AppStrings.featurePool),
        (
          keys: ['WATER_WELL', 'hasWaterWell'],
          title: AppStrings.featureWaterWell,
        ),
        (keys: ['CCTV', 'hasCctv'], title: AppStrings.featureCctv),
        (
          keys: ['ELECTRONIC_GATE', 'hasElectronicGate'],
          title: AppStrings.featureElectronicGate,
        ),
        (keys: ['GARDEN', 'hasGarden'], title: AppStrings.featureGarden),
        (
          keys: ['HEALTH_CLUB', 'hasHealthClub'],
          title: AppStrings.featureHealthClub,
        ),
        (
          keys: ['SECURITY', 'GUARD', 'hasGuard'],
          title: AppStrings.featureGuard,
        ),
      ],
    ),
  ];

  bool _isOn(List<String> keys) {
    final map = features;
    if (map == null) return false;
    return keys.any((k) => map[k] == true);
  }

  @override
  Widget build(BuildContext context) {
    if (features == null || features!.isEmpty) {
      return const SizedBox.shrink();
    }
    if (!features!.values.any((value) => value == true)) {
      return const SizedBox.shrink();
    }

    final colors = AppThemeColors.of(context);
    final visibleGroups = _groups
        .map(
          (g) => (
            title: g.title,
            items: g.items.where((item) => _isOn(item.keys)).toList(),
          ),
        )
        .where((g) => g.items.isNotEmpty)
        .toList();
    if (visibleGroups.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.features,
          style: TextStyle(
            fontSize: context.responsiveFontScale(16),
            fontWeight: FontWeight.w700,
            fontFamily: AppConstant.appHeaderFont,
            color: colors.textFieldTitle,
          ),
        ),
        SizedBox(height: 10.height),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.width),
          decoration: BoxDecoration(
            color: colors.cardBackground,
            borderRadius: BorderRadius.circular(16.radius),
            border: Border.all(color: colors.borderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < visibleGroups.length; i++) ...[
                Text(
                  visibleGroups[i].title,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(13),
                    fontWeight: FontWeight.w700,
                    color: colors.textSecondary,
                  ),
                ),
                SizedBox(height: 10.height),
                ...visibleGroups[i].items.map(
                  (item) => Padding(
                    padding: EdgeInsets.only(bottom: 8.height),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check,
                          size: 18.fontSize,
                          color: colors.textFieldTitle,
                        ),
                        SizedBox(width: 8.width),
                        Expanded(
                          child: Text(
                            item.title,
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(14),
                              fontWeight: FontWeight.w600,
                              color: colors.textFieldTitle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (i != visibleGroups.length - 1) SizedBox(height: 8.height),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
