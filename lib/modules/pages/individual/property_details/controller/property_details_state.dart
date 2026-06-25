part of 'property_details_bloc.dart';

class PropertyDetailsState extends Equatable {
  const PropertyDetailsState({
    this.property,
    this.getDetailsStatus = RequestStatus.init,
    this.errorMsg = '',
    this.submitStatus = RequestStatus.init,
  });

  final PropertyBuyerModel? property;
  final RequestStatus getDetailsStatus;
  final String errorMsg;
  final RequestStatus submitStatus;

  @override
  List<Object?> get props => [property, getDetailsStatus, errorMsg, submitStatus];

  PropertyDetailsState copyWith({
    PropertyBuyerModel? property,
    RequestStatus? getDetailsStatus,
    String? errorMsg,
    RequestStatus? submitStatus,
  }) {
    return PropertyDetailsState(
      property: property ?? this.property,
      getDetailsStatus: getDetailsStatus ?? this.getDetailsStatus,
      errorMsg: errorMsg ?? this.errorMsg,
      submitStatus: submitStatus ?? this.submitStatus,
    );
  }
}
