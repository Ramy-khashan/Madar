part of 'property_details_bloc.dart';

class PropertyDetailsState extends Equatable {
  const PropertyDetailsState({
    this.property,
    this.isSavedWishList = false,
    this.getDetailsStatus = RequestStatus.init,
    this.errorMsg = '',
    this.submitStatus = RequestStatus.init,
  });

  final PropertyDetailsModel? property;
  final RequestStatus getDetailsStatus;
  final String errorMsg;
  final bool isSavedWishList;
  final RequestStatus submitStatus;

  @override
  List<Object?> get props => [
    property,
    isSavedWishList,
    getDetailsStatus,
    errorMsg,
    submitStatus,
  ];

  PropertyDetailsState copyWith({
    PropertyDetailsModel? property,
    RequestStatus? getDetailsStatus,
    String? errorMsg,
    bool? isSavedWishList,
    RequestStatus? submitStatus,
  }) {
    return PropertyDetailsState(
      isSavedWishList: isSavedWishList ?? this.isSavedWishList,
      property: property ?? this.property,
      getDetailsStatus: getDetailsStatus ?? this.getDetailsStatus,
      errorMsg: errorMsg ?? this.errorMsg,
      submitStatus: submitStatus ?? this.submitStatus,
    );
  }
}
