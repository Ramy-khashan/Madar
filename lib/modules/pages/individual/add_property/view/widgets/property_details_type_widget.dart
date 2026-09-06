import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_textfield.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/translation.dart';
import '../../controller/add_property_bloc.dart';
import '../../model/add_property_request_mapper.dart';
import '../../model/property_enums.dart';
import 'property_inputs/checkbox_item_widget.dart';
import 'property_inputs/counter_field_widget.dart';
import 'property_inputs/dropdown_field_widget.dart';
import 'property_inputs/property_details_section_header.dart';
import 'property_inputs/radio_group_widget.dart';
import 'field_error_text.dart';

/// Renders the `details` section for the selected property type.
///
/// Every field writes into `AddPropertyModel.typeDetails` under its API field
/// name, so the request mapper can read it back without per-type plumbing.
class PropertyDetailsTypeWidget extends StatelessWidget {
  const PropertyDetailsTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      buildWhen: (prev, curr) =>
          prev.model.propertyType != curr.model.propertyType,
      builder: (context, state) {
        return _buildPropertyTypeDetails(state.model.propertyType);
      },
    );
  }

  Widget _buildPropertyTypeDetails(String? propertyType) {
    switch (propertyType) {
      case PropertyApiEnums.typeApartment:
        return const _ApartmentDetails();
      case PropertyApiEnums.typeVilla:
        return const _VillaDetails();
      case PropertyApiEnums.typeFloor:
        return const _FloorDetails();
      case PropertyApiEnums.typeTownhouse:
        return const _TownhouseDetails();
      case PropertyApiEnums.typeBuilding:
        return const _BuildingDetails();
      case PropertyApiEnums.typeLand:
        return const _LandDetails();
      case PropertyApiEnums.typeRestHouse:
        return const _RestHouseDetails();
      case PropertyApiEnums.typeTower:
        return const _TowerDetails();
      case PropertyApiEnums.typeShop:
        return const _ShopDetails();
      case PropertyApiEnums.typeOffice:
        return const _OfficeDetails();
      case PropertyApiEnums.typeFarm:
        return const _FarmDetails();
      case PropertyApiEnums.typeWarehouse:
        return const _WarehouseDetails();
      default:
        return const SizedBox.shrink();
    }
  }
}

// ============================================================================
// Reusable wired inputs
// ============================================================================

/// Rebuilds only when the watched detail key changes.
class _DetailBuilder extends StatelessWidget {
  const _DetailBuilder({required this.detailKey, required this.builder});

  final String detailKey;
  final Widget Function(
    BuildContext context,
    AddPropertyBloc bloc,
    dynamic value,
  )
  builder;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      buildWhen: (prev, curr) =>
          prev.model.typeDetails[detailKey] !=
              curr.model.typeDetails[detailKey] ||
          prev.fieldErrors[detailKey] != curr.fieldErrors[detailKey],
      builder: (context, state) => builder(
        context,
        AddPropertyBloc.get(context),
        state.model.typeDetails[detailKey],
      ),
    );
  }
}

class _DetailDropdown extends StatelessWidget {
  const _DetailDropdown({
    required this.label,
    required this.detailKey,
    required this.options,
  });

  final String label;
  final String detailKey;
  final List<String> options;

  @override
  Widget build(BuildContext context) {
    return _DetailBuilder(
      detailKey: detailKey,
      builder: (context, bloc, value) => DropdownFieldWidget(
        label: label,
        items: options,
        hint: AppStrings.chooseLabel(label),
        selectedValue: value?.toString(),
        errorText: AddPropertyBloc.get(context).state.fieldErrors[detailKey],
        onChanged: (v) {
          if (v != null) bloc.add(SetDetailFieldEvent(detailKey, v));
        },
      ),
    );
  }
}

