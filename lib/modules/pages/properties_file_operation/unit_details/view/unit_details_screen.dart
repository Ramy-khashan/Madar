import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madar_app/core/utils/functions/preference_utils.dart';

import '../../../../../config/router/app_router_keys.dart';
import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/app_appbar.dart';
import '../../../../../core/components/app_button.dart';
import '../../../../../core/components/image_item.dart';
import '../../../../../core/utils/constants/app_colors.dart';
import '../../../../../core/utils/constants/app_constant.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_images.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/constants/storage_keys.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../../../../../core/utils/functions/router_handler.dart';
import '../../property_file/model/property_file_model.dart';
import '../controller/unit_details_bloc.dart';
import 'widgets/two_option_toggle.dart';
import 'widgets/unit_expenses_section.dart';
import 'widgets/unit_info_row.dart';

class UnitDetailsScreen extends StatelessWidget {
  const UnitDetailsScreen({
    super.key,
    required this.unit,
    required this.propertyName,
  });

  final UnitModel unit;
  final String propertyName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UnitDetailsBloc()..add(UnitDetailsInit(unit)),
      child: _UnitDetailsView(propertyName: propertyName),
    );
  }
}

class _UnitDetailsView extends StatelessWidget {
  const _UnitDetailsView({required this.propertyName});

  final String propertyName;

