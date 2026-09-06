import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/router/app_router_keys.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_appbar.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/components/confirm_delete_dialog.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/account_role.dart';
import '../../../../../../core/utils/functions/common_fun.dart';
import '../../../../../../core/utils/functions/image_picker_helper.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/router_handler.dart';
import '../../../../individual/my_property_details/view/widgets/contracts_section_widget.dart';
import '../../../property_file/view/widgets/owner_financial_section.dart';
import '../../../property_file/view/widgets/owner_property_expenses.dart';
import '../../../property_file/view/widgets/property_file_overflow_menu.dart';
import '../../controller/unit_details_bloc.dart';
import 'building_apartment_details.dart';
import 'unit_info_row.dart';

class UnitDetailsContent extends StatelessWidget {
  const UnitDetailsContent({super.key, required this.propertyName});

  final String propertyName;

  bool get _canEdit => AccountRole.isBroker;

  bool get _canManageUnit => AccountRole.isBroker || AccountRole.isOwner;

  @override
  Widget build(BuildContext context) {
    final bloc = UnitDetailsBloc.get(context);
    final colors = AppThemeColors.of(context);

    return BlocListener<UnitDetailsBloc, UnitDetailsState>(
      listenWhen: (prev, curr) =>
          (curr.isDeleted && !prev.isDeleted) ||
          (curr.saveStatus == RequestStatus.success &&
              prev.saveStatus != RequestStatus.success &&
              curr.buildingId.isNotEmpty),
      listener: (context, state) => RouterHandler.pop(context, true),
      child: BlocBuilder<UnitDetailsBloc, UnitDetailsState>(
        builder: (context, state) {
          final unit = state.unit;
          final isBuildingUnit = state.buildingId.isNotEmpty;
          final canManageBuilding = isBuildingUnit && _canManageUnit;
          final parentTitle =
              state.details?.parentProperty?.title ?? propertyName;
          return Scaffold(
            backgroundColor: colors.backgroundPrimary,
            appBar: AppAppbar(
              title: unit?.label ?? '',
              actions: [
                PropertyFileOverflowMenu(
                  showSend: !_canEdit,
                  onSend: () => RouterHandler.navigate(
                    context,
                    AppRouterKeys.chooseBroker,
                    extra: unit?.id,
                  ),
                  onDelete: () => showConfirmDeleteDialog(
                    context: context,
                    title: AppStrings.deletePropertyFile,
                    content: AppStrings.deletePropertyFileConfirmation,
                    onConfirm: () => bloc.add(const UnitDetailsDeleted()),
                  ),
                  deleteLabel: AppStrings.deletePropertyFile,
                ),
              ],
            ),
            body: unit == null
                ? const SizedBox()
                : SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(
                      16.width,
                      16.height,
                      16.width,
                      32.height,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (isBuildingUnit)
                          BuildingApartmentDetails(
                            unit: unit,
                            parentTitle: parentTitle,
                            canEdit: canManageBuilding,
                            colors: colors,
                          )
                        else ...[
                          Text(
                            unit.label,
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
                          Container(
                            padding: EdgeInsets.all(16.width),
                            decoration: BoxDecoration(
                              color: colors.cardBackground,
                              borderRadius: BorderRadius.circular(20.radius),
                              border: Border.all(color: colors.borderColor),
                            ),
                            child: Column(
                              children: [
                                UnitInfoRow(
                                  label: AppStrings.apartmentNumber,
                                  value: unit.number,
                                  leadingImage: '',
                                  showLeadingImage: false,
                                  colors: colors,
                                  isEditable: false,
                                  controller: null,
                                ),
                                if (unit.projectName.isNotEmpty ||
                                    _canEdit) ...[
                                  SizedBox(height: 10.height),
                                  UnitInfoRow(
                                    label: AppStrings.projectName,
                                    value: unit.projectName,
                                    leadingImage: AppImages.propertyShapeIcon,
                                    colors: colors,
                                    isEditable: false,
                                    controller: null,
                                  ),
                                ],
                                if (unit.area > 0) ...[
                                  SizedBox(height: 10.height),
                                  UnitInfoRow(
                                    label: AppStrings.areaLabel,
                                    value: AppStrings.areaWithUnit(unit.area),
                                    leadingImage: AppImages.totalSpaceIcon,
                                    colors: colors,
                                    isEditable: false,
                                  ),
                                ],
                                if (unit.floor > 0) ...[
                                  SizedBox(height: 10.height),
                                  UnitInfoRow(
                                    label: AppStrings.floor,
                                    value: '${unit.floor}',
                                    leadingImage: AppImages.floorIcon,
                                    colors: colors,
                                    isEditable: false,
                                  ),
                                ],
                                if (unit.rooms > 0 || unit.bathrooms > 0) ...[
                                  SizedBox(height: 10.height),
                                  Row(
                                    children: [
                                      if (unit.rooms > 0)
                                        Expanded(
                                          child: UnitInfoRow(
                                            label: AppStrings.beds,
                                            value: '${unit.rooms}',
                                            leadingImage:
                                                AppImages.bedroomIcon,
                                            colors: colors,
                                            isEditable: false,
                                          ),
                                        ),
                                      if (unit.rooms > 0 &&
                                          unit.bathrooms > 0)
                                        SizedBox(width: 10.width),
                                      if (unit.bathrooms > 0)
                                        Expanded(
                                          child: UnitInfoRow(
                                            label: AppStrings.baths,
                                            value: '${unit.bathrooms}',
                                            leadingImage:
                                                AppImages.bathroomIcon,
                                            colors: colors,
                                            isEditable: false,
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                                if (unit.monthlyRent > 0) ...[
                                  SizedBox(height: 10.height),
                                  UnitInfoRow(
                                    label:
                                        unit.listingType.toUpperCase() ==
                                            'RENT'
                                        ? AppStrings.monthlyRent
                                        : AppStrings.listingPrice,
                                    value:
                                        '${formatPrice(unit.monthlyRent)} ${AppStrings.currency}',
                                    leadingImage: AppImages.monthlyRentIcon,
                                    colors: colors,
                                    isEditable: false,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                        SizedBox(height: 20.height),
                        if (canManageBuilding)
                          AppButton(
                            onTap: () =>
                                bloc.add(const UnitDetailsSaved()),
                            text: AppStrings.saveChanges,
                            isLoading:
                                state.saveStatus == RequestStatus.loading,
                          )
                        else if (!_canEdit && !isBuildingUnit)
                          AppButton(
                            onTap: () => RouterHandler.navigate(
                              context,
                              AppRouterKeys.chooseBroker,
                              extra: unit.id,
                            ),
                            text: AppStrings.sendToBrokerProperty,
                          )
                        else if (_canEdit)
                          AppButton(
                            onTap: () =>
                                bloc.add(const UnitDetailsSaved()),
                            text: AppStrings.saveChanges,
                            isLoading:
                                state.saveStatus == RequestStatus.loading,
                          ),
                        SizedBox(height: 24.height),
                        ContractsSectionWidget(
                          contracts: state.details?.contracts ?? [],
                        ),
                        OwnerPropertyExpenses(
                          expenses: unit.expenses,
                          fileCount: state.expenseFiles.length,
                          colors: colors,
                          canEdit: isBuildingUnit ? canManageBuilding : _canEdit,
                          onConfirm: canManageBuilding
                              ? () => bloc.add(const UnitDetailsSaved())
                              : null,
                          isConfirming:
                              canManageBuilding &&
                              state.saveStatus == RequestStatus.loading,
                          descController: bloc.expenseDescController,
                          amountController: bloc.expenseAmountController,
                          onAdd: () {
                            final desc = bloc.expenseDescController.text
                                .trim();
                            final amt =
                                double.tryParse(
                                  bloc.expenseAmountController.text.trim(),
                                ) ??
                                0;
                            if (desc.isEmpty || amt <= 0) return;
                            bloc.add(
                              UnitDetailsExpenseAdded(
                                description: desc,
                                amount: amt,
                              ),
                            );
                          },
                          onRemove: (i) =>
                              bloc.add(UnitDetailsExpenseRemoved(i)),
                          onPickFiles: () async {
                            final files = await pickImages();
                            if (files == null || files.isEmpty) return;
                            bloc.add(UnitDetailsExpenseFilesPicked(files));
                          },
                        ),
                        SizedBox(height: 16.height),
                        OwnerFinancialSection(property: state.details),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