/// Numeric dropdown that stores an `int` so the API receives a number.
class _DetailNumberDropdown extends StatelessWidget {
  const _DetailNumberDropdown({
    required this.label,
    required this.detailKey,
    required this.options,
  });

  final String label;
  final String detailKey;
  final List<String> options;

  @override
  Widget build(BuildContext context) {
    return _DetailBuilder(
      detailKey: detailKey,
      builder: (context, bloc, value) => DropdownFieldWidget(
        label: label,
        items: options,
        translateItems: false,
        hint: AppStrings.chooseLabel(label),
        selectedValue: value?.toString(),
        errorText: AddPropertyBloc.get(context).state.fieldErrors[detailKey],
        onChanged: (v) {
          if (v == null) return;
          bloc.add(SetDetailFieldEvent(detailKey, int.tryParse(v) ?? 0));
        },
      ),
    );
  }
}

class _DetailCounter extends StatelessWidget {
  const _DetailCounter({required this.label, required this.detailKey});

  final String label;
  final String detailKey;

  @override
  Widget build(BuildContext context) {
    return _DetailBuilder(
      detailKey: detailKey,
      builder: (context, bloc, value) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CounterFieldWidget(
            label: label,
            value: value is int ? value : 0,
            onChanged: (next) => bloc.add(
              next > (value is int ? value : 0)
                  ? IncrementDetailCounterEvent(detailKey)
                  : DecrementDetailCounterEvent(detailKey),
            ),
          ),
          FieldErrorText(detailKey),
        ],
      ),
    );
  }
}

class _DetailTextField extends StatelessWidget {
  const _DetailTextField({
    required this.label,
    required this.detailKey,
    this.unit,
    this.isNumeric = false,
  });

  final String label;
  final String detailKey;
  final String? unit;
  final bool isNumeric;

  @override
  Widget build(BuildContext context) {
    final bloc = AddPropertyBloc.get(context);
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      buildWhen: (prev, curr) =>
          prev.fieldErrors[detailKey] != curr.fieldErrors[detailKey],
      builder: (context, state) {
        return AppTextField(
          controller: bloc.detailController(detailKey),
          title: label,
          textInputType: isNumeric ? TextInputType.number : TextInputType.text,
          errorText: state.fieldErrors[detailKey],
          suffixIconWidget: unit == null
              ? null
              : Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    unit!,
                    style: TextStyle(fontSize: context.responsiveFontScale(14)),
                  ),
                ),
        );
      },
    );
  }
}

/// Single-select chip row storing one wire value.
class _DetailRadioChips extends StatelessWidget {
  const _DetailRadioChips({
    required this.label,
    required this.detailKey,
    required this.options,
  });

  final String label;
  final String detailKey;
  final List<String> options;

  @override
  Widget build(BuildContext context) {
    return _DetailBuilder(
      detailKey: detailKey,
      builder: (context, bloc, value) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RadioGroupWidget(
            label: label,
            options: options,
            selectedOption: value?.toString() ?? '',
            onChanged: (v) => bloc.add(SetDetailFieldEvent(detailKey, v)),
          ),
          FieldErrorText(detailKey),
        ],
      ),
    );
  }
}

/// Multi-select chip row storing a `List<String>` of wire values.
class _DetailMultiChips extends StatelessWidget {
  const _DetailMultiChips({
    required this.label,
    required this.detailKey,
    required this.options,
  });

