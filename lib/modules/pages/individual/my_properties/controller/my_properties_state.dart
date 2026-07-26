part of 'my_properties_bloc.dart';

class MyPropertiesState extends Equatable {
  const MyPropertiesState({
    this.properties = const [],
    this.errorMsg = '',
    this.propertiesStatus = RequestStatus.init,
    this.isLoadMore = false,
    this.totalCount = 0,
  });
  final List<PortfolioPropertyModel> properties;
  final String errorMsg;
  final RequestStatus propertiesStatus;
  final bool isLoadMore;
  final int totalCount;
  @override
  List<Object> get props => [
    properties,
    errorMsg,
    propertiesStatus,
    isLoadMore,
    totalCount,
  ];
  MyPropertiesState copyWith({
    List<PortfolioPropertyModel>? properties,
    String? errorMsg,
    RequestStatus? propertiesStatus,
    bool? isLoadMore,
    int? totalCount,
  }) {
    return MyPropertiesState(
      properties: properties ?? this.properties,
      errorMsg: errorMsg ?? this.errorMsg,
      propertiesStatus: propertiesStatus ?? this.propertiesStatus,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      totalCount: totalCount ?? this.totalCount,
    );
  }
}
