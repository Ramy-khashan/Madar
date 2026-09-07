import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/phone_number_field.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/common_fun.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../unit_details/view/widgets/building_labeled_toggle.dart';
import '../../../unit_details/view/widgets/building_row_divider.dart';
import '../../../unit_details/view/widgets/building_section_card.dart';
import '../../../unit_details/view/widgets/unit_info_row.dart';
import '../../controller/property_file_bloc.dart';
import '../../model/property_file_model.dart';

class OwnerPropertyTenancySection extends StatelessWidget {
  const OwnerPropertyTenancySection({
    super.key,
    required this.bloc,
    required this.state,
    required this.colors,
  });

  final PropertyFileBloc bloc;
  final PropertyFileState state;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              leftSelected: state.isRented,
              enabled: true,
              colors: colors,
              onLeft: () => bloc.add(
                const PropertyFileStatusToggled(UnitStatus.rented),
              ),
              onRight: () => bloc.add(
                const PropertyFileStatusToggled(UnitStatus.vacant),
              ),
            ),
            if (state.isRented) ...[
              SizedBox(height: 14.height),
              BuildingLabeledToggle(
                label: AppStrings.dateType,
                leftLabel: AppStrings.hijri,
                rightLabel: AppStrings.gregorian,
                leftSelected: state.isHijriDate,
                enabled: true,
                colors: colors,
                onLeft: () =>
                    bloc.add(const PropertyFileDateTypeToggled(true)),
                onRight: () =>
                    bloc.add(const PropertyFileDateTypeToggled(false)),
              ),
              SizedBox(height: 8.height),
              BuildingRowDivider(colors: colors),
              UnitInfoRow(
                label: AppStrings.monthlyRent,
                value: bloc.monthlyRentController.text,
                leadingImage: AppImages.monthlyRentIcon,
                colors: colors,
                controller: bloc.monthlyRentController,
                isEditable: true,
                embedded: true,
                keyboardType: TextInputType.number,
                inputFormatters: [ThousandsSeparatorInputFormatter()],
                suffix: AppStrings.currency,
              ),
              BuildingRowDivider(colors: colors),
              UnitInfoRow(
                label: AppStrings.rentStartDate,
                value: bloc.rentStartController.text,
                leadingImage: AppImages.monthlyRentIcon,
                colors: colors,
                controller: bloc.rentStartController,
                isEditable: true,
                embedded: true,
                readOnly: true,
                onTap: () => bloc.requestDate(context, isStart: true),
              ),
              BuildingRowDivider(colors: colors),
              UnitInfoRow(
                label: AppStrings.rentEndDate,
                value: bloc.rentEndController.text,
                leadingImage: AppImages.monthlyRentIcon,
                colors: colors,
                controller: bloc.rentEndController,
                isEditable: true,
                embedded: true,
                readOnly: true,
                onTap: () => bloc.requestDate(context, isStart: false),
              ),
              BuildingRowDivider(colors: colors),
              UnitInfoRow(
                label: AppStrings.tenantNameLabel,
                value: bloc.tenantNameController.text,
                leadingImage: AppImages.monthlyRentIcon,
                colors: colors,
                controller: bloc.tenantNameController,
                isEditable: true,
                embedded: true,
              ),
              PhoneNumberField(
                key: ValueKey(bloc.tenantPhoneController.text),
                initialCountryCode: 'SA',
                initialValue: bloc.tenantPhoneController.text,
                title: AppStrings.phoneNumber,
                hint: AppStrings.enterPhoneNumber,
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