  final String label;
  final String detailKey;
  final List<String> options;

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.height),
        Text(
          label,
          style: TextStyle(
            fontSize: context.responsiveFontScale(15),
            fontWeight: FontWeight.w700,
            color: tc.textPrimary,
          ),
        ),
        SizedBox(height: 12.height),
        _DetailBuilder(
          detailKey: detailKey,
          builder: (context, bloc, value) {
            final selectedValues =
                (value as List<dynamic>?)?.cast<String>() ?? const <String>[];
            return Wrap(
              spacing: 8,
              runSpacing: 8,
              children: options.map((option) {
                final selected = selectedValues.contains(option);
                return GestureDetector(
                  onTap: () =>
                      bloc.add(ToggleDetailListItemEvent(detailKey, option)),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.width,
                      vertical: 8.height,
                    ),
                    decoration: BoxDecoration(
                      color: selected
                          ? tc.primaryBrand
                          : const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (selected) ...[
                          Icon(
                            Icons.check_rounded,
                            size: 14,
                            color: tc.onPrimary,
                          ),
                          SizedBox(width: 2.width),
                        ],
                        Text(
                          option.trans,
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(12),
                            fontWeight: selected
                                ? FontWeight.w700
                                : FontWeight.w500,
                            color: selected ? tc.onPrimary : tc.primaryBrand,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}

/// Yes/no radio group stored as the `bool` the API expects.
class _DetailBoolRadio extends StatelessWidget {
  const _DetailBoolRadio({required this.label, required this.detailKey});

  final String label;
  final String detailKey;

  @override
  Widget build(BuildContext context) {
    return _DetailBuilder(
      detailKey: detailKey,
      builder: (context, bloc, value) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RadioGroupWidget(
            label: label,
            options: AppConstant.availabilityOptions,
            selectedOption: value is bool
                ? PropertyApiEnums.availabilityFromBool(value)
                : '',
            onChanged: (v) => bloc.add(
              SetDetailFieldEvent(
                detailKey,
                v == PropertyApiEnums.availabilityExist,
              ),
            ),
          ),
          FieldErrorText(detailKey),
        ],
      ),
    );
  }
}

class _DetailCheckbox extends StatelessWidget {
  const _DetailCheckbox({required this.label, required this.detailKey});

  final String label;
  final String detailKey;

  @override
  Widget build(BuildContext context) {
    return _DetailBuilder(
      detailKey: detailKey,
      builder: (context, bloc, value) => CheckboxItemWidget(
        label: label,
        isSelected: value == true,
        onTap: () => bloc.add(ToggleDetailFlagEvent(detailKey)),
      ),
    );
  }
}

class _LabeledCounterPair extends StatelessWidget {
  const _LabeledCounterPair({
    required this.firstLabel,
    required this.firstKey,
    required this.secondLabel,
    required this.secondKey,
  });

  final String firstLabel;
  final String firstKey;
  final String secondLabel;
  final String secondKey;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _DetailCounter(label: firstLabel, detailKey: firstKey),
        ),
        SizedBox(width: 12.width),
        Expanded(
          child: _DetailCounter(label: secondLabel, detailKey: secondKey),
        ),
      ],
    );
  }
}

/// Furnishing + condition tail shared by most types.
class _FurnishingAndCondition extends StatelessWidget {
  const _FurnishingAndCondition({this.includeFurnishing = true});

  final bool includeFurnishing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (includeFurnishing) ...[
          SizedBox(height: 16.height),
          _DetailRadioChips(
            label: AppStrings.furnitureCondition,
            detailKey: DetailKeys.furnishing,
            options: AppConstant.furnishingOptions,
          ),
        ],
        _DetailDropdown(
          label: AppStrings.propertyCondition,
          detailKey: DetailKeys.condition,
          options: AddPropertyBloc.conditionOptions,
        ),
      ],
    );
  }
}

