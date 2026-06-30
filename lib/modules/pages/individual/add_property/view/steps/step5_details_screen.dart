import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/components/app_textfield.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';
import '../widgets/counter_button_item.dart';

class AddPropertyStep5Screen extends StatelessWidget {
  const AddPropertyStep5Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    final bloc = AddPropertyBloc.get(context);
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 16.width,
              vertical: 8.height,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionLabel(label: AppStrings.basicDetails, tc: tc),
                Text(
                  AppStrings.buyerDecisionInfo,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(12),
                    color: tc.textSecondary,
                  ),
                ),
                12.height.toSizedBox,
                AppTextField(
                  controller: bloc.areaController,
                  title: AppStrings.areaSqmRequired,
                  hint: '0',
                  textInputType: TextInputType.number,
                  prefixImage: AppImages.totalSpaceIcon,
                  suffixIconWidget: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(end: 12.width),
                      child: Text(
                        AppStrings.mesurement,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(14),
                          color: tc.primaryBrand,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                12.height.toSizedBox,

                // ── Facade dropdown ───────────────────────────────────────
                _DropdownField(
                  label: AppStrings.facadeLabel,
                  field: 'facade',
                  options: AddPropertyBloc.facadeOptions,
                  getValue: (m) => m.facade,
                  buildEvent: (v) => SelectFacadeEvent(v),
                ),
                12.height.toSizedBox,

                // ── Street count ──────────────────────────────────────────
                _CounterRow(
                  image: AppImages.street,
                  label: "",
                  field: 'streetCount',
                  getValue: (s) => s.model.streetCount,
                  onIncrement: const IncrementStreetCountEvent(),
                  onDecrement: const DecrementStreetCountEvent(),
                ),
                12.height.toSizedBox,

                // ── Street width chips ────────────────────────────────────
                _SectionLabel(label: AppStrings.streetWidth, tc: tc),
                8.height.toSizedBox,
                _ChipRow<String>(
                  options: AddPropertyBloc.streetWidthOptions,
                  getLabel: (v) => v,
                  isSelected: (v, state) => state.model.streetWidth == v,
                  onTap: (v, context) => AddPropertyBloc.get(
                    context,
                  ).add(SelectStreetWidthEvent(v)),
                ),
                16.height.toSizedBox,

                // ── Property age chips ────────────────────────────────────
                _SectionLabel(label: AppStrings.propertyAgeLabel, tc: tc),
                8.height.toSizedBox,
                _ChipRow<String>(
                  options: AddPropertyBloc.propertyAgeOptions,
                  getLabel: (v) => v,
                  isSelected: (v, state) => state.model.propertyAge == v,
                  onTap: (v, context) => AddPropertyBloc.get(
                    context,
                  ).add(SelectPropertyAgeEvent(v)),
                ),
                16.height.toSizedBox,

                // ── Room counters ─────────────────────────────────────────
                Row(
                  children: [
                    Expanded(
                      child: _PropertyDetailsRow(
                        label: AppStrings.bedroomsCount,
                        field: 'beds',
                        getValue: (s) => s.model.beds,
                        onIncrement: const IncrementCounterEvent('beds'),
                        onDecrement: const DecrementCounterEvent('beds'),
                      ),
                    ),
                    23.width.toSizedBox,
                    Expanded(
                      child: _PropertyDetailsRow(
                        label: AppStrings.bathroomsCount,
                        field: 'baths',
                        getValue: (s) => s.model.baths,
                        onIncrement: const IncrementCounterEvent('baths'),
                        onDecrement: const DecrementCounterEvent('baths'),
                      ),
                    ),
                  ],
                ),
                8.height.toSizedBox,
                Row(
                  children: [
                    Expanded(
                      child: _PropertyDetailsRow(
                        label: AppStrings.majlisCountOptional,
                        field: 'lounges',
                        getValue: (s) => s.model.lounges,
                        onIncrement: const IncrementCounterEvent('lounges'),
                        onDecrement: const DecrementCounterEvent('lounges'),
                      ),
                    ),
                    23.width.toSizedBox,
                    Expanded(
                      child: _PropertyDetailsRow(
                        label: AppStrings.hallsCountOptional,
                        field: 'majlis',
                        getValue: (s) => s.model.majlis,
                        onIncrement: const IncrementCounterEvent('majlis'),
                        onDecrement: const DecrementCounterEvent('majlis'),
                      ),
                    ),
                  ],
                ),
                16.height.toSizedBox,

                // ── Optional fields ───────────────────────────────────────
                AppTextField(
                  controller: bloc.apartmentNumberController,
                  title: AppStrings.apartmentNumberOptional,
                  hint: AppStrings.enterApartmentNumber,
                  textInputType: TextInputType.number,
                ),
                12.height.toSizedBox,

                _DropdownField(
                  label: AppStrings.totalFloorsInBuilding,
                  field: 'totalFloors',
                  options: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10+'],
                  getValue: (m) => m.totalFloors,
                  buildEvent: (v) => SelectDropdownEvent('totalFloors', v),
                ),
                12.height.toSizedBox,

                _DropdownField(
                  label: AppStrings.apartmentsPerFloorOptional,
                  field: 'apartmentsPerFloor',
                  options: ['1', '2', '3', '4', '5', '6', '7', '8'],
                  getValue: (m) => m.apartmentsPerFloor,
                  buildEvent: (v) =>
                      SelectDropdownEvent('apartmentsPerFloor', v),
                ),
                12.height.toSizedBox,

                _DropdownField(
                  label: AppStrings.floorLabelShort,
                  field: 'floorLevel',
                  options: AddPropertyBloc.floorOptions,
                  getValue: (m) => m.floorLevel,
                  buildEvent: (v) => SelectDropdownEvent('floorLevel', v),
                ),
                12.height.toSizedBox,

                _DropdownField(
                  label: AppStrings.furnishingStatus,
                  field: 'furnishing',
                  options: AddPropertyBloc.furnishingOptions,
                  getValue: (m) => m.furnishing,
                  buildEvent: (v) => SelectDropdownEvent('furnishing', v),
                ),
                12.height.toSizedBox,

                _DropdownField(
                  label: AppStrings.propertyCondition,
                  field: 'condition',
                  options: AddPropertyBloc.conditionOptions,
                  getValue: (m) => m.condition,
                  buildEvent: (v) => SelectDropdownEvent('condition', v),
                ),
                12.height.toSizedBox,

                AppTextField(
                  controller: bloc.developerNameController,
                  title: AppStrings.developerNameOptional,
                  hint: AppStrings.enterDeveloperName,
                ),
                24.height.toSizedBox,

                // ── Amenities ─────────────────────────────────────────────
                _SectionLabel(label: AppStrings.amenitiesLabel, tc: tc),
                16.height.toSizedBox,
                const _AmenitiesSection(),
                20.height.toSizedBox,
              ],
            ),
          ),
        ),
        _Step5Buttons(tc: tc),
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label, required this.tc});
  final String label;
  final AppThemeColors tc;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: context.responsiveFontScale(15),
        fontWeight: FontWeight.w700,
        color: tc.textPrimary,
      ),
    );
  }
}

