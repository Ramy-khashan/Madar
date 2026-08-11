import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_textfield.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import 'property_inputs/checkbox_item_widget.dart';
import 'property_inputs/counter_field_widget.dart';
import 'property_inputs/dropdown_field_widget.dart';
import 'property_inputs/radio_group_widget.dart';
import 'property_inputs/property_details_section_header.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';
import 'row_chip_item.dart';

class PropertyDetailsTypeWidget extends StatelessWidget {
  const PropertyDetailsTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      buildWhen: (prev, curr) =>
          prev.model.propertyType != curr.model.propertyType,
      builder: (context, state) {
        final propertyType = state.model.propertyType;

        return SingleChildScrollView(
          child: Column(
            children: [
              // Show property type specific details
              _buildPropertyTypeDetails(context, propertyType),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPropertyTypeDetails(BuildContext context, String? propertyType) {
    switch (propertyType) {
      case 'apartment':
        return const _ApartmentDetailsWidget();
      case 'villa':
        return const _VillaDetailsWidget();
      case 'floor':
        return const _FloorDetailsWidget();
      case 'townhouse':
        return const _TownhouseDetailsWidget();
      case 'building':
        return const _BuildingDetailsWidget();
      case 'land':
        return const _LandDetailsWidget();
      case 'rest_house':
        return const _RestHouseDetailsWidget();
      case 'tower':
        return const _TowerDetailsWidget();
      case 'shop':
        return const _ShopDetailsWidget();
      case 'office':
        return const _OfficeDetailsWidget();
      case 'farm':
        return const _FarmDetailsWidget();
      case 'warehouse':
        return const _WarehouseDetailsWidget();
      default:
        return SizedBox.shrink();
    }
  }
}

// ============================================================================
// Apartment Details
// ============================================================================
class _ApartmentDetailsWidget extends StatefulWidget {
  const _ApartmentDetailsWidget();

  @override
  State<_ApartmentDetailsWidget> createState() =>
      _ApartmentDetailsWidgetState();
}

class _ApartmentDetailsWidgetState extends State<_ApartmentDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    final bloc = AddPropertyBloc.get(context);
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      builder: (context, state) {
        return Column(
          children: [
            PropertyDetailsSectionHeaderWidget(
              title: AppStrings.apartmentDetails,
            ),
            SizedBox(height: 16.height),
            Row(
              children: [
                Expanded(
                  child: CounterFieldWidget(
                    label: AppStrings.numberOfBedrooms,
                    value: state.model.beds,
                    onChanged: (v) {
                      if (v > state.model.beds) {
                        bloc.add(const IncrementCounterEvent('beds'));
                      } else {
                        bloc.add(const DecrementCounterEvent('beds'));
                      }
                    },
                  ),
                ),
                SizedBox(width: 12.width),
                Expanded(
                  child: CounterFieldWidget(
                    label: AppStrings.numberOfBathrooms,
                    value: state.model.baths,
                    onChanged: (v) {
                      if (v > state.model.baths) {
                        bloc.add(const IncrementCounterEvent('baths'));
                      } else {
                        bloc.add(const DecrementCounterEvent('baths'));
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.height),

            Row(
              children: [
                Expanded(
                  child: CounterFieldWidget(
                    label: AppStrings.numberOfLivingRoomsOptional,
                    value: state.model.beds,
                    onChanged: (v) {
                      if (v > state.model.beds) {
                        bloc.add(const IncrementCounterEvent('beds'));
                      } else {
                        bloc.add(const DecrementCounterEvent('beds'));
                      }
                    },
                  ),
                ),
                SizedBox(width: 12.width),
                Expanded(
                  child: CounterFieldWidget(
                    label: AppStrings.numberOfLoungesOptional,
                    value: state.model.baths,
                    onChanged: (v) {
                      if (v > state.model.baths) {
                        bloc.add(const IncrementCounterEvent('baths'));
                      } else {
                        bloc.add(const DecrementCounterEvent('baths'));
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.height),
            RadioGroupWidget(
              label: AppStrings.furnitureCondition,
              options: AddPropertyBloc.furnishingOptions,
              selectedOption: state.model.furnishing ?? '',
              onChanged: (v) => bloc.add(SelectDropdownEvent('furnishing', v)),
            ),

            AppTextField(
              controller: TextEditingController(),
              title: AppStrings.apartmentNumberOptional,
            ),
            DropdownFieldWidget(
              label: AppStrings.totalFloorsInBuilding,
              items: AddPropertyBloc.apartmentFloorOptions,
              selectedValue: "10-1",
              onChanged: (v) =>
                  bloc.add(SelectDropdownEvent('condition', v ?? '')),
            ),
            DropdownFieldWidget(
              label: AppStrings.numberOfApartmentsPerFloorOptional,
              items: AddPropertyBloc.apartmentFloorOptions,
              selectedValue: "10-1",
              onChanged: (v) =>
                  bloc.add(SelectDropdownEvent('condition', v ?? '')),
            ),
            DropdownFieldWidget(
              label: AppStrings.floorLabel,
              items: AddPropertyBloc.floorOptions,
              selectedValue: "الأرضي",
              onChanged: (v) => bloc.add(SelectDropdownEvent('floor', v ?? '')),
            ),
            DropdownFieldWidget(
              label: AppStrings.propertyCondition,
              items: AddPropertyBloc.conditionOptions,
              selectedValue: state.model.condition,
              onChanged: (v) =>
                  bloc.add(SelectDropdownEvent('condition', v ?? '')),
            ),
          ],
        );
      },
    );
  }
}

// ============================================================================
// Villa Details
// ============================================================================
class _VillaDetailsWidget extends StatefulWidget {
  const _VillaDetailsWidget();

  @override
  State<_VillaDetailsWidget> createState() => _VillaDetailsWidgetState();
}

class _VillaDetailsWidgetState extends State<_VillaDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    final bloc = AddPropertyBloc.get(context);
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PropertyDetailsSectionHeaderWidget(title: AppStrings.villaDetails),
            SizedBox(height: 16.height),
            Row(
              children: [
                Expanded(
                  child: CounterFieldWidget(
                    label: AppStrings.numberOfBedrooms,
                    value: state.model.beds,
                    onChanged: (v) {
                      if (v > state.model.beds) {
                        bloc.add(const IncrementCounterEvent('beds'));
                      } else {
                        bloc.add(const DecrementCounterEvent('beds'));
                      }
                    },
                  ),
                ),
                SizedBox(width: 12.width),
                Expanded(
                  child: CounterFieldWidget(
                    label: AppStrings.numberOfBathrooms,
                    value: state.model.baths,
                    onChanged: (v) {
                      if (v > state.model.baths) {
                        bloc.add(const IncrementCounterEvent('baths'));
                      } else {
                        bloc.add(const DecrementCounterEvent('baths'));
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.height),

            Row(
              children: [
                Expanded(
                  child: CounterFieldWidget(
                    label: AppStrings.numberOfLivingRoomsOptional,
                    value: state.model.beds,
                    onChanged: (v) {
                      if (v > state.model.beds) {
                        bloc.add(const IncrementCounterEvent('beds'));
                      } else {
                        bloc.add(const DecrementCounterEvent('beds'));
                      }
                    },
                  ),
                ),
                SizedBox(width: 12.width),
                Expanded(
                  child: CounterFieldWidget(
                    label: AppStrings.numberOfLoungesOptional,
                    value: state.model.baths,
                    onChanged: (v) {
                      if (v > state.model.baths) {
                        bloc.add(const IncrementCounterEvent('baths'));
                      } else {
                        bloc.add(const DecrementCounterEvent('baths'));
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.height),
            CounterFieldWidget(
              label: AppStrings.numberOfKitchensOptional,
              value: state.model.baths,
              onChanged: (v) {
                if (v > state.model.baths) {
                  bloc.add(const IncrementCounterEvent('baths'));
                } else {
                  bloc.add(const DecrementCounterEvent('baths'));
                }
              },
            ),
            SizedBox(height: 16.height),
            Row(
              children: [
                Expanded(
                  child: CheckboxItemWidget(
                    label: AppStrings.servantRoom,
                    isSelected: false,
                    onTap: () {},
                  ),
                ),
                Expanded(
                  child: CheckboxItemWidget(
                    label: AppStrings.driverRoom,
                    isSelected: true,
                    onTap: () {},
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.height),

            RadioGroupWidget(
              label: AppStrings.furnitureCondition,
              options: AddPropertyBloc.furnishingOptions,
              selectedOption: state.model.furnishing ?? '',

              onChanged: (v) => bloc.add(SelectDropdownEvent('furnishing', v)),
            ),
            SizedBox(height: 16.height),
            DropdownFieldWidget(
              label: AppStrings.propertyCondition,
              items: AddPropertyBloc.conditionOptions,
              selectedValue: state.model.condition,
              onChanged: (v) =>
                  bloc.add(SelectDropdownEvent('condition', v ?? '')),
            ),
          ],
        );
      },
    );
  }
}

// ============================================================================
// Floor Details
// ============================================================================
class _FloorDetailsWidget extends StatelessWidget {
  const _FloorDetailsWidget();

  @override
  Widget build(BuildContext context) {
    final bloc = AddPropertyBloc.get(context);
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PropertyDetailsSectionHeaderWidget(title: AppStrings.floorDetails),
            SizedBox(height: 16.height),
            Row(
              children: [
                Expanded(
                  child: CounterFieldWidget(
                    label: AppStrings.numberOfBedrooms,
                    value: state.model.beds,
                    onChanged: (v) {
                      if (v > state.model.beds) {
                        bloc.add(const IncrementCounterEvent('beds'));
                      } else {
                        bloc.add(const DecrementCounterEvent('beds'));
                      }
                    },
                  ),
                ),
                SizedBox(width: 12.width),
                Expanded(
                  child: CounterFieldWidget(
                    label: AppStrings.numberOfBathrooms,
                    value: state.model.baths,
                    onChanged: (v) {
                      if (v > state.model.baths) {
                        bloc.add(const IncrementCounterEvent('baths'));
                      } else {
                        bloc.add(const DecrementCounterEvent('baths'));
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.height),
            CounterFieldWidget(
              label: AppStrings.numberOfLivingRoomsOptional,
              value: state.model.baths,
              onChanged: (v) {
                if (v > state.model.baths) {
                  bloc.add(const IncrementCounterEvent('baths'));
                } else {
                  bloc.add(const DecrementCounterEvent('baths'));
                }
              },
            ),
            DropdownFieldWidget(
              label: AppStrings.floorLabel,
              items: AddPropertyBloc.floorOptions,
              selectedValue: "الأرضي",
              onChanged: (v) => bloc.add(SelectDropdownEvent('floor', v ?? '')),
            ),
            SizedBox(height: 16.height),
            RadioGroupWidget(
              label: AppStrings.furnitureCondition,
              options: AddPropertyBloc.furnishingOptions,
              selectedOption: state.model.furnishing ?? '',
              onChanged: (v) => bloc.add(SelectDropdownEvent('furnishing', v)),
            ),

            DropdownFieldWidget(
              label: AppStrings.propertyCondition,
              items: AddPropertyBloc.conditionOptions,
              selectedValue: state.model.condition,
              onChanged: (v) =>
                  bloc.add(SelectDropdownEvent('condition', v ?? '')),
            ),
          ],
        );
      },
    );
  }
}

// ============================================================================
// Townhouse Details
// ============================================================================
class _TownhouseDetailsWidget extends StatelessWidget {
  const _TownhouseDetailsWidget();

  @override
  Widget build(BuildContext context) {
    final bloc = AddPropertyBloc.get(context);
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            PropertyDetailsSectionHeaderWidget(
              title: AppStrings.townhouseDetails,
            ),
            SizedBox(height: 16.height),
            Row(
              children: [
                Expanded(
                  child: CounterFieldWidget(
                    label: AppStrings.numberOfBedrooms,
                    value: state.model.beds,
                    onChanged: (v) {
                      if (v > state.model.beds) {
                        bloc.add(const IncrementCounterEvent('beds'));
                      } else {
                        bloc.add(const DecrementCounterEvent('beds'));
                      }
                    },
                  ),
                ),
                SizedBox(width: 12.width),
                Expanded(
                  child: CounterFieldWidget(
                    label: AppStrings.numberOfBathrooms,
                    value: state.model.baths,
                    onChanged: (v) {
                      if (v > state.model.baths) {
                        bloc.add(const IncrementCounterEvent('baths'));
                      } else {
                        bloc.add(const DecrementCounterEvent('baths'));
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.height),
            CounterFieldWidget(
              label: AppStrings.numberOfLivingRoomsOptional,
              value: state.model.baths,
              onChanged: (v) {
                if (v > state.model.baths) {
                  bloc.add(const IncrementCounterEvent('baths'));
                } else {
                  bloc.add(const DecrementCounterEvent('baths'));
                }
              },
            ),
            AppTextField(
              controller: TextEditingController(),
              title: AppStrings.complexName,
            ),
            SizedBox(height: 16.height),
            Text(
              AppStrings.communityFacilities,
              style: TextStyle(
                fontSize: context.responsiveFontScale(15),
                fontWeight: FontWeight.w700,
                color: AppThemeColors.of(context).textPrimary,
              ),
            ),

            SizedBox(height: 12.height),

            ChipRowItem<String>(
              options: AddPropertyBloc.amenityOptions,
              getLabel: (v) => v,
              isSelected: (v, state) => false,
              onTap: (val, context) {},
            ),
            DropdownFieldWidget(
              label: AppStrings.numberOfParkingSpaces,
              items: ['1', '2', '3', '4', '5'],
              selectedValue: "1",
              onChanged: (v) =>
                  bloc.add(SelectDropdownEvent('condition', v ?? '')),
            ),
            DropdownFieldWidget(
              label: AppStrings.communityServiceFeesOptional,
              items: AddPropertyBloc.apartmentFloorOptions,
              selectedValue: "10-1",
              onChanged: (v) =>
                  bloc.add(SelectDropdownEvent('condition', v ?? '')),
            ),
            SizedBox(height: 16.height),

            RadioGroupWidget(
              label: AppStrings.furnitureCondition,
              options: AddPropertyBloc.furnishingOptions,
              selectedOption: state.model.furnishing ?? '',
              onChanged: (v) => bloc.add(SelectDropdownEvent('furnishing', v)),
            ),

            DropdownFieldWidget(
              label: AppStrings.propertyCondition,
              items: AddPropertyBloc.conditionOptions,
              selectedValue: state.model.condition,
              onChanged: (v) =>
                  bloc.add(SelectDropdownEvent('condition', v ?? '')),
            ),
          ],
        );
      },
    );
  }
}

// ============================================================================
// Building Details
// ============================================================================
class _BuildingDetailsWidget extends StatelessWidget {
  const _BuildingDetailsWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PropertyDetailsSectionHeaderWidget(title: AppStrings.buildingDetails),
        DropdownFieldWidget(
          label: AppStrings.totalFloorsInBuilding,
          items: AddPropertyBloc.apartmentFloorOptions,
          selectedValue: "10-1",
          onChanged: (v) {},
        ),
        DropdownFieldWidget(
          label: AppStrings.totalApartments,
          items: AddPropertyBloc.apartmentFloorOptions,
          selectedValue: "10-1",
          onChanged: (v) {},
        ),
        SizedBox(height: 16.height),
        Row(
          children: [
            Expanded(
              child: CounterFieldWidget(
                label: AppStrings.numberOfShopsOptional,
                value: 1,
                onChanged: (v) {},
              ),
            ),
            SizedBox(width: 12.width),
            Expanded(
              child: CounterFieldWidget(
                label: AppStrings.numberOfParkingSpaces,
                value: 1,
                onChanged: (v) {},
              ),
            ),
          ],
        ),
        SizedBox(height: 12.height),

        DropdownFieldWidget(
          label: AppStrings.buildingClassification,
          items: AddPropertyBloc.landClassificationOptions,
          selectedValue: "سكنية",
          onChanged: (v) {},
        ),
        DropdownFieldWidget(
          label: AppStrings.propertyCondition,
          items: AddPropertyBloc.conditionOptions,
          selectedValue: "ممتاز",
          onChanged: (v) {},
        ),
      ],
    );
  }
}

// ============================================================================
// Land Details
// ============================================================================
class _LandDetailsWidget extends StatelessWidget {
  const _LandDetailsWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        PropertyDetailsSectionHeaderWidget(title: AppStrings.landDetails),
        SizedBox(height: 16.height),
        DropdownFieldWidget(
          label: AppStrings.landClassification,
          items: AddPropertyBloc.landClassificationOptions,
          selectedValue: 'سكنية',
          onChanged: (v) {},
        ),
        SizedBox(height: 16.height),
        AppTextField(
          controller: TextEditingController(),
          title: AppStrings.plotNumberOptional,
        ),
        SizedBox(height: 16.height),
        AppTextField(
          controller: TextEditingController(),
          title: AppStrings.planNumberOptional,
        ),
        SizedBox(height: 16.height),
        DropdownFieldWidget(
          label: AppStrings.facades,
          items: AddPropertyBloc.facadeOptions,
          selectedValue: 'شمالي',
          onChanged: (v) {},
        ),
        SizedBox(height: 16.height),

        AppTextField(
          controller: TextEditingController(),
          title: AppStrings.allowedConstructionRatio,
          suffixIcon: Icons.percent_rounded,
        ),
        DropdownFieldWidget(
          label: AppStrings.allowedNumberOfFloors,
          items: AddPropertyBloc.apartmentFloorOptions,
          selectedValue: "10-1",
          onChanged: (v) {},
        ),
      ],
    );
  }
}

// ============================================================================
// Rest House Details
// ============================================================================
class _RestHouseDetailsWidget extends StatefulWidget {
  const _RestHouseDetailsWidget();

  @override
  State<_RestHouseDetailsWidget> createState() =>
      _RestHouseDetailsWidgetState();
}

class _RestHouseDetailsWidgetState extends State<_RestHouseDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    final bloc = AddPropertyBloc.get(context);
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            PropertyDetailsSectionHeaderWidget(
              title: AppStrings.restHouseDetails,
            ),
            SizedBox(height: 16.height),
            Row(
              children: [
                Expanded(
                  child: CounterFieldWidget(
                    label: AppStrings.numberOfBedrooms,
                    value: state.model.beds,
                    onChanged: (v) {
                      if (v > state.model.beds) {
                        bloc.add(const IncrementCounterEvent('beds'));
                      } else {
                        bloc.add(const DecrementCounterEvent('beds'));
                      }
                    },
                  ),
                ),
                SizedBox(width: 12.width),
                Expanded(
                  child: CounterFieldWidget(
                    label: AppStrings.numberOfBathrooms,
                    value: state.model.baths,
                    onChanged: (v) {
                      if (v > state.model.baths) {
                        bloc.add(const IncrementCounterEvent('baths'));
                      } else {
                        bloc.add(const DecrementCounterEvent('baths'));
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.height),
            CounterFieldWidget(
              label: AppStrings.numberOfLivingRoomsOptional,
              value: state.model.baths,
              onChanged: (v) {
                if (v > state.model.baths) {
                  bloc.add(const IncrementCounterEvent('baths'));
                } else {
                  bloc.add(const DecrementCounterEvent('baths'));
                }
              },
            ),
          ],
        );
      },
    );
  }
}

// ============================================================================
// Tower Details
// ============================================================================
class _TowerDetailsWidget extends StatelessWidget {
  const _TowerDetailsWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PropertyDetailsSectionHeaderWidget(title: AppStrings.towerDetails),
        AppTextField(
          controller: TextEditingController(),
          title: AppStrings.towerName,
        ),
        DropdownFieldWidget(
          label: AppStrings.totalFloorsInBuilding,
          items: AddPropertyBloc.apartmentFloorOptions,
          selectedValue: '10-1',
          onChanged: (v) {},
        ),
        DropdownFieldWidget(
          label: AppStrings.towerClassification,
          items: AddPropertyBloc.landClassificationOptions,
          selectedValue: "سكنية",
          onChanged: (v) {},
        ),
        AppTextField(
          controller: TextEditingController(),
          title: AppStrings.totalUnits,
        ),
        AppTextField(
          controller: TextEditingController(),
          title: AppStrings.numberOfElevators,
        ),
        DropdownFieldWidget(
          label: AppStrings.parkingFloors,
          items: AddPropertyBloc.parkingFloorOptions,
          selectedValue: "0-5",
          onChanged: (v) {},
        ),
        AppTextField(
          controller: TextEditingController(),
          title: AppStrings.totalParkingSpaces,
        ),

        SizedBox(height: 16.height),
        Text(
          AppStrings.facilities,
          style: TextStyle(
            fontSize: context.responsiveFontScale(15),
            fontWeight: FontWeight.w700,
            color: AppThemeColors.of(context).textPrimary,
          ),
        ),

        SizedBox(height: 12.height),

        ChipRowItem<String>(
          options: AddPropertyBloc.communityAmenityOptions,
          getLabel: (v) => v,
          isSelected: (v, state) => false,
          onTap: (val, context) {},
        ),
        SizedBox(height: 8.height),

        DropdownFieldWidget(
          label: AppStrings.view,
          items: AddPropertyBloc.viewOptions,
          selectedValue: "بانورامية",
          onChanged: (v) {},
        ),
        AppTextField(
          controller: TextEditingController(),
          title: AppStrings.yearOfOperation,
        ),
        DropdownFieldWidget(
          label: AppStrings.propertyCondition,
          items: AddPropertyBloc.conditionOptions,
          selectedValue: "ممتاز",
          onChanged: (v) {},
        ),
      ],
    );
  }
}

// ============================================================================
// Shop Details
// ============================================================================
class _ShopDetailsWidget extends StatelessWidget {
  const _ShopDetailsWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PropertyDetailsSectionHeaderWidget(title: AppStrings.shopDetails),
        AppTextField(
          controller: TextEditingController(),
          title: AppStrings.frontagWidth,
        ),
        DropdownFieldWidget(
          label: AppStrings.location,
          items: AddPropertyBloc.locationOptions,
          selectedValue: "على شارع رئيسي",
          onChanged: (v) {},
        ),
        AppTextField(
          controller: TextEditingController(),
          title: AppStrings.mallName,
        ),
      ],
    );
  }
}

// ============================================================================
// Office Details
// ============================================================================
class _OfficeDetailsWidget extends StatelessWidget {
  const _OfficeDetailsWidget();

  @override
  Widget build(BuildContext context) {
    final bloc = AddPropertyBloc.get(context);
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PropertyDetailsSectionHeaderWidget(title: AppStrings.officeDetails),
            DropdownFieldWidget(
              label: AppStrings.floorLabel,
              items: AddPropertyBloc.floorOptions,
              selectedValue: "الأرضي",
              onChanged: (v) {},
            ),
            SizedBox(height: 16.height),
            Row(
              children: [
                Expanded(
                  child: CounterFieldWidget(
                    label: AppStrings.numberOfBedrooms,
                    value: state.model.beds,
                    onChanged: (v) {
                      if (v > state.model.beds) {
                        bloc.add(const IncrementCounterEvent('beds'));
                      } else {
                        bloc.add(const DecrementCounterEvent('beds'));
                      }
                    },
                  ),
                ),
                SizedBox(width: 12.width),
                Expanded(
                  child: CounterFieldWidget(
                    label: AppStrings.numberOfBathrooms,
                    value: state.model.baths,
                    onChanged: (v) {
                      if (v > state.model.baths) {
                        bloc.add(const IncrementCounterEvent('baths'));
                      } else {
                        bloc.add(const DecrementCounterEvent('baths'));
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.height),
            Text(
              AppStrings.facilities,
              style: TextStyle(
                fontSize: context.responsiveFontScale(15),
                fontWeight: FontWeight.w700,
                color: AppThemeColors.of(context).textPrimary,
              ),
            ),

            SizedBox(height: 12.height),

            ChipRowItem<String>(
              options: AddPropertyBloc.interiorAmenityOptions,
              getLabel: (v) => v,
              isSelected: (v, state) => false,
              onTap: (val, context) {},
            ),
            SizedBox(height: 12.height),
            RadioGroupWidget(
              label: AppStrings.furnitureCondition,
              options: AddPropertyBloc.furnishingOptions,
              selectedOption: state.model.furnishing ?? '',

              onChanged: (v) => bloc.add(SelectDropdownEvent('furnishing', v)),
            ),
          ],
        );
      },
    );
  }
}

// ============================================================================
// Farm Details
// ============================================================================
class _FarmDetailsWidget extends StatelessWidget {
  const _FarmDetailsWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PropertyDetailsSectionHeaderWidget(title: AppStrings.farmDetails),
        AppTextField(
          controller: TextEditingController(),
          title: AppStrings.builtArea,
          suffixIconWidget: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text("م", style: TextStyle(fontSize: 16)),
          ),
        ),
        DropdownFieldWidget(
          label: AppStrings.soilType,
          items: AddPropertyBloc.soilTypeOptions,
          selectedValue: "طينية",
          onChanged: (v) {},
        ),
        SizedBox(height: 16.height),
        Text(
          AppStrings.waterSourceAvailability,
          style: TextStyle(
            fontSize: context.responsiveFontScale(15),
            fontWeight: FontWeight.w700,
            color: AppThemeColors.of(context).textPrimary,
          ),
        ),

        SizedBox(height: 12.height),

        ChipRowItem<String>(
          options: ['بئر', 'مطق ماء'],
          getLabel: (v) => v,
          isSelected: (v, state) => false,
          onTap: (val, context) {},
        ),
        SizedBox(height: 16.height),
        Row(
          children: [
            Expanded(
              child: CounterFieldWidget(
                label: AppStrings.numberOfWells,
                value: 1,
                onChanged: (v) {},
              ),
            ),
            SizedBox(width: 12.width),
            Expanded(
              child: CounterFieldWidget(
                label: AppStrings.numberOfPalmTrees,
                value: 1,
                onChanged: (v) {},
              ),
            ),
          ],
        ),
        AppTextField(
          controller: TextEditingController(),
          title: AppStrings.wellDepth,
          suffixIconWidget: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text("م", style: TextStyle(fontSize: 16)),
          ),
        ),
        SizedBox(height: 16.height),
        Text(
          AppStrings.features,
          style: TextStyle(
            fontSize: context.responsiveFontScale(15),
            fontWeight: FontWeight.w700,
            color: AppThemeColors.of(context).textPrimary,
          ),
        ),

        SizedBox(height: 12.height),

        ChipRowItem<String>(
          options: [
            AppStrings.livestockBarns,
            AppStrings.restHouseInFarm,
            AppStrings.electricity,
            AppStrings.farmFence,
          ],
          getLabel: (v) => v,
          isSelected: (v, state) => false,
          onTap: (val, context) {},
        ),
        AppTextField(
          controller: TextEditingController(),
          title: AppStrings.distanceFromCity,
          suffixIconWidget: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text("km", style: TextStyle(fontSize: 16)),
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// Warehouse Details
// ============================================================================
class _WarehouseDetailsWidget extends StatelessWidget {
  const _WarehouseDetailsWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PropertyDetailsSectionHeaderWidget(title: AppStrings.warehouseDetails),
        AppTextField(
          controller: TextEditingController(),
          title: AppStrings.internalHeight,
        ),
        SizedBox(height: 16.height),

        RadioGroupWidget(
          label: AppStrings.administrativeOffices,
          options: AddPropertyBloc.availabilityOptions,
          selectedOption: "يوجد",
          onChanged: (v) {},
        ),
        SizedBox(height: 16.height),
        RadioGroupWidget(
          label: AppStrings.externalYardForLoading,
          options: AddPropertyBloc.availabilityOptions,
          selectedOption: "يوجد",
          onChanged: (v) {},
        ),
        AppTextField(
          controller: TextEditingController(),
          title: AppStrings.yardSize,
          suffixIconWidget: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text("م2", style: TextStyle(fontSize: 16)),
          ),
        ),
        AppTextField(
          controller: TextEditingController(),
          title: AppStrings.electricityCapacity,
          suffixIconWidget: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text("KW", style: TextStyle(fontSize: 16)),
          ),
        ),
        DropdownFieldWidget(
          label: AppStrings.doorType,
          items: AddPropertyBloc.doorTypeOptions,
          selectedValue: "عادي",
          onChanged: (v) {},
        ),
        DropdownFieldWidget(
          label: AppStrings.cooling,
          items: AddPropertyBloc.coolingOptions,
          selectedValue: "تبريد",
          onChanged: (v) {},
        ),
        DropdownFieldWidget(
          label: AppStrings.flooring,
          items: AddPropertyBloc.floorTypeOptions,
          selectedValue: "خرسانة",
          onChanged: (v) {},
        ),
      ],
    );
  }
}