// ============================================================================
// Apartment
// ============================================================================
class _ApartmentDetails extends StatelessWidget {
  const _ApartmentDetails();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PropertyDetailsSectionHeaderWidget(title: AppStrings.apartmentDetails),
        SizedBox(height: 16.height),
        _LabeledCounterPair(
          firstLabel: AppStrings.numberOfBedrooms,
          firstKey: DetailKeys.bedrooms,
          secondLabel: AppStrings.numberOfBathrooms,
          secondKey: DetailKeys.bathrooms,
        ),
        SizedBox(height: 12.height),
        _LabeledCounterPair(
          firstLabel: AppStrings.numberOfLivingRoomsOptional,
          firstKey: DetailKeys.livingRooms,
          secondLabel: AppStrings.numberOfLoungesOptional,
          secondKey: DetailKeys.councils,
        ),
        SizedBox(height: 12.height),
        _DetailTextField(
          label: AppStrings.apartmentNumberOptional,
          detailKey: DetailKeys.apartmentNumber,
        ),
        _DetailNumberDropdown(
          label: AppStrings.totalFloorsInBuilding,
          detailKey: DetailKeys.totalFloors,
          options: AddPropertyBloc.floorsCountOptions,
        ),
        _DetailNumberDropdown(
          label: AppStrings.numberOfApartmentsPerFloorOptional,
          detailKey: DetailKeys.apartmentsPerFloor,
          options: AddPropertyBloc.numberOptions(20, min: 1),
        ),
        _DetailNumberDropdown(
          label: AppStrings.floorLabel,
          detailKey: DetailKeys.floor,
          options: AddPropertyBloc.floorNumberOptions,
        ),
        const _FurnishingAndCondition(),
      ],
    );
  }
}

// ============================================================================
// Villa
// ============================================================================
class _VillaDetails extends StatelessWidget {
  const _VillaDetails();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PropertyDetailsSectionHeaderWidget(title: AppStrings.villaDetails),
        SizedBox(height: 16.height),
        _LabeledCounterPair(
          firstLabel: AppStrings.numberOfBedrooms,
          firstKey: DetailKeys.bedrooms,
          secondLabel: AppStrings.numberOfBathrooms,
          secondKey: DetailKeys.bathrooms,
        ),
        SizedBox(height: 12.height),
        _LabeledCounterPair(
          firstLabel: AppStrings.numberOfLivingRoomsOptional,
          firstKey: DetailKeys.livingRooms,
          secondLabel: AppStrings.numberOfLoungesOptional,
          secondKey: DetailKeys.councils,
        ),
        SizedBox(height: 12.height),
        _DetailCounter(
          label: AppStrings.numberOfKitchensOptional,
          detailKey: DetailKeys.kitchens,
        ),
        _DetailNumberDropdown(
          label: AppStrings.numberOfFloors,
          detailKey: DetailKeys.floorsCount,
          options: AddPropertyBloc.numberOptions(10, min: 1),
        ),
        SizedBox(height: 16.height),
        Row(
          children: [
            Expanded(
              child: _DetailCheckbox(
                label: AppStrings.servantRoom,
                detailKey: DetailKeys.hasMaidRoom,
              ),
            ),
            Expanded(
              child: _DetailCheckbox(
                label: AppStrings.driverRoom,
                detailKey: DetailKeys.hasDriverRoom,
              ),
            ),
          ],
        ),
        // _DetailTextField(
        //   label: AppStrings.developerNameOptional,
        //   detailKey: DetailKeys.developerName,
        // ),
        const _FurnishingAndCondition(),
      ],
    );
  }
}

// ============================================================================
// Floor
// ============================================================================
class _FloorDetails extends StatelessWidget {
  const _FloorDetails();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PropertyDetailsSectionHeaderWidget(title: AppStrings.floorDetails),
        SizedBox(height: 16.height),
        _LabeledCounterPair(
          firstLabel: AppStrings.numberOfBedrooms,
          firstKey: DetailKeys.bedrooms,
          secondLabel: AppStrings.numberOfBathrooms,
          secondKey: DetailKeys.bathrooms,
        ),
        SizedBox(height: 12.height),
        _LabeledCounterPair(
          firstLabel: AppStrings.numberOfLivingRoomsOptional,
          firstKey: DetailKeys.livingRooms,
          secondLabel: AppStrings.numberOfLoungesOptional,
          secondKey: DetailKeys.councils,
        ),
        _DetailDropdown(
          label: AppStrings.floorSlot,
          detailKey: DetailKeys.floorType,
          options: AddPropertyBloc.floorTypeOptions,
        ),
        const _FurnishingAndCondition(),
      ],
    );
  }
}

