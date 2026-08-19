import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/components/app_textfield.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/translation.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../controller/add_property_bloc.dart';
import '../../model/add_property_validator.dart';
import '../widgets/counter_button_item.dart';
import '../widgets/field_error_text.dart';
import '../widgets/property_details_type_widget.dart';
import '../widgets/row_chip_item.dart';

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

                BlocBuilder<AddPropertyBloc, AddPropertyState>(
                  buildWhen: (prev, curr) =>
                      prev.fieldErrors[AddPropertyField.area] !=
                      curr.fieldErrors[AddPropertyField.area],
                  builder: (context, state) {
                    return AppTextField(
                      // enabled: true,
                      controller: bloc.areaController,
                      title: AppStrings.areaSqmRequired,
                      // hint: '0',
                      // textInputType: TextInputType.number,
                      prefixImage: AppImages.totalSpaceIcon,
                      errorText: state.fieldErrors[AddPropertyField.area],
                      suffixIconWidget: Padding(
                        padding: EdgeInsetsDirectional.only(top: 12.height),
                        child: Text(
                          AppStrings.mesurement,
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(14),
                            color: tc.primaryBrand,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                12.height.toSizedBox,

                _DropdownField(
                  label: AppStrings.facadeLabel,
                  field: 'facade',
                  options: AddPropertyBloc.facadeOptions,
                  getValue: (m) => m.facade,
                  buildEvent: (v) => SelectFacadeEvent(v),
                ),
                12.height.toSizedBox,

                _CounterRow(
                  image: AppImages.street,
                  label: '',
                  field: 'streetCount',
                  getValue: (s) => s.model.streetCount,
                  onIncrement: const IncrementStreetCountEvent(),
                  onDecrement: const DecrementStreetCountEvent(),
                ),
                12.height.toSizedBox,

                // _SectionLabel(label: AppStrings.streetWidth, tc: tc),
                8.height.toSizedBox,
                BlocBuilder<AddPropertyBloc, AddPropertyState>(
                  buildWhen: (prev, curr) =>
                      prev.fieldErrors[AddPropertyField.streetWidth] !=
                      curr.fieldErrors[AddPropertyField.streetWidth],
                  builder: (context, state) {
                    return AppTextField(
                      controller: bloc.streetWidthController,
                      title: AppStrings.streetWidth,
                      hint: '0',
                      textInputType: TextInputType.number,
                      errorText:
                          state.fieldErrors[AddPropertyField.streetWidth],
                    );
                  },
                ),

                16.height.toSizedBox,

                _SectionLabel(label: AppStrings.propertyAgeLabel, tc: tc),
                8.height.toSizedBox,
                ChipRowItem<String>(
                  options: AppConstant.propertyAges,
                  getLabel: (v) => v,
                  isSelected: (v, state) => state.model.propertyAge == v,
                  onTap: (v, context) => AddPropertyBloc.get(
                    context,
                  ).add(SelectPropertyAgeEvent(v)),
                ),
                const FieldErrorText(AddPropertyField.propertyAge),
                16.height.toSizedBox,
                const PropertyDetailsTypeWidget(),

                AppTextField(
                  controller: bloc.developerNameController,
                  title: AppStrings.developerNameOptional,
                ),

                16.height.toSizedBox,
                _SectionLabel(label: AppStrings.amenitiesLabel, tc: tc),
                16.height.toSizedBox,
                BlocBuilder<AddPropertyBloc, AddPropertyState>(
                  builder: (context, state) {
                    return Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: AppConstant.basicServices.map((item) {
                        final id = item;
                        final isSelected = state.model.amenities.contains(id);
                        return GestureDetector(
                          onTap: () => AddPropertyBloc.get(
                            context,
                          ).add(ToggleAmenityEvent(id)),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.width,
                              vertical: 7.height,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? tc.primaryBrand
                                  : tc.cardBackground,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected
                                    ? tc.primaryBrand
                                    : tc.borderColor,
                                width: isSelected ? 1.5 : 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (isSelected) ...[
                                  Icon(
                                    Icons.check_rounded,
                                    size: 14,
                                    color: tc.onPrimary,
                                  ),
                                  2.width.toSizedBox,
                                ],
                                Text(
                                  item.trans,
                                  style: TextStyle(
                                    fontSize: context.responsiveFontScale(12),
                                    fontWeight: isSelected
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                    color: isSelected
                                        ? tc.onPrimary
                                        : tc.textPrimary,
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

                // const _AmenitiesSection(),
                20.height.toSizedBox,

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
        final error = state.fieldErrors[field];
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
                border: Border.all(
                  color: error != null ? AppColors.errorColor : tc.textFieldBorder,
                ),
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
                              o.trans,
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
            FieldErrorText(field),
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