class _DropdownField extends StatelessWidget {
  const _DropdownField({
    required this.label,
    required this.field,
    required this.options,
    required this.getValue,
    required this.buildEvent,
  });
  final String label;
  final String field;
  final List<String> options;
  final String? Function(dynamic model) getValue;
  final AddPropertyEvent Function(String value) buildEvent;

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      builder: (context, state) {
        final selected = getValue(state.model);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: context.responsiveFontScale(13),
                fontWeight: FontWeight.w600,
                color: tc.textFieldTitle,
              ),
            ),
            8.height.toSizedBox,
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12.width,
                vertical: 4.height,
              ),
              decoration: BoxDecoration(
                color: tc.textFieldFill,

                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: tc.textFieldBorder),
              ),
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton<String>(
                    value: selected,
                    isExpanded: true,
                    hint: Text(
                      AppStrings.chooseLabel(label),
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(13),
                        color: tc.textFieldHint,
                      ),
                    ),
                    items: options
                        .map(
                          (o) => DropdownMenuItem(
                            value: o,
                            child: Text(
                              o,
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(13),
                                color: tc.textPrimary,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (v) {
                      if (v != null) {
                        AddPropertyBloc.get(context).add(buildEvent(v));
                      }
                    },
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: tc.textSecondary,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    dropdownColor: tc.cardBackground,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CounterRow extends StatelessWidget {
  const _CounterRow({
    required this.label,
    this.image,
    required this.field,
    required this.getValue,
    required this.onIncrement,
    required this.onDecrement,
  });
  final String label;
  final String? image;
  final String field;
  final int Function(AddPropertyState state) getValue;
  final AddPropertyEvent onIncrement;
  final AddPropertyEvent onDecrement;

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      builder: (context, state) {
        final value = getValue(state);
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.width,
            vertical: 16.height,
          ),
          decoration: BoxDecoration(
            color: tc.cardBackground,
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: tc.borderColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (image != null)
                ImageItem(image!, width: 24.width, height: 24.width),
              if (label.isNotEmpty)
                Text(
                  label,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(14),
                    fontWeight: FontWeight.w600,
                    color: tc.textPrimary,
                  ),
                ),
              Row(
                children: [
                  CounterButton(
                    icon: Icons.add_rounded,
                    onTap: () => AddPropertyBloc.get(context).add(onIncrement),
                    tc: tc,
                    enabled: true,
                    isPrimery: true,
                  ),
                  SizedBox(
                    width: 40,
                    child: Text(
                      '$value',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(16),
                        fontWeight: FontWeight.w700,
                        color: tc.textPrimary,
                      ),
                    ),
                  ),
                  CounterButton(
                    icon: Icons.remove_rounded,
                    onTap: () => AddPropertyBloc.get(context).add(onDecrement),
                    tc: tc,
                    enabled: value > 0,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PropertyDetailsRow extends StatelessWidget {
  const _PropertyDetailsRow({
    required this.label,

    required this.field,
    required this.getValue,
    required this.onIncrement,
    required this.onDecrement,
  });
  final String label;
  final String field;
  final int Function(AddPropertyState state) getValue;
  final AddPropertyEvent onIncrement;
  final AddPropertyEvent onDecrement;

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      builder: (context, state) {
        final value = getValue(state);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(14),
                  fontWeight: FontWeight.w600,
                  color: tc.textFieldTitle.withValues(alpha: 0.6),
                ),
              ),
            ),
            4.height.toSizedBox,
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.width,
                vertical: 16.height,
              ),
              decoration: BoxDecoration(
                color: tc.cardBackground,
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: tc.borderColor),
              ),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CounterButton(
                      icon: Icons.add_rounded,
                      onTap: () =>
                          AddPropertyBloc.get(context).add(onIncrement),
                      tc: tc,
                      enabled: true,
                      isPrimery: true,
                    ),
                    SizedBox(
                      width: 40,
                      child: Text(
                        '$value',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(16),
                          fontWeight: FontWeight.w700,
                          color: tc.textPrimary,
                        ),
                      ),
                    ),
                    CounterButton(
                      icon: Icons.remove_rounded,
                      onTap: () =>
                          AddPropertyBloc.get(context).add(onDecrement),
                      tc: tc,
                      enabled: value > 0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ChipRow<T> extends StatelessWidget {
  const _ChipRow({
    required this.options,
    required this.getLabel,
    required this.isSelected,
    required this.onTap,
  });
  final List<T> options;
  final String Function(T) getLabel;
  final bool Function(T, AddPropertyState) isSelected;
  final void Function(T, BuildContext) onTap;

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      builder: (context, state) {
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((option) {
            final selected = isSelected(option, state);
            return GestureDetector(
              onTap: () => onTap(option, context),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(
                  horizontal: 14.width,
                  vertical: 8.height,
                ),
                decoration: BoxDecoration(
                  color: selected ? tc.primaryBrand : tc.cardBackground,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: selected ? tc.primaryBrand : tc.borderColor,
                    width: selected ? 1.5 : 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (selected) ...[
                      Icon(Icons.check_rounded, size: 14, color: tc.onPrimary),
                      2.width.toSizedBox,
                    ],
                    Text(
                      getLabel(option),
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
    );
  }
}

class _AmenitiesSection extends StatelessWidget {
  const _AmenitiesSection();

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    final categories = AddPropertyBloc.amenityCategories;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: categories.map((cat) {
        final items = cat['items'] as List<Map<String, String>>;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cat['title'] as String,
              style: TextStyle(
                fontSize: context.responsiveFontScale(14),
                fontWeight: FontWeight.w600,
                color: tc.textSecondary,
              ),
            ),
            10.height.toSizedBox,
            _AmenityCategoryWrap(items: items),
            20.height.toSizedBox,
          ],
        );
      }).toList(),
    );
  }
}

class _AmenityCategoryWrap extends StatelessWidget {
  const _AmenityCategoryWrap({required this.items});
  final List<Map<String, String>> items;

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      buildWhen: (prev, curr) => prev.model.amenities != curr.model.amenities,
      builder: (context, state) {
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: items.map((item) {
            final id = item['id']!;
            final isSelected = state.model.amenities.contains(id);
            return GestureDetector(
              onTap: () =>
                  AddPropertyBloc.get(context).add(ToggleAmenityEvent(id)),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(
                  horizontal: 12.width,
                  vertical: 7.height,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? tc.primaryBrand : tc.cardBackground,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? tc.primaryBrand : tc.borderColor,
                    width: isSelected ? 1.5 : 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isSelected) ...[
                      Icon(Icons.check_rounded, size: 14, color: tc.onPrimary),
                      2.width.toSizedBox,
                    ],
                    Text(
                      item['label']!,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(12),
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: isSelected ? tc.onPrimary : tc.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _Step5Buttons extends StatelessWidget {
  const _Step5Buttons({required this.tc});
  final AppThemeColors tc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.width, 8.height, 16.width, 24.height),
      child: Row(
        children: [
          Expanded(
            child: AppButton(
              text: AppStrings.back,
              isOutline: true,
              onTap: () =>
                  AddPropertyBloc.get(context).add(const PreviousStepEvent()),
            ),
          ),
          12.width.toSizedBox,
          Expanded(
            flex: 2,

            child: AppButton(
              text: AppStrings.next,
              onTap: () =>
                  AddPropertyBloc.get(context).add(const NextStepEvent()),
            ),
          ),
        ],
      ),
    );
  }
}

extension on num {
  SizedBox get toSizedBox => SizedBox(height: toDouble(), width: toDouble());
}