// ============================================================================
// Townhouse
// ============================================================================
class _TownhouseDetails extends StatelessWidget {
  const _TownhouseDetails();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PropertyDetailsSectionHeaderWidget(title: AppStrings.townhouseDetails),
        SizedBox(height: 16.height),
        _LabeledCounterPair(
          firstLabel: AppStrings.numberOfBedrooms,
          firstKey: DetailKeys.bedrooms,
          secondLabel: AppStrings.numberOfBathrooms,
          secondKey: DetailKeys.bathrooms,
        ),
        SizedBox(height: 12.height),
        _LabeledCounterPair(
          firstLabel: AppStrings.numberOfLivingRoomsOptional,
          firstKey: DetailKeys.livingRooms,
          secondLabel: AppStrings.numberOfLoungesOptional,
          secondKey: DetailKeys.councils,
        ),
        _DetailNumberDropdown(
          label: AppStrings.numberOfFloors,
          detailKey: DetailKeys.floorsCount,
          options: AddPropertyBloc.numberOptions(10, min: 1),
        ),
        _DetailTextField(
          label: AppStrings.complexName,
          detailKey: DetailKeys.compoundName,
        ),
        _DetailMultiChips(
          label: AppStrings.communityFacilities,
          detailKey: DetailKeys.communityFacilities,
          options: AddPropertyBloc.communityFacilityOptions,
        ),
        SizedBox(height: 8.height),
        _DetailBoolRadio(
          label: AppStrings.clubhouse,
          detailKey: DetailKeys.hasClubhouse,
        ),
        _DetailNumberDropdown(
          label: AppStrings.numberOfParkingSpaces,
          detailKey: DetailKeys.parkingSpots,
          options: AddPropertyBloc.numberOptions(10),
        ),
        _DetailTextField(
          label: AppStrings.communityServiceFeesOptional,
          detailKey: DetailKeys.serviceFee,
          isNumeric: true,
        ),
        // _DetailTextField(
        //   label: AppStrings.developerNameOptional,
        //   detailKey: DetailKeys.developerName,
        // ),
        const _FurnishingAndCondition(),
      ],
    );
  }
}

// ============================================================================
// Building
// ============================================================================
class _BuildingDetails extends StatelessWidget {
  const _BuildingDetails();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PropertyDetailsSectionHeaderWidget(title: AppStrings.buildingDetails),
        _DetailNumberDropdown(
          label: AppStrings.totalFloorsInBuilding,
          detailKey: DetailKeys.floorsCount,
          options: AddPropertyBloc.floorsCountOptions,
        ),
        _DetailNumberDropdown(
          label: AppStrings.totalApartments,
          detailKey: DetailKeys.totalApartments,
          options: AddPropertyBloc.unitCountOptions,
        ),
        SizedBox(height: 16.height),
        _LabeledCounterPair(
          firstLabel: AppStrings.numberOfShopsOptional,
          firstKey: DetailKeys.shopsCount,
          secondLabel: AppStrings.numberOfParkingSpaces,
          secondKey: DetailKeys.parkingSpots,
        ),
        _DetailDropdown(
          label: AppStrings.buildingClassification,
          detailKey: DetailKeys.classification,
          options: AddPropertyBloc.classificationOptions,
        ),
        // _DetailTextField(
        //   label: AppStrings.developerNameOptional,
        //   detailKey: DetailKeys.developerName,
        // ),
        const _FurnishingAndCondition(includeFurnishing: false),
      ],
    );
  }
}

