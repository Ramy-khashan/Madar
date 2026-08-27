part of 'property_details_bloc.dart';

class PropertyDetailsState extends Equatable {
  const PropertyDetailsState({
    this.property,
    this.isSavedWishList = false,
    this.getDetailsStatus = RequestStatus.init,
    this.errorMsg = '',
    this.submitStatus = RequestStatus.init,
    this.submitMessage = '',
    this.existingRequest,
    this.brokerRequestId,
    this.adLicenseNumber,
    this.actionStatus = RequestStatus.init,
    this.actionMessage = '',
  });

  final PropertyDetailsModel? property;
  final RequestStatus getDetailsStatus;
  final String errorMsg;
  final bool isSavedWishList;
  final RequestStatus submitStatus;
  final String submitMessage;
  final MyPropertyRequestModel? existingRequest;
  final String? brokerRequestId;
  final String? adLicenseNumber;
  final RequestStatus actionStatus;
  final String actionMessage;

  bool get isBrokerRequest => (brokerRequestId ?? '').isNotEmpty;

  @override
  List<Object?> get props => [
    property,
    isSavedWishList,
    getDetailsStatus,
    errorMsg,
    submitStatus,
    submitMessage,
    existingRequest,
    brokerRequestId,
    adLicenseNumber,
    actionStatus,
    actionMessage,
  ];

  PropertyDetailsState copyWith({
    PropertyDetailsModel? property,
    RequestStatus? getDetailsStatus,
    String? errorMsg,
    bool? isSavedWishList,
    RequestStatus? submitStatus,
    String? submitMessage,
    MyPropertyRequestModel? existingRequest,
    String? brokerRequestId,
    String? adLicenseNumber,
    RequestStatus? actionStatus,
    String? actionMessage,
  }) {
    return PropertyDetailsState(
      isSavedWishList: isSavedWishList ?? this.isSavedWishList,
      property: property ?? this.property,
      getDetailsStatus: getDetailsStatus ?? this.getDetailsStatus,
      errorMsg: errorMsg ?? this.errorMsg,
      submitStatus: submitStatus ?? this.submitStatus,
      submitMessage: submitMessage ?? this.submitMessage,
      existingRequest: existingRequest ?? this.existingRequest,
      brokerRequestId: brokerRequestId ?? this.brokerRequestId,
      adLicenseNumber: adLicenseNumber ?? this.adLicenseNumber,
      actionStatus: actionStatus ?? this.actionStatus,
      actionMessage: actionMessage ?? this.actionMessage,
    );
  }
}
