import 'package:flutter/material.dart';
import 'package:madar_app/core/utils/functions/translation.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../model/property_details_model.dart';

class InfoRowWithIcon extends StatelessWidget {
  const InfoRowWithIcon({
    super.key,
    required this.label,
    required this.value,
    required this.iconKey,
    this.isLast = false,
  });

  final String label;
  final String iconKey;
  final dynamic value;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.height),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    ImageItem(
                      _iconFor(iconKey),
                      width: 18.width,
                      height: 18.width,
                      color: colors.primaryBrand,
                    ),
                    SizedBox(width: 8.width),
                    Expanded(
                      child: Text(
                        label,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(13),
                          color: colors.textFieldTitle,
                          fontFamily: AppConstant.appFont,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.width),
              Expanded(
                child: Text(
                  _formatValue(value),
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(14),
                    fontWeight: FontWeight.w600,
                    color: colors.textFieldTitle,
                    fontFamily: AppConstant.appFont,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (!isLast) Divider(height: 1, color: colors.borderColor),
      ],
    );
  }

  static final _enumKey = RegExp(r'^[A-Z][A-Z0-9_]*$');

  static const _valueAliases = {
    'CASH': 'payment_cash',
    'INSTALLMENT': 'payment_installment',
    'SALE': 'SALE',
    'RENT': 'RENT',
    'NORTH': 'NORTH',
    'SOUTH': 'SOUTH',
    'EAST': 'EAST',
    'WEST': 'WEST',
    'USED': 'USED',
    'NEW': 'NEW',
    'FURNISHED': 'FURNISHED',
    'UNFURNISHED': 'UNFURNISHED',
    'SEMI_FURNISHED': 'SEMI_FURNISHED',
  };

  static String _formatValue(dynamic value) {
    if (value == null) return '';

    if (value is bool) {
      return value ? 'yes'.trans : 'no'.trans;
    }

    if (value is List) {
      return value.map(_formatValue).join(', ');
    }

    if (value is Dimensions) {
      return 'E:${value.east}  W:${value.west}  N:${value.north}  S:${value.south}';
    }

    if (value is num) return value.toString();

    final raw = value.toString().trim();
    if (raw.isEmpty) return '';

    final upper = raw.toUpperCase();
    final alias = _valueAliases[upper];
    if (alias != null && alias.hasTrans) return alias.trans;
    if (_enumKey.hasMatch(upper) && upper.hasTrans) return upper.trans;
    return raw;
  }

  static String _iconFor(String label) {
    switch (label.toLowerCase().trim()) {
      case 'bedrooms':
      case 'rooms':
      case 'living rooms':
      case 'kitchens':
        return AppImages.bedroomIcon;

      case 'bathrooms':
        return AppImages.bathroomIcon;

      case 'councils':
        return AppImages.setterNoIcon;

      case 'area':
      case 'total area':
      case 'built area':
      case 'garden area':
      case 'yard area':
      case 'height':
      case 'front width':
      case 'well depth':
      case 'distance to city':
        return AppImages.totalSpaceIcon;

      case 'floor':
      case 'floors':
      case 'allowed floors':
      case 'parking floors':
      case 'floor type':
        return AppImages.floorIcon;

      case 'balcony':
      case 'garden':
      case 'private garden':
      case 'yard':
        return AppImages.balconyIcon;

      case 'furnishing':
      case 'furnished office':
        return AppImages.furnitureIcon;

      case 'developer':
      case 'compound':
      case 'mall name':
      case 'tower name':
        return AppImages.developerNameIcon;

      case 'elevator':
      case 'elevators':
        return AppImages.elevatorStopsIcon;

      case 'streets_count':
        return AppImages.streetNoIcon;

      case 'street_width':
        return AppImages.streetWidthIcon;

      case 'classification':
      case 'condition':
        return AppImages.towerClassIcon;

      case 'total units':
      case 'apartments':
      case 'apartments_per_floor':
      case 'shops':
        return AppImages.unitsNoIcon;

      case 'views':
      case 'facades':
        return AppImages.viewIcon;

      case 'year built':
        return AppImages.workingYearIcon;

      case 'listing_type':
      case 'payment_type_label':
      case 'estimated income':
      case 'service fee':
        return AppImages.finalPriceIcon;

      default:
        return AppImages.propertyNumberIcon;
    }
  }
}
