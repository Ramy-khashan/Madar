part of 'properties_map_bloc.dart';

class PropertiesMapState extends Equatable {
  final RequestStatus status;
  final List<PropertyDetailsModel> properties;
  final String errorMsg;
  final int selectedIndex;
  final bool isNearestToMe;
  final PositionModel? mapCenter;
  final PropertyFilterModel? filter;
  final String search;
  final PositionModel? pickedPosition;

  const PropertiesMapState({
    this.status = RequestStatus.init,
    this.properties = const [],
    this.errorMsg = '',
    this.selectedIndex = -1,
    this.isNearestToMe = false,
    this.mapCenter,
    this.filter,
    this.search = '',
    this.pickedPosition,
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
    PropertyFilterModel? filter,
    String? search,
    PositionModel? pickedPosition,
    bool clearPickedPosition = false,
  }) {
    return PropertiesMapState(
      status: status ?? this.status,
      properties: properties ?? this.properties,
      errorMsg: errorMsg ?? this.errorMsg,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      isNearestToMe: isNearestToMe ?? this.isNearestToMe,
      mapCenter: mapCenter ?? this.mapCenter,
      filter: filter ?? this.filter,
      search: search ?? this.search,
      pickedPosition: clearPickedPosition
          ? null
          : (pickedPosition ?? this.pickedPosition),
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
    filter,
    search,
    pickedPosition,
  ];
}
