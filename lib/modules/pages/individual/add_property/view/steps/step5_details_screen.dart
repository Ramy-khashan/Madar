import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madar_app/modules/pages/individual/add_property/view/widgets/title_section.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_textfield.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/translation.dart';
import '../../controller/add_property_bloc.dart';
import '../../model/add_property_validator.dart';
import '../widgets/add_property_section_label.dart';
import '../widgets/add_property_step_buttons.dart';
import '../widgets/counter_row.dart';
import '../widgets/field_error_text.dart';
import '../widgets/property_details_type_widget.dart';
import '../widgets/property_inputs/dropdown_field_widget.dart';
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
                AddPropertySectionLabel(label: AppStrings.basicDetails),
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
                      controller: bloc.areaController,
                      title: AppStrings.areaSqmRequired,
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
                8.height.toSizedBox,
                BlocBuilder<AddPropertyBloc, AddPropertyState>(
                  buildWhen: (prev, curr) =>
                      prev.model.facade != curr.model.facade ||
                      prev.fieldErrors[AddPropertyField.facade] !=
                          curr.fieldErrors[AddPropertyField.facade],
                  builder: (context, state) {
                    return DropdownFieldWidget(
                      label: AppStrings.facadeLabel,
                      items: AddPropertyBloc.facadeOptions,
                      selectedValue: state.model.facade,
                      hint: AppStrings.chooseLabel(AppStrings.facadeLabel),
                      errorText: state.fieldErrors[AddPropertyField.facade],
                      onChanged: (v) {
                        if (v != null) {
                          AddPropertyBloc.get(
                            context,
                          ).add(SelectFacadeEvent(v));
                        }
                      },
                    );
                  },
                ),
                12.height.toSizedBox,
                Text(
                  AppStrings.streetCount,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(14),
                    fontWeight: FontWeight.w600,
                    color: tc.textFieldTitle,
                  ),
                ),
                8.height.toSizedBox,

                CounterRow(
                  image: AppImages.street,
                  label: '',
                  field: 'streetCount',
                  getValue: (s) => s.model.streetCount,
                  onIncrement: const IncrementStreetCountEvent(),
                  onDecrement: const DecrementStreetCountEvent(),
                ),
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
                AddPropertySectionLabel(label: AppStrings.propertyAgeLabel),
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
                AddPropertySectionLabel(label: AppStrings.amenitiesLabel),
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
                20.height.toSizedBox,
                20.height.toSizedBox,
              ],
            ),
          ),
        ),
        const AddPropertyStepButtons(nextFlex: 2),
      ],
    );
  }
}
