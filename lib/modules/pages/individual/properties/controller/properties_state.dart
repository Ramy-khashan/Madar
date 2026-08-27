part of 'properties_bloc.dart';

class PropertiesState extends Equatable {
  const PropertiesState({
    this.errorMsg = '',
    this.properties = const [],
    this.propertiesStatus = RequestStatus.init,
    this.totalCount = 0,
    this.isLoadMore = false,
    this.filter,
    this.search = '',
  });
  final String errorMsg;
  final List<PropertiesItemModel> properties;
  final RequestStatus propertiesStatus;
  final int totalCount;
  final bool isLoadMore;
  final PropertyFilterModel? filter;
  final String search;

  @override
  List<Object?> get props => [
    errorMsg,
    properties,
    propertiesStatus,
    totalCount,
    isLoadMore,
    filter,
    search,
  ];

  PropertiesState copyWith({
    String? errorMsg,
    List<PropertiesItemModel>? properties,
    RequestStatus? propertiesStatus,
    int? totalCount,
    bool? isLoadMore,
    PropertyFilterModel? filter,
    String? search,
  }) => PropertiesState(
    errorMsg: errorMsg ?? this.errorMsg,
    properties: properties ?? this.properties,
    propertiesStatus: propertiesStatus ?? this.propertiesStatus,
    totalCount: totalCount ?? this.totalCount,
    isLoadMore: isLoadMore ?? this.isLoadMore,
    filter: filter ?? this.filter,
    search: search ?? this.search,
  );
}
