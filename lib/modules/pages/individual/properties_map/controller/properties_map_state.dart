part of 'properties_map_bloc.dart';

class PropertiesMapState extends Equatable {
  final RequestStatus status;
  final List<PropertyDetailsModel> properties;
  final String errorMsg;
  final int selectedIndex;
  final bool isNearestToMe;
  final PositionModel? mapCenter;

  const PropertiesMapState({
    this.status = RequestStatus.init,
    this.properties = const [],
    this.errorMsg = '',
    this.selectedIndex = -1,
    this.isNearestToMe = false,
    this.mapCenter,
  });

  PropertyDetailsModel? get selectedProperty =>
      selectedIndex >= 0 && selectedIndex < properties.length
      ? properties[selectedIndex]
      : null;

  PropertiesMapState copyWith({
    RequestStatus? status,
    List<PropertyDetailsModel>? properties,
    String? errorMsg,
    int? selectedIndex,
    bool? isNearestToMe,
    PositionModel? mapCenter,
  }) {
    return PropertiesMapState(
      status: status ?? this.status,
      properties: properties ?? this.properties,
      errorMsg: errorMsg ?? this.errorMsg,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      isNearestToMe: isNearestToMe ?? this.isNearestToMe,
      mapCenter: mapCenter ?? this.mapCenter,
    );
  }

  @override
  List<Object?> get props => [
    status,
    properties,
    errorMsg,
    selectedIndex,
    isNearestToMe,
    mapCenter,
  ];
}