// ============================================================================
// Land
// ============================================================================
class _LandDetails extends StatelessWidget {
  const _LandDetails();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PropertyDetailsSectionHeaderWidget(title: AppStrings.landDetails),
        _DetailDropdown(
          label: AppStrings.landClassification,
          detailKey: DetailKeys.classification,
          options: AddPropertyBloc.classificationOptions,
        ),
        _DetailTextField(
          label: AppStrings.plotNumberOptional,
          detailKey: DetailKeys.plotNumber,
        ),
        _DetailTextField(
          label: AppStrings.planNumberOptional,
          detailKey: DetailKeys.planNumber,
        ),
        SizedBox(height: 16.height),
        _SectionTitle(title: AppStrings.landDimensions),
        Row(
          children: [
            Expanded(
              child: _DetailTextField(
                label: AppStrings.dimensionNorth,
                detailKey: DetailKeys.dimensionNorth,
                isNumeric: true,
                unit: AppStrings.mesurement,
              ),
            ),
            SizedBox(width: 12.width),
            Expanded(
              child: _DetailTextField(
                label: AppStrings.dimensionSouth,
                detailKey: DetailKeys.dimensionSouth,
                isNumeric: true,
                unit: AppStrings.mesurement,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: _DetailTextField(
                label: AppStrings.dimensionEast,
                detailKey: DetailKeys.dimensionEast,
                isNumeric: true,
                unit: AppStrings.mesurement,
              ),
            ),
            SizedBox(width: 12.width),
            Expanded(
              child: _DetailTextField(
                label: AppStrings.dimensionWest,
                detailKey: DetailKeys.dimensionWest,
                isNumeric: true,
                unit: AppStrings.mesurement,
              ),
            ),
          ],
        ),
        _DetailTextField(
          label: AppStrings.allowedConstructionRatio,
          detailKey: DetailKeys.buildingRatio,
          isNumeric: true,
          unit: '%',
        ),
        _DetailNumberDropdown(
          label: AppStrings.allowedNumberOfFloors,
          detailKey: DetailKeys.allowedFloors,
          options: AddPropertyBloc.numberOptions(50, min: 1),
        ),
        _DetailMultiChips(
          label: AppStrings.availableServices,
          detailKey: DetailKeys.services,
          options: AddPropertyBloc.landServiceOptions,
        ),
      ],
    );
  }
}

// ============================================================================
// Rest house
// ============================================================================
class _RestHouseDetails extends StatelessWidget {
  const _RestHouseDetails();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PropertyDetailsSectionHeaderWidget(title: AppStrings.restHouseDetails),
        SizedBox(height: 16.height),
        _LabeledCounterPair(
          firstLabel: AppStrings.numberOfBedrooms,
          firstKey: DetailKeys.bedrooms,
          secondLabel: AppStrings.numberOfBathrooms,
          secondKey: DetailKeys.bathrooms,
        ),
        SizedBox(height: 12.height),
        _LabeledCounterPair(
          firstLabel: AppStrings.numberOfLivingRoomsOptional,
          firstKey: DetailKeys.livingRooms,
          secondLabel: AppStrings.numberOfLoungesOptional,
          secondKey: DetailKeys.councils,
        ),
        SizedBox(height: 16.height),
        _DetailBoolRadio(
          label: AppStrings.hasGarden,
          detailKey: DetailKeys.hasGarden,
        ),
        SizedBox(height: 12.height),
        _DetailBoolRadio(
          label: AppStrings.hasPool,
          detailKey: DetailKeys.hasPool,
        ),
        const _FurnishingAndCondition(includeFurnishing: false),
      ],
    );
  }
}