  @override
  Widget build(BuildContext context) {
    final bloc = UnitDetailsBloc.get(context);
    final colors = AppThemeColors.of(context);

    return BlocListener<UnitDetailsBloc, UnitDetailsState>(
      listenWhen: (prev, curr) =>
          (curr.isDeleted && !prev.isDeleted) ||
          (curr.isSentToBroker && !prev.isSentToBroker),
      listener: (context, state) {
        if (state.isDeleted) {
          Navigator.of(context).pop();
        } else if (state.isSentToBroker) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppStrings.propertySentToBrokerSuccess)),
          );
        }
      },
      child: BlocBuilder<UnitDetailsBloc, UnitDetailsState>(
        builder: (context, outerState) => Scaffold(
          backgroundColor: colors.backgroundPrimary,
          appBar: AppAppbar(
            title: outerState.unit?.label ?? '',
            actions: [
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                onSelected: (val) {
                  if (val == 'send') {
                    RouterHandler.navigate(context, AppRouterKeys.chooseBroker);
                  } else if (val == 'delete') {
                    _confirmDelete(context, bloc);
                  }
                },
                itemBuilder: (_) => [
                  PopupMenuItem(
                    value: 'send',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStrings.sendPropertyFileToBroker,
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(13),
                            color: colors.textFieldTitle,
                          ),
                        ),
                        SizedBox(width: 8.width),

                        Icon(
                          Icons.arrow_forward_ios,
                          color: colors.textFieldTitle,
                          size: 18.width,
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Text(
                          AppStrings.deletePropertyFile,
                          style: TextStyle(
                            color: AppColors.errorColor,
                            fontFamily: AppConstant.appFont,
                            fontSize: context.responsiveFontScale(13),
                          ),
                        ),
                        SizedBox(width: 8.width),

                        ImageItem(
                          AppImages.deleteIcon,
                          color: AppColors.errorColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          body: BlocBuilder<UnitDetailsBloc, UnitDetailsState>(
            builder: (context, state) {
              final unit = state.unit;
              if (unit == null) return const SizedBox();

              return SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  16.width,
                  16.height,
                  16.width,
                  32.height,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      unit.label,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(22),
                        fontWeight: FontWeight.w700,
                        color: colors.textFieldTitle,
                        fontFamily: AppConstant.appHeaderFont,
                      ),
                    ),
                    Text(
                      propertyName,
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
                            leadingImage: "",
                            showLeadingImage: false,
                            colors: colors,
                            isEditable: true,
                          ),
                          SizedBox(height: 10.height),
                          Row(
                            children: [
                              Expanded(
                                child: UnitInfoRow(
                                  label: AppStrings.areaLabel,
                                  value: AppStrings.areaWithUnit(unit.area),
                                  leadingImage: AppImages.totalSpaceIcon,
                                  colors: colors,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.height),
                          Row(
                            children: [
                              Expanded(
                                child: UnitInfoRow(
                                  label: AppStrings.beds,
                                  value: '${unit.rooms}',
                                  leadingImage: AppImages.bedroomIcon,
                                  colors: colors,
                                ),
                              ),
                              SizedBox(width: 10.width),

                              Expanded(
                                child: UnitInfoRow(
                                  label: AppStrings.baths,
                                  value: '${unit.bathrooms}',
                                  leadingImage: AppImages.bathroomIcon,
                                  colors: colors,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.height),
                          UnitInfoRow(
                            label: AppStrings.monthlyRent,
                            value:
                                '${unit.monthlyRent.toStringAsFixed(0)} ${AppStrings.currency}',
                            leadingImage: AppImages.monthlyRentIcon,
                            colors: colors,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.height),
                    if (PreferenceUtils().getString(StorageKeys.accountType) ==
                        AppConstant.business)
                      Text(
                        AppStrings.rentStatus,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(18),
                          fontWeight: FontWeight.w700,
                          color: colors.textFieldTitle,
                          fontFamily: AppConstant.appHeaderFont,
                        ),
                      ),

                    if (PreferenceUtils().getString(StorageKeys.accountType) ==
                        AppConstant.business)
                      Container(
                        margin: EdgeInsets.only(
                          top: 12.height,
                          bottom: 16.height,
                        ),
                        padding: EdgeInsets.all(16.width),
                        decoration: BoxDecoration(
                          color: colors.cardBackground,
                          borderRadius: BorderRadius.circular(20.radius),
                          border: Border.all(color: colors.borderColor),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.statusLabel,
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(13),
                                color: colors.textSecondary,
                                fontFamily: AppConstant.appFont,
                              ),
                            ),
                            SizedBox(height: 8.height),
                            TwoOptionToggle(
                              leftLabel: AppStrings.vacantStatus,
                              rightLabel: AppStrings.rentedStatus,
                              isRightSelected: unit.status == UnitStatus.rented,
                              colors: colors,
                              onChanged: (isRight) => bloc.add(
                                UnitDetailsStatusToggled(
                                  isRight
                                      ? UnitStatus.rented
                                      : UnitStatus.vacant,
                                ),
                              ),
                            ),
                            if (unit.status == UnitStatus.rented) ...[
                              SizedBox(height: 14.height),
                              Text(
                                AppStrings.dateType,
                                style: TextStyle(
                                  fontSize: context.responsiveFontScale(13),
                                  color: colors.textSecondary,
                                  fontFamily: AppConstant.appFont,
                                ),
                              ),
                              SizedBox(height: 8.height),
                              TwoOptionToggle(
                                leftLabel: AppStrings.gregorian,
                                rightLabel: AppStrings.hijri,
                                isRightSelected: unit.isHijriDate,
                                colors: colors,
                                onChanged: (isRight) => bloc.add(
                                  UnitDetailsDateTypeToggled(isRight),
                                ),
                              ),
                              SizedBox(height: 12.height),
                              UnitInfoRow(
                                label: AppStrings.rentStartDate,
                                value: unit.rentStartDate,
                                leadingImage: AppImages.updateIcon,
                                colors: colors,
                                controller: bloc.rentStartController,
                              ),
                              SizedBox(height: 10.height),
                              UnitInfoRow(
                                label: AppStrings.rentEndDate,
                                value: unit.rentEndDate,
                                leadingImage: AppImages.updateIcon,
                                colors: colors,
                                controller: bloc.rentEndController,
                              ),
                              SizedBox(height: 10.height),
                              UnitInfoRow(
                                label: AppStrings.tenantNameLabel,
                                value: unit.tenantName,
                                leadingImage: AppImages.accountIcon,
                                colors: colors,
                                controller: bloc.tenantNameController,
                              ),
                              SizedBox(height: 10.height),
                              UnitInfoRow(
                                label: AppStrings.phoneNumber,
                                value: unit.tenantPhone,
                                leadingImage: AppImages.phoneNumberIcon,
                                colors: colors,
                                controller: bloc.tenantPhoneController,
                                keyboardType: TextInputType.phone,
                              ),
                            ],
                          ],
                        ),
                      ),

                    Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            onTap: () => bloc.add(const UnitDetailsSaved()),
                            text: AppStrings.saveChanges,
                            isOutline: true,
                            isLoading:
                                state.saveStatus == RequestStatus.loading,
                          ),
                        ),
                        SizedBox(width: 10.width),
                        Expanded(
                          child: AppButton(
                            onTap: () =>
                                bloc.add(const UnitDetailsSentToBroker()),
                            text: AppStrings.sendToBrokerProperty,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.height),
                    if (PreferenceUtils().getString(StorageKeys.accountType) ==
                        AppConstant.business)
                      UnitExpensesSection(
                        expenses: unit.expenses,
                        bloc: bloc,
                        colors: colors,
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, UnitDetailsBloc bloc) {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(AppStrings.deletePropertyFile),
        content: Text(AppStrings.deletePropertyFileConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              bloc.add(const UnitDetailsDeleted());
            },
            child: Text(
              AppStrings.deleteBtn,
              style: TextStyle(color: AppColors.errorColor),
            ),
          ),
        ],
      ),
    );
  }
}
