import 'package:flutter/material.dart';
import 'package:madar_app/core/utils/functions/translation.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../model/property_details_model.dart';

class PropertyDetailsInfoCardWidget extends StatelessWidget {
  const PropertyDetailsInfoCardWidget({super.key, required this.property});

  final PropertyDetailsModel? property;

  List<({String label, dynamic value})> _details() {
    final d = property?.details;

    final items = <({String label, dynamic value})>[
      (
        label: 'Total Area',
        value: d?.totalArea ?? d?.area ?? property?.totalArea,
      ),
      (label: 'apartment_number', value: d?.apartmentNumber),
      (label: 'apartments_per_floor', value: d?.apartmentsPerFloor),
      (label: 'listing_type', value: property?.listingType),
      (label: 'payment_type_label', value: property?.paymentType),
      (label: 'facades', value: property?.facadeDirection),
      (label: 'streets_count', value: property?.streetsCount),
      (label: 'street_width', value: property?.streetWidth),

      (label: 'Built Area', value: d?.builtArea),
      (label: 'Height', value: d?.height),

      (label: 'Bedrooms', value: d?.bedrooms),
      (label: 'Bathrooms', value: d?.bathrooms),
      (label: 'Councils', value: d?.councils),
      (label: 'Kitchens', value: d?.kitchens),
      (label: 'Living Rooms', value: d?.livingRooms),
      (label: 'Rooms', value: d?.roomsCount),

      (label: 'Floor', value: d?.floor),
      (label: 'Floors', value: d?.floorsCount ?? d?.totalFloors),
      (label: 'Allowed Floors', value: d?.allowedFloors),

      (label: 'Condition', value: d?.condition),
      (label: 'Classification', value: d?.classification),
      (label: 'Furnishing', value: d?.furnishing),

      (label: 'Garden', value: d?.hasGarden),
      (label: 'Garden Area', value: d?.gardenArea),
      (label: 'Private Garden', value: d?.hasPrivateGarden),
      (label: 'Two Entrances', value: d?.hasTwoEntrances),

      (label: 'Pantry', value: d?.hasPantry),
      (label: 'Reception', value: d?.hasReception),
      (label: 'Meeting Room', value: d?.hasMeetingRoom),
      (label: 'Office', value: d?.hasOffice),
      (label: 'Furnished Office', value: d?.furnishedOffice),

      (label: 'Elevator', value: d?.hasElevator),
      (label: 'Central AC', value: d?.hasCentralAC),
      (label: 'AC', value: d?.hasAC),

      (label: 'Parking', value: d?.parkingSpots),

      (label: 'Door Type', value: d?.doorType),
      (label: 'Doors Count', value: d?.doorsCount),
      (label: 'Truck Access', value: d?.truckAccess),
      (label: 'Floor Type', value: d?.floorType),
      (label: 'Yard', value: d?.hasYard),
      (label: 'Yard Area', value: d?.yardArea),
      (label: 'Cooling Type', value: d?.coolingType),
      (label: 'Electricity (KW)', value: d?.electricityKW),

      (label: 'Mall Name', value: d?.mallName),
      (label: 'Activities', value: d?.activities),
      (label: 'Location Type', value: d?.locationType),
      (label: 'Front Width', value: d?.frontWidth),
      (label: 'Storage', value: d?.hasStorage),

      (label: 'Soil Type', value: d?.soilType),
      (label: 'Fence', value: d?.hasFence),
      (label: 'Well Depth', value: d?.wellDepth),
      (label: 'Wells Count', value: d?.wellsCount),
      (label: 'Rest House', value: d?.hasRestHouse),
      (label: 'Water Sources', value: d?.waterSources),
      (label: 'Distance To City', value: d?.distanceToCity),
      (label: 'Electricity', value: d?.hasElectricity),
      (label: 'Palm Trees', value: d?.palmTreesCount),
      (label: 'Livestock Sheds', value: d?.hasLivestockSheds),

      (label: 'Tower Name', value: d?.name),
      (label: 'Views', value: d?.views),
      (label: 'Amenities', value: d?.amenities),
      (label: 'Facilities', value: d?.facilities),
      (label: 'Year Built', value: d?.yearBuilt),
      (label: 'Total Units', value: d?.totalUnits),
      (label: 'Total Parking', value: d?.totalParking),
      (label: 'Parking Floors', value: d?.parkingFloors),
      (label: 'Elevators', value: d?.elevatorsCount),

      (label: 'Developer', value: d?.developerName),
      (label: 'Compound', value: d?.compoundName),

      (label: 'Services', value: d?.services),
      (label: 'Dimensions', value: d?.dimensions),
      (label: 'Plan Number', value: d?.planNumber),
      (label: 'Plot Number', value: d?.plotNumber),
      (label: 'Building Ratio', value: d?.buildingRatio),

      (label: 'Shops', value: d?.shopsCount),
      (label: 'Occupancy', value: d?.occupancyRate),
      (label: 'Estimated Income', value: d?.estimatedIncome),
      (label: 'Apartments', value: d?.totalApartments),

      (label: 'Service Fee', value: d?.serviceFee),
      (label: 'Shop Electricity', value: d?.electricityKWShop),
    ];

    return items.where((e) {
      final v = e.value;

      if (v == null) return false;
      if (v is String && v.trim().isEmpty) return false;
      if (v is List && v.isEmpty) return false;

      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,

      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12.height),
          child: Text(
            AppStrings.propertyDetailsTitle,
            style: TextStyle(
              fontSize: context.responsiveFontScale(16),
              fontWeight: FontWeight.w700,
              fontFamily: AppConstant.appHeaderFont,
              color: colors.textFieldTitle,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.width,
            vertical: 8.height,
          ),
          decoration: BoxDecoration(
            color: colors.cardBackground,
            borderRadius: BorderRadius.circular(16.radius),
            border: Border.all(color: colors.borderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _details().map((e) {
              final key = e.label.toLowerCase();
              return InfoRowWithIcon(
                label: key.hasTrans ? key.trans : key.replaceAll('_', ' '),
                iconKey: key,
                value: e.value,
                isLast: e == _details().last,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

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