// ============================================================================
// Tower
// ============================================================================
class _TowerDetails extends StatelessWidget {
  const _TowerDetails();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PropertyDetailsSectionHeaderWidget(title: AppStrings.towerDetails),
        _DetailTextField(
          label: AppStrings.towerName,
          detailKey: DetailKeys.name,
        ),
        _DetailNumberDropdown(
          label: AppStrings.totalFloorsInBuilding,
          detailKey: DetailKeys.floorsCount,
          options: AddPropertyBloc.floorsCountOptions,
        ),
        _DetailDropdown(
          label: AppStrings.towerClassification,
          detailKey: DetailKeys.classification,
          options: AddPropertyBloc.towerClassificationOptions,
        ),
        _DetailTextField(
          label: AppStrings.totalUnits,
          detailKey: DetailKeys.totalUnits,
          isNumeric: true,
        ),
        _DetailTextField(
          label: AppStrings.numberOfElevators,
          detailKey: DetailKeys.elevatorsCount,
          isNumeric: true,
        ),
        _DetailNumberDropdown(
          label: AppStrings.parkingFloors,
          detailKey: DetailKeys.parkingFloors,
          options: AddPropertyBloc.parkingFloorOptions,
        ),
        _DetailTextField(
          label: AppStrings.totalParkingSpaces,
          detailKey: DetailKeys.totalParking,
          isNumeric: true,
        ),
        _DetailMultiChips(
          label: AppStrings.facilities,
          detailKey: DetailKeys.amenities,
          options: AddPropertyBloc.towerAmenityOptions,
        ),
        _DetailMultiChips(
          label: AppStrings.view,
          detailKey: DetailKeys.views,
          options: AddPropertyBloc.viewOptions,
        ),
        _DetailTextField(
          label: AppStrings.yearBuilt,
          detailKey: DetailKeys.yearBuilt,
          isNumeric: true,
        ),
        // _DetailTextField(
        //   label: AppStrings.developerNameOptional,
        //   detailKey: DetailKeys.developerName,
        // ),
        const _FurnishingAndCondition(includeFurnishing: false),
      ],
    );
  }
}

// ============================================================================
// Shop
// ============================================================================
class _ShopDetails extends StatelessWidget {
  const _ShopDetails();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PropertyDetailsSectionHeaderWidget(title: AppStrings.shopDetails),
        _DetailTextField(
          label: AppStrings.frontagWidth,
          detailKey: DetailKeys.frontWidth,
          isNumeric: true,
          unit: AppStrings.mesurement,
        ),
        _DetailDropdown(
          label: AppStrings.location,
          detailKey: DetailKeys.locationType,
          options: AddPropertyBloc.shopLocationOptions,
        ),
        _DetailTextField(
          label: AppStrings.mallName,
          detailKey: DetailKeys.mallName,
        ),
        _DetailMultiChips(
          label: AppStrings.facilities,
          detailKey: DetailKeys.facilities,
          options: AddPropertyBloc.shopFacilityOptions,
        ),
        _DetailMultiChips(
          label: AppStrings.shopActivities,
          detailKey: DetailKeys.activities,
          options: AddPropertyBloc.shopActivityOptions,
        ),
        const _FurnishingAndCondition(includeFurnishing: false),
      ],
    );
  }
}

// ============================================================================
// Office
// ============================================================================
class _OfficeDetails extends StatelessWidget {
  const _OfficeDetails();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PropertyDetailsSectionHeaderWidget(title: AppStrings.officeDetails),
        _DetailNumberDropdown(
          label: AppStrings.floorLabel,
          detailKey: DetailKeys.floor,
          options: AddPropertyBloc.floorNumberOptions,
        ),
        SizedBox(height: 16.height),
        _LabeledCounterPair(
          firstLabel: AppStrings.numberOfRooms,
          firstKey: DetailKeys.roomsCount,
          secondLabel: AppStrings.numberOfBathrooms,
          secondKey: DetailKeys.bathrooms,
        ),
        _DetailMultiChips(
          label: AppStrings.facilities,
          detailKey: DetailKeys.facilities,
          options: AddPropertyBloc.officeFacilityOptions,
        ),
        SizedBox(height: 12.height),
        _DetailBoolRadio(
          label: AppStrings.furnishedOffice,
          detailKey: DetailKeys.furnishedOffice,
        ),
        const _FurnishingAndCondition(),
      ],
    );
  }
}

