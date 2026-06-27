part of 'properties_bloc.dart';

class PropertiesState extends Equatable {
  const PropertiesState({
    this.errorMsg = "",
    this.properties = const [],
    this.propertiesStatus = RequestStatus.init,
    this.totalCount = 0,
    this.isLoadMore = false,
    this.filter,
  });
  final String errorMsg;
  final List<PropertyModel> properties;
  final RequestStatus propertiesStatus;
  final int totalCount;
  final bool isLoadMore;
  final PropertyFilterModel? filter;

  @override
  List<Object?> get props => [
    errorMsg,
    properties,
    propertiesStatus,
    totalCount,
    isLoadMore,
    filter,
  ];

  PropertiesState copyWith({
    String? errorMsg,
    List<PropertyModel>? properties,
    RequestStatus? propertiesStatus,
    int? totalCount,
    bool? isLoadMore,
    PropertyFilterModel? filter,
  }) => PropertiesState(
    errorMsg: errorMsg ?? this.errorMsg,
    properties: properties ?? this.properties,
    propertiesStatus: propertiesStatus ?? this.propertiesStatus,
    totalCount: totalCount ?? this.totalCount,
    isLoadMore: isLoadMore ?? this.isLoadMore,
    filter: filter ?? this.filter,
  );
}
