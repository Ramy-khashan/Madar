part of 'broker_properties_bloc.dart';

class BrokerPropertiesState extends Equatable {
  const BrokerPropertiesState({
    this.brokerImageUrl = AppImages.building,
    this.brokerName = '',
    this.brokerPropertiesCount = 0,
    this.errorMsg = '',
    this.brokerId = '',
    this.isBroker = false,
    this.loadingStatus = RequestStatus.init,
    this.properties = const [],
    this.isLoadMore = false,
    this.totalCount = 0,
  });
  final String brokerId;
  final String errorMsg;
  final RequestStatus loadingStatus;
  final List<PropertiesItemModel> properties;
  final String brokerName;
  final bool isBroker;
  final int brokerPropertiesCount;
  final String brokerImageUrl;
  final bool isLoadMore;
  final int totalCount;
  @override
  List<Object?> get props => [
    errorMsg,
    loadingStatus,
    properties,
    brokerName,
    brokerPropertiesCount,
    brokerId,
    brokerImageUrl,
    isLoadMore,
    totalCount,
    isBroker
  ];
  BrokerPropertiesState copyWith({
    String? errorMsg,
    String? brokerId,
    RequestStatus? loadingStatus,
    List<PropertiesItemModel>? properties,
    String? brokerName,
    int? brokerPropertiesCount,
    String? brokerImageUrl,
    bool? isLoadMore,
    bool? isBroker,
    int? totalCount,
  }) {
    return BrokerPropertiesState(
      brokerId: brokerId ?? this.brokerId,
      errorMsg: errorMsg ?? this.errorMsg,
      loadingStatus: loadingStatus ?? this.loadingStatus,
      properties: properties ?? this.properties,
      brokerName: brokerName ?? this.brokerName,
      isBroker: isBroker ?? this.isBroker,
      brokerPropertiesCount:
          brokerPropertiesCount ?? this.brokerPropertiesCount,
      brokerImageUrl: brokerImageUrl ?? this.brokerImageUrl,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      totalCount: totalCount ?? this.totalCount,
    );
  }
}