// ============================================================================
// Farm
// ============================================================================
class _FarmDetails extends StatelessWidget {
  const _FarmDetails();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PropertyDetailsSectionHeaderWidget(title: AppStrings.farmDetails),
        _DetailTextField(
          label: AppStrings.builtArea,
          detailKey: DetailKeys.builtArea,
          isNumeric: true,
          unit: AppStrings.mesurement,
        ),
        _DetailDropdown(
          label: AppStrings.soilType,
          detailKey: DetailKeys.soilType,
          options: AddPropertyBloc.soilTypeOptions,
        ),
        _DetailMultiChips(
          label: AppStrings.waterSourceAvailability,
          detailKey: DetailKeys.waterSources,
          options: AddPropertyBloc.waterSourceOptions,
        ),
        SizedBox(height: 16.height),
        _LabeledCounterPair(
          firstLabel: AppStrings.numberOfWells,
          firstKey: DetailKeys.wellsCount,
          secondLabel: AppStrings.numberOfPalmTrees,
          secondKey: DetailKeys.palmTreesCount,
        ),
        _DetailTextField(
          label: AppStrings.wellDepth,
          detailKey: DetailKeys.wellDepth,
          isNumeric: true,
          unit: AppStrings.mesurement,
        ),
        _DetailMultiChips(
          label: AppStrings.features,
          detailKey: DetailKeys.facilities,
          options: AddPropertyBloc.farmFacilityOptions,
        ),
        _DetailTextField(
          label: AppStrings.distanceFromCity,
          detailKey: DetailKeys.distanceToCity,
          isNumeric: true,
          unit: 'km',
        ),
        const _FurnishingAndCondition(includeFurnishing: false),
      ],
    );
  }
}

// ============================================================================
// Warehouse
// ============================================================================
class _WarehouseDetails extends StatelessWidget {
  const _WarehouseDetails();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PropertyDetailsSectionHeaderWidget(title: AppStrings.warehouseDetails),
        _DetailTextField(
          label: AppStrings.internalHeight,
          detailKey: DetailKeys.height,
          isNumeric: true,
          unit: AppStrings.mesurement,
        ),
        SizedBox(height: 16.height),
        _DetailBoolRadio(
          label: AppStrings.administrativeOffices,
          detailKey: DetailKeys.hasOffice,
        ),
        SizedBox(height: 16.height),
        _DetailBoolRadio(
          label: AppStrings.externalYardForLoading,
          detailKey: DetailKeys.hasYard,
        ),
        _DetailTextField(
          label: AppStrings.yardSize,
          detailKey: DetailKeys.yardArea,
          isNumeric: true,
          unit: AppStrings.mesurement,
        ),
        _DetailTextField(
          label: AppStrings.electricityCapacity,
          detailKey: DetailKeys.electricityKW,
          isNumeric: true,
          unit: 'KW',
        ),
        _DetailCounter(
          label: AppStrings.numberOfDoors,
          detailKey: DetailKeys.doorsCount,
        ),
        _DetailDropdown(
          label: AppStrings.doorType,
          detailKey: DetailKeys.doorType,
          options: AddPropertyBloc.doorTypeOptions,
        ),
        _DetailDropdown(
          label: AppStrings.cooling,
          detailKey: DetailKeys.coolingType,
          options: AddPropertyBloc.coolingOptions,
        ),
        _DetailDropdown(
          label: AppStrings.flooring,
          detailKey: DetailKeys.floorType,
          options: AddPropertyBloc.flooringOptions,
        ),
        const _FurnishingAndCondition(includeFurnishing: false),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.height),
      child: Text(
        title,
        style: TextStyle(
          fontSize: context.responsiveFontScale(15),
          fontWeight: FontWeight.w700,
          color: AppThemeColors.of(context).textPrimary,
        ),
      ),
    );
  }
}
