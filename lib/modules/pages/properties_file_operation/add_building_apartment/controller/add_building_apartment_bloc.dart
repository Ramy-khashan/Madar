import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/repository/apis/property_file_apis.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/components/hijri_date_picker.dart';
import '../../../../../core/utils/functions/common_fun.dart';
import '../../../../../core/utils/functions/hijri_date.dart';

part 'add_building_apartment_event.dart';
part 'add_building_apartment_state.dart';

class AddBuildingApartmentBloc
    extends Bloc<AddBuildingApartmentEvent, AddBuildingApartmentState> {
  AddBuildingApartmentBloc({required this.buildingId})
    : super(const AddBuildingApartmentState()) {
    on<AddApartmentStatusChanged>(_onStatusChanged);
    on<AddApartmentCalendarChanged>(_onCalendarChanged);
    on<AddApartmentDatePicked>(_onDatePicked);
    on<AddApartmentSubmit>(_onSubmit);
  }

  final String buildingId;
  final TextEditingController unitNumberController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController roomsController = TextEditingController();
  final TextEditingController bathroomsController = TextEditingController();
  final TextEditingController tenantNameController = TextEditingController();
  final TextEditingController tenantPhoneController = TextEditingController();
  final TextEditingController rentController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  static AddBuildingApartmentBloc get(BuildContext context) =>
      context.read<AddBuildingApartmentBloc>();

  void _onStatusChanged(
    AddApartmentStatusChanged event,
    Emitter<AddBuildingApartmentState> emit,
  ) {
    emit(state.copyWith(status: event.status, errorMessage: null));
  }

  void _onCalendarChanged(
    AddApartmentCalendarChanged event,
    Emitter<AddBuildingApartmentState> emit,
  ) {
    emit(state.copyWith(isHijri: event.isHijri));
  }

  void _onDatePicked(
    AddApartmentDatePicked event,
    Emitter<AddBuildingApartmentState> emit,
  ) {
    final formatted = HijriDate.format(event.date, hijri: state.isHijri);
    if (event.isStart) {
      startDateController.text = formatted;
    } else {
      endDateController.text = formatted;
    }
  }

  Future<void> requestDate(BuildContext context, {required bool isStart}) async {
    final now = DateTime.now();
    final DateTime? picked;
    if (state.isHijri) {
      picked = await showHijriDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(1950),
        lastDate: DateTime(now.year + 20),
      );
    } else {
      picked = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(1950),
        lastDate: DateTime(now.year + 20),
      );
    }
    if (picked == null) return;
    add(AddApartmentDatePicked(isStart: isStart, date: picked));
  }

  Future<void> _onSubmit(
    AddApartmentSubmit event,
    Emitter<AddBuildingApartmentState> emit,
  ) async {
    final unitNumber = unitNumberController.text.trim();
    final area = num.tryParse(areaController.text.trim());
    final rooms = int.tryParse(roomsController.text.trim());
    final bathrooms = int.tryParse(bathroomsController.text.trim());
    if (unitNumber.isEmpty || area == null || area <= 0) {
      emit(state.copyWith(errorMessage: AppStrings.pleaseCompleteApartmentData));
      return;
    }
    final body = <String, dynamic>{
      'unitNumber': unitNumber,
      'totalArea': area,
      'rooms': rooms ?? 0,
      'bathrooms': bathrooms ?? 0,
      'status': state.status,
    };
    if (state.isRented) {
      final rent = parsePrice(rentController.text);
      final start = startDateController.text.trim();
      final end = endDateController.text.trim();
      if (tenantNameController.text.trim().isEmpty ||
          tenantPhoneController.text.trim().isEmpty ||
          rent == null ||
          rent <= 0 ||
          start.isEmpty ||
          end.isEmpty) {
        emit(
          state.copyWith(errorMessage: AppStrings.pleaseCompleteTenantData),
        );
        return;
      }
      body.addAll({
        'tenantName': tenantNameController.text.trim(),
        'tenantPhone': tenantPhoneController.text.trim(),
        'monthlyRent': rent,
        'startDate': start,
        'endDate': end,
        'calendarType': state.isHijri ? 'HIJRI' : 'GREGORIAN',
      });
    }
    emit(state.copyWith(statusRequest: RequestStatus.loading, errorMessage: null));
    final result = await PropertyFileApis.createBuildingApartment(
      buildingId: buildingId,
      body: body,
    );
    if (isClosed) return;
    result.fold(
      (error) {
        AppToast(error, isError: true);
        emit(
          state.copyWith(
            statusRequest: RequestStatus.failed,
            errorMessage: error,
          ),
        );
      },
      (_) {
        AppToast(AppStrings.apartmentAddedSuccessfully);
        emit(state.copyWith(statusRequest: RequestStatus.success));
      },
    );
  }

  String formatPickedDate(DateTime date) =>
      HijriDate.format(date, hijri: state.isHijri);

  @override
  Future<void> close() {
    unitNumberController.dispose();
    areaController.dispose();
    roomsController.dispose();
    bathroomsController.dispose();
    tenantNameController.dispose();
    tenantPhoneController.dispose();
    rentController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    return super.close();
  }
}
