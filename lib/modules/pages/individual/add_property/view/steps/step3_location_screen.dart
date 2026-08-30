import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_textfield.dart';
import '../../../../../../core/components/hijri_date_picker.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';
import '../../model/add_property_validator.dart';
import '../widgets/add_property_location_card.dart';
import '../widgets/add_property_location_map.dart';
import '../widgets/add_property_section_label.dart';
import '../widgets/add_property_step_buttons.dart';
import '../widgets/date_type_toggle.dart';
import '../widgets/deed_document_picker.dart';
import '../widgets/deed_type_selector.dart';
import '../widgets/field_error_text.dart';

class AddPropertyStep3Screen extends StatelessWidget {
  const AddPropertyStep3Screen({super.key});

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
                AddPropertySectionLabel(label: AppStrings.locationAndDeed),
                4.height.toSizedBox,
                Text(
                  AppStrings.setLocationAndDeed,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(12),
                    fontWeight: FontWeight.w400,
                    color: tc.textSecondary,
                  ),
                ),
                12.height.toSizedBox,
                AppTextField(
                  controller: bloc.locationSearchController,
                  hint: AppStrings.searchNeighborhoodHint,
                  prefixImage: AppImages.searchIcon,
                  onChanged: (v) => bloc.add(UpdateLocationEvent(v)),
                ),
                16.height.toSizedBox,
                const AddPropertyLocationMap(),
                const FieldErrorText(AddPropertyField.location),
                16.height.toSizedBox,
                BlocBuilder<AddPropertyBloc, AddPropertyState>(
                  buildWhen: (prev, curr) =>
                      prev.model.location != curr.model.location,
                  builder: (context, state) {
                    if (state.model.location == null ||
                        state.model.location!.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    return AddPropertyLocationCard(
                      location: state.model.location!,
                      tc: tc,
                    );
                  },
                ),
                AppTextField(
                  controller: bloc.buildingNumberController,
                  hint: AppStrings.buildingNumber,
                  title: AppStrings.buildingNumber,
                  textInputType: TextInputType.number,
                  prefixImage: AppImages.floor,
                ),
                12.height.toSizedBox,
                AppTextField(
                  controller: bloc.streetController,
                  hint: AppStrings.streetName,
                  title: AppStrings.streetName,
                  prefixImage: AppImages.locationDone,
                ),
                24.height.toSizedBox,
                Row(
                  children: [
                    Container(
                      width: 40.width,
                      height: 40.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppThemeColors.of(context).activeColor,
                      ),
                      child: const ImageItem(
                        AppImages.instrument,
                        width: 40,
                        height: 40,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.width),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.deed,
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(14),
                                fontWeight: FontWeight.w600,
                                color: tc.primaryBrand,
                              ),
                            ),
                            Text(
                              AppStrings.chooseDeedTypeHint,
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(12),
                                fontWeight: FontWeight.w400,
                                color: tc.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                12.height.toSizedBox,
                const DeedTypeSelector(),
                const FieldErrorText(AddPropertyField.deedType),
                BlocBuilder<AddPropertyBloc, AddPropertyState>(
                  buildWhen: (prev, curr) =>
                      prev.model.deedType != curr.model.deedType ||
                      prev.model.dateType != curr.model.dateType ||
                      prev.fieldErrors[AddPropertyField.deedNumber] !=
                          curr.fieldErrors[AddPropertyField.deedNumber] ||
                      prev.fieldErrors[AddPropertyField.deedDate] !=
                          curr.fieldErrors[AddPropertyField.deedDate] ||
                      prev.fieldErrors[AddPropertyField.customTypeName] !=
                          curr.fieldErrors[AddPropertyField.customTypeName],
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (state.model.needsDeedNumberAndDate) ...[
                          12.height.toSizedBox,
                          AppTextField(
                            controller: bloc.deedNumberController,
                            hint: AppStrings.enterDeedNumber,
                            prefixImage: AppImages.instrument,
                            title: AppStrings.deedNumber,
                            textInputType: TextInputType.number,
                            errorText:
                                state.fieldErrors[AddPropertyField.deedNumber],
                          ),
                          12.height.toSizedBox,
                          AddPropertySectionLabel(label: AppStrings.deedDate),
                          8.height.toSizedBox,
                          const DateTypeToggle(),
                          12.height.toSizedBox,
                          AppTextField(
                            controller: bloc.dateController,
                            hint: state.model.dateType == 'hijri'
                                ? AppStrings.enterHijriDateHint
                                : AppStrings.deedDate,
                            prefixIcon: Icons.calendar_today_rounded,
                            isReadOnly: true,
                            errorText:
                                state.fieldErrors[AddPropertyField.deedDate],
                            onTapField: () async {
                              final now = DateTime.now();
                              final isHijri = state.model.dateType == 'hijri';
                              final picked = isHijri
                                  ? await showHijriDatePicker(
                                      context: context,
                                      initialDate: bloc.deedPickedAt ?? now,
                                      firstDate: DateTime(1950),
                                      lastDate: now,
                                    )
                                  : await showDatePicker(
                                      context: context,
                                      initialDate: bloc.deedPickedAt ?? now,
                                      firstDate: DateTime(1950),
                                      lastDate: now,
                                    );
                              if (picked == null) return;
                              bloc.add(DeedDatePickedEvent(picked));
                            },
                          ),
                        ],
                        if (state.model.needsCustomTypeName) ...[
                          12.height.toSizedBox,
                          AppTextField(
                            controller: bloc.customTypeNameController,
                            hint: AppStrings.enterCustomDeedTypeName,
                            prefixImage: AppImages.instrument,
                            title: AppStrings.customDeedTypeName,
                            errorText: state
                                .fieldErrors[AddPropertyField.customTypeName],
                          ),
                        ],
                        if (state.model.needsOwnershipDocument) ...[
                          12.height.toSizedBox,
                          const DeedDocumentPicker(),
                        ],
                      ],
                    );
                  },
                ),
                20.height.toSizedBox,
              ],
            ),
          ),
        ),
        const AddPropertyStepButtons(),
      ],
    );
  }
}
