import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../auction/add_auction_property/model/property_details.dart';

part 'add_residential_project_event.dart';
part 'add_residential_project_state.dart';

class AddResidentialProjectBloc
    extends Bloc<AddResidentialProjectEvent, AddResidentialProjectState> {
  AddResidentialProjectBloc() : super(const AddResidentialProjectState()) {
    on<AddResidentialPropertyTypeChanged>(_onPropertyTypeChanged);
    on<AddResidentialManagerToggled>(_onManagerToggled);
    on<AddResidentialPickDateRequested>(_onPickDateRequested);
    on<AddResidentialDatePicked>(_onDatePicked);
    on<AddResidentialDatePickCancelled>(_onDatePickCancelled);
    on<AddResidentialSendToManagerRequested>(_onSendToManagerRequested);
    on<AddResidentialManagerLoginResult>(_onManagerLoginResult);
    on<AddResidentialSuccessDialogDismissed>(_onSuccessDialogDismissed);
    on<AddResidentialSubmit>(_onSubmit);
    on<AddResidentialReset>(_onReset);
  }

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final locationController = TextEditingController();
  final budgetController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final phasesController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  List<CounterItemModel> get counterItems => [
    CounterItemModel(
      label: AppStrings.roomsLabel,
      icon: AppImages.bedroomIcon,
      controller: TextEditingController(),
    ),
    CounterItemModel(
      label: AppStrings.bathroomsLabel,
      icon: AppImages.bathroomIcon,

      controller: TextEditingController(),
    ),
    CounterItemModel(
      label: AppStrings.areaLabel,

      icon: AppImages.totalSpaceIcon,
      suffix: AppStrings.mesurement,
      controller: TextEditingController(),
    ),
    CounterItemModel(
      label: AppStrings.balconyLabel,
      icon: AppImages.balconyIcon,
      controller: TextEditingController(),
    ),
    CounterItemModel(
      label: AppStrings.floorLabel,
      icon: AppImages.floorIcon,
      controller: TextEditingController(),
    ),
    CounterItemModel(
      label: AppStrings.propertyNumberLabel,
      icon: AppImages.propertyNumberIcon,
      controller: TextEditingController(),
    ),
  ];

  @override
  Future<void> close() {
    nameController.dispose();
    locationController.dispose();
    budgetController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    phasesController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    phoneController.dispose();
    return super.close();
  }

  void _onPropertyTypeChanged(
    AddResidentialPropertyTypeChanged event,
    Emitter<AddResidentialProjectState> emit,
  ) {
    emit(state.copyWith(selectedPropertyType: event.propertyType));
  }

  void _onManagerToggled(
    AddResidentialManagerToggled event,
    Emitter<AddResidentialProjectState> emit,
  ) {
    emit(state.copyWith(showManagerForm: event.show));
  }

  void _onPickDateRequested(
    AddResidentialPickDateRequested event,
    Emitter<AddResidentialProjectState> emit,
  ) {
    emit(state.copyWith(pendingDateField: event.field));
  }

  void _onDatePicked(
    AddResidentialDatePicked event,
    Emitter<AddResidentialProjectState> emit,
  ) {
    if (event.field == ResidentialDateField.start) {
      startDateController.text = event.date;
    } else {
      endDateController.text = event.date;
    }
    emit(state.copyWith(pendingDateField: ResidentialDateField.none));
  }

  void _onDatePickCancelled(
    AddResidentialDatePickCancelled event,
    Emitter<AddResidentialProjectState> emit,
  ) {
    emit(state.copyWith(pendingDateField: ResidentialDateField.none));
  }

  void _onSendToManagerRequested(
    AddResidentialSendToManagerRequested event,
    Emitter<AddResidentialProjectState> emit,
  ) {
    emit(
      state.copyWith(dialogAction: ResidentialDialogAction.showManagerLogin),
    );
  }

  void _onManagerLoginResult(
    AddResidentialManagerLoginResult event,
    Emitter<AddResidentialProjectState> emit,
  ) {
    emit(
      state.copyWith(
        dialogAction: event.success
            ? ResidentialDialogAction.showSuccess
            : ResidentialDialogAction.none,
      ),
    );
  }

  void _onSuccessDialogDismissed(
    AddResidentialSuccessDialogDismissed event,
    Emitter<AddResidentialProjectState> emit,
  ) {
    emit(state.copyWith(dialogAction: ResidentialDialogAction.none));
  }

  Future<void> _onSubmit(
    AddResidentialSubmit event,
    Emitter<AddResidentialProjectState> emit,
  ) async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    emit(state.copyWith(submitStatus: RequestStatus.loading));
    await Future<void>.delayed(const Duration(seconds: 1));
    emit(state.copyWith(submitStatus: RequestStatus.success));
  }

  void _onReset(
    AddResidentialReset event,
    Emitter<AddResidentialProjectState> emit,
  ) {
    emit(const AddResidentialProjectState());
  }
}
