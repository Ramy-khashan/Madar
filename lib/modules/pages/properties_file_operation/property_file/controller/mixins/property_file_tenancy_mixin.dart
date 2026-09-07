part of '../property_file_bloc.dart';

mixin PropertyFileTenancyMixin on Bloc<PropertyFileEvent, PropertyFileState> {
  TextEditingController get tenantNameController;
  TextEditingController get tenantPhoneController;
  TextEditingController get monthlyRentController;
  TextEditingController get rentStartController;
  TextEditingController get rentEndController;

  void syncTenancy(PropertyDetailsModel details) {
    tenantNameController.text = details.tenantName ?? '';
    tenantPhoneController.text = details.tenantPhone ?? '';
    rentStartController.text = details.tenancyStartDate ?? '';
    rentEndController.text = details.tenancyEndDate ?? '';
    final rent = details.monthlyRent ?? 0;
    monthlyRentController.text = rent > 0 ? formatPrice(rent.toDouble()) : '';
  }

  void _onStatusToggled(
    PropertyFileStatusToggled event,
    Emitter<PropertyFileState> emit,
  ) {
    emit(state.copyWith(tenancyStatus: event.status));
  }

  void _onDateTypeToggled(
    PropertyFileDateTypeToggled event,
    Emitter<PropertyFileState> emit,
  ) {
    emit(state.copyWith(isHijriDate: event.isHijri));
  }

  void _onDatePicked(
    PropertyFileDatePicked event,
    Emitter<PropertyFileState> emit,
  ) {
    final formatted = HijriDate.format(event.date, hijri: state.isHijriDate);
    if (event.isStart) {
      rentStartController.text = formatted;
    } else {
      rentEndController.text = formatted;
    }
  }

  Future<void> requestDate(
    BuildContext context, {
    required bool isStart,
  }) async {
    final now = DateTime.now();
    final DateTime? picked;
    if (state.isHijriDate) {
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
    add(PropertyFileDatePicked(isStart: isStart, date: picked));
  }

  Map<String, dynamic>? tenancyBody() {
    if (state.isRented) {
      final rent = parsePrice(monthlyRentController.text);
      final name = tenantNameController.text.trim();
      final phone = tenantPhoneController.text.trim();
      final start = rentStartController.text.trim();
      final end = rentEndController.text.trim();
      if (name.isEmpty ||
          phone.isEmpty ||
          rent == null ||
          rent <= 0 ||
          start.isEmpty ||
          end.isEmpty) {
        return null;
      }
      return {
        'status': 'RENTED',
        'tenantName': name,
        'tenantPhone': phone,
        'monthlyRent': rent % 1 == 0 ? rent.toInt() : rent,
        'startDate': start,
        'endDate': end,
        'calendarType': state.isHijriDate ? 'HIJRI' : 'GREGORIAN',
      };
    }
    return {'status': 'VACANT'};
  }
}
