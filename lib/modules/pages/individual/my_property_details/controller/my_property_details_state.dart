part of 'my_property_details_bloc.dart';

class MyPropertyDetailsState extends Equatable {
  const MyPropertyDetailsState({
    this.property,
    this.getDetailsStatus = RequestStatus.init,
    this.errorMsg = '',
    this.currentImagePage = 0,
  });
  final PropertyDetailsModel? property;
  final RequestStatus getDetailsStatus;
  final String errorMsg;
  final int currentImagePage;

  @override
  List<Object?> get props =>
      [property, getDetailsStatus, errorMsg, currentImagePage];

  MyPropertyDetailsState copyWith({
    PropertyDetailsModel? property,
    RequestStatus? getDetailsStatus,
    String? errorMsg,
    int? currentImagePage,
  }) {
    return MyPropertyDetailsState(
      property: property ?? this.property,
      getDetailsStatus: getDetailsStatus ?? this.getDetailsStatus,
      errorMsg: errorMsg ?? this.errorMsg,
      currentImagePage: currentImagePage ?? this.currentImagePage,
    );
  }
}
