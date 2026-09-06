import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/app_appbar.dart';
import '../../../../../core/components/app_button.dart';
import '../../../../../core/components/app_textfield.dart';
import '../../../../../core/components/phone_number_field.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../../../../../core/utils/functions/router_handler.dart';
import '../controller/add_building_apartment_bloc.dart';
import 'widgets/apartment_calendar_toggle.dart';
import 'widgets/apartment_status_chip.dart';

class AddBuildingApartmentView extends StatelessWidget {
  const AddBuildingApartmentView({super.key, required this.buildingName});

  final String buildingName;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    final bloc = AddBuildingApartmentBloc.get(context);
    return BlocListener<AddBuildingApartmentBloc, AddBuildingApartmentState>(
      listenWhen: (prev, curr) =>
          prev.statusRequest != curr.statusRequest &&
          curr.statusRequest == RequestStatus.success,
      listener: (context, state) => RouterHandler.pop(context, true),
      child: Scaffold(
        backgroundColor: colors.backgroundPrimary,
        appBar: AppAppbar(title: AppStrings.addApartmentToBuilding),
        body: SafeArea(
          child: BlocBuilder<AddBuildingApartmentBloc, AddBuildingApartmentState>(
            builder: (context, state) {
              return ListView(
                padding: EdgeInsets.fromLTRB(16.width, 12.height, 16.width, 24.height),
                children: [
                  if (buildingName.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(bottom: 12.height),
                      child: Text(
                        buildingName,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(14),
                          color: colors.textSecondary,
                        ),
                      ),
                    ),
                  AppTextField(
                    controller: bloc.unitNumberController,
                    title: AppStrings.apartmentNumber,
                    hint: AppStrings.enterApartmentNumber,
                    textInputType: TextInputType.text,
                  ),
                  AppTextField(
                    controller: bloc.areaController,
                    title: AppStrings.areaSqmRequired,
                    hint: AppStrings.areaSqmRequired,
                    textInputType: TextInputType.number,
                  ),
                  AppTextField(
                    controller: bloc.roomsController,
                    title: AppStrings.numberOfRooms,
                    hint: AppStrings.numberOfRooms,
                    textInputType: TextInputType.number,
                  ),
                  AppTextField(
                    controller: bloc.bathroomsController,
                    title: AppStrings.numberOfBathrooms,
                    hint: AppStrings.numberOfBathrooms,
                    textInputType: TextInputType.number,
                  ),
                  SizedBox(height: 8.height),
                  Text(
                    AppStrings.unitStatus,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(13),
                      fontWeight: FontWeight.w600,
                      color: colors.textFieldTitle,
                    ),
                  ),
                  SizedBox(height: 8.height),
                  Row(
                    children: [
                      ApartmentStatusChip(
                        label: AppStrings.vacantStatus,
                        selected: !state.isRented,
                        onTap: () => bloc.add(
                          const AddApartmentStatusChanged('VACANT'),
                        ),
                      ),
                      SizedBox(width: 8.width),
                      ApartmentStatusChip(
                        label: AppStrings.rentedStatus,
                        selected: state.isRented,
                        onTap: () => bloc.add(
                          const AddApartmentStatusChanged('RENTED'),
                        ),
                      ),
                    ],
                  ),
                  if (state.isRented) ...[
                    SizedBox(height: 16.height),
                    AppTextField(
                      controller: bloc.tenantNameController,
                      title: AppStrings.tenantNameLabel,
                      hint: AppStrings.tenantNameLabel,
                    ),
                    PhoneNumberField(
                      initialCountryCode: 'SA',
                      title: AppStrings.phoneNumber,
                      hint: AppStrings.enterPhoneNumber,
                      onChanged: (val) {
                        bloc.tenantPhoneController.text = val.completeNumber;
                      },
                    ),
                    AppTextField(
                      controller: bloc.rentController,
                      title: AppStrings.monthlyRent,
                      hint: AppStrings.monthlyRent,
                      textInputType: TextInputType.number,
                    ),
                    SizedBox(height: 8.height),
                    ApartmentCalendarToggle(
                      isHijri: state.isHijri,
                      onChanged: (hijri) =>
                          bloc.add(AddApartmentCalendarChanged(hijri)),
                    ),
                    SizedBox(height: 8.height),
                    AppTextField(
                      controller: bloc.startDateController,
                      title: AppStrings.contractStartLabel,
                      hint: state.isHijri
                          ? AppStrings.enterHijriDateHint
                          : AppStrings.deedDate,
                      isReadOnly: true,
                      prefixIcon: Icons.calendar_today_rounded,
                      onTapField: () =>
                          bloc.requestDate(context, isStart: true),
                    ),
                    AppTextField(
                      controller: bloc.endDateController,
                      title: AppStrings.contractEndLabel,
                      hint: state.isHijri
                          ? AppStrings.enterHijriDateHint
                          : AppStrings.deedDate,
                      isReadOnly: true,
                      prefixIcon: Icons.calendar_today_rounded,
                      onTapField: () =>
                          bloc.requestDate(context, isStart: false),
                    ),
                  ],
                  if (state.errorMessage != null &&
                      state.errorMessage!.isNotEmpty) ...[
                    SizedBox(height: 8.height),
                    Text(
                      state.errorMessage!,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: context.responsiveFontScale(12),
                      ),
                    ),
                  ],
                  SizedBox(height: 20.height),
                  AppButton(
                    text: AppStrings.addApartment,
                    isLoading: state.statusRequest == RequestStatus.loading,
                    onTap: () => bloc.add(const AddApartmentSubmit()),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
