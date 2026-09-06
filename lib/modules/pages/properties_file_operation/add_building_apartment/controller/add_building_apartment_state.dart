part of 'add_building_apartment_bloc.dart';

class AddBuildingApartmentState extends Equatable {
  const AddBuildingApartmentState({
    this.status = 'VACANT',
    this.isHijri = false,
    this.statusRequest = RequestStatus.init,
    this.errorMessage,
  });

  final String status;
  final bool isHijri;
  final RequestStatus statusRequest;
  final String? errorMessage;

  bool get isRented => status.toUpperCase() == 'RENTED';

  AddBuildingApartmentState copyWith({
    String? status,
    bool? isHijri,
    RequestStatus? statusRequest,
    String? errorMessage,
  }) {
    return AddBuildingApartmentState(
      status: status ?? this.status,
      isHijri: isHijri ?? this.isHijri,
      statusRequest: statusRequest ?? this.statusRequest,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, isHijri, statusRequest, errorMessage];
}
