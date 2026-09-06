import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/phone_number_field.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/common_fun.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../property_file/model/property_file_model.dart';
import '../../controller/unit_details_bloc.dart';
import 'building_labeled_toggle.dart';
import 'building_row_divider.dart';
import 'building_section_card.dart';
import 'unit_info_row.dart';

class BuildingApartmentDetails extends StatelessWidget {
  const BuildingApartmentDetails({
    super.key,
    required this.unit,
    required this.parentTitle,
    required this.canEdit,
    required this.colors,
  });

  final UnitModel unit;
  final String parentTitle;
  final bool canEdit;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    final bloc = UnitDetailsBloc.get(context);
    final unitId = unit.number.isNotEmpty ? unit.number : unit.label;
    final title = unitId.isEmpty
        ? AppStrings.apartmentType
        : '${AppStrings.apartmentType}($unitId)';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: context.responsiveFontScale(22),
            fontWeight: FontWeight.w700,
            color: colors.textFieldTitle,
            fontFamily: AppConstant.appHeaderFont,
          ),
        ),
        if (parentTitle.isNotEmpty)
          Text(
            parentTitle,
            style: TextStyle(
              fontSize: context.responsiveFontScale(13),
              color: colors.textSecondary,
              fontFamily: AppConstant.appFont,
            ),
          ),
        SizedBox(height: 16.height),
        BuildingSectionCard(
          colors: colors,
          children: [
            UnitInfoRow(
              label: AppStrings.apartmentNumber,
              value: unit.number,
              leadingImage: AppImages.propertyNumberIcon,
              colors: colors,
              isEditable: false,
              embedded: true,
            ),
            BuildingRowDivider(colors: colors),
            UnitInfoRow(
              label: AppStrings.areaLabel,
              value: AppStrings.areaWithUnit(unit.area),
              leadingImage: AppImages.totalSpaceIcon,
              colors: colors,
              isEditable: false,
              embedded: true,
            ),
            BuildingRowDivider(colors: colors),
            Row(
              children: [
                Expanded(
                  child: UnitInfoRow(
                    label: AppStrings.roomsLabel,
                    value: '${unit.rooms}',
                    leadingImage: AppImages.bedroomIcon,
                    colors: colors,
                    isEditable: false,
                    embedded: true,
                  ),
                ),
                SizedBox(width: 10.width),
                Expanded(
                  child: UnitInfoRow(
                    label: AppStrings.bathroomsLabel,
                    value: '${unit.bathrooms}',
                    leadingImage: AppImages.bathroomIcon,
                    colors: colors,
                    isEditable: false,
                    embedded: true,
                  ),
                ),
              ],
            ),
            BuildingRowDivider(colors: colors),
            UnitInfoRow(
              label: AppStrings.monthlyRent,
              value: unit.monthlyRent > 0 ? formatPrice(unit.monthlyRent) : '',
              leadingImage: AppImages.monthlyRentIcon,
              colors: colors,
              controller: canEdit ? bloc.monthlyRentController : null,
              isEditable: canEdit,
              embedded: true,
              keyboardType: TextInputType.number,
              inputFormatters: [ThousandsSeparatorInputFormatter()],
              suffix: AppStrings.currency,
            ),
          ],
        ),
        SizedBox(height: 20.height),
        Text(
          AppStrings.rentStatus,
          style: TextStyle(
            fontSize: context.responsiveFontScale(16),
            fontWeight: FontWeight.w700,
            color: colors.textFieldTitle,
            fontFamily: AppConstant.appHeaderFont,
          ),
        ),
        SizedBox(height: 10.height),
        BuildingSectionCard(
          colors: colors,
          children: [
            BuildingLabeledToggle(
              label: AppStrings.statusLabel,
              leftLabel: AppStrings.rentedStatus,
              rightLabel: AppStrings.vacantStatus,
              leftSelected: unit.status == UnitStatus.rented,
              enabled: canEdit,
              colors: colors,
              onLeft: () => bloc.add(
                const UnitDetailsStatusToggled(UnitStatus.rented),
              ),
              onRight: () => bloc.add(
                const UnitDetailsStatusToggled(UnitStatus.vacant),
              ),
            ),
            if (unit.status == UnitStatus.rented) ...[
              SizedBox(height: 14.height),
              BuildingLabeledToggle(
                label: AppStrings.dateType,
                leftLabel: AppStrings.hijri,
                rightLabel: AppStrings.gregorian,
                leftSelected: unit.isHijriDate,
                enabled: canEdit,
                colors: colors,
                onLeft: () =>
                    bloc.add(const UnitDetailsDateTypeToggled(true)),
                onRight: () =>
                    bloc.add(const UnitDetailsDateTypeToggled(false)),
              ),
              SizedBox(height: 8.height),
              BuildingRowDivider(colors: colors),
              UnitInfoRow(
                label: AppStrings.rentStartDate,
                value: unit.rentStartDate,
                leadingImage: AppImages.monthlyRentIcon,
                colors: colors,
                controller: canEdit ? bloc.rentStartController : null,
                isEditable: canEdit,
                embedded: true,
                readOnly: true,
                onTap: canEdit
                    ? () => bloc.requestDate(context, isStart: true)
                    : null,
              ),
              BuildingRowDivider(colors: colors),
              UnitInfoRow(
                label: AppStrings.rentEndDate,
                value: unit.rentEndDate,
                leadingImage: AppImages.monthlyRentIcon,
                colors: colors,
                controller: canEdit ? bloc.rentEndController : null,
                isEditable: canEdit,
                embedded: true,
                readOnly: true,
                onTap: canEdit
                    ? () => bloc.requestDate(context, isStart: false)
                    : null,
              ),
              BuildingRowDivider(colors: colors),
              UnitInfoRow(
                label: AppStrings.tenantNameLabel,
                value: unit.tenantName,
                leadingImage: AppImages.monthlyRentIcon,
                colors: colors,
                controller: canEdit ? bloc.tenantNameController : null,
                isEditable: canEdit,
                embedded: true,
              ),
              PhoneNumberField(
                key: ValueKey(unit.tenantPhone),
                initialCountryCode: 'SA',
                initialValue: unit.tenantPhone,
                title: AppStrings.phoneNumber,
                hint: AppStrings.enterPhoneNumber,
                enabled: canEdit,
                onChanged: (val) {
                  bloc.tenantPhoneController.text = val.completeNumber;
                },
              ),
            ],
          ],
        ),
      ],
    );
  }
}
