part of 'owner_properties_bloc.dart';

class OwnerPropertiesState extends Equatable {
  const OwnerPropertiesState({
    this.loadStatus = RequestStatus.init,
    this.errorMsg = '',
    this.isLoadMore = false,
    this.totalCount = 0,
    this.properties = const [],
    this.brokerImg = '',
    this.brokerName = '',
    this.brokerId = '',
  });
  final RequestStatus loadStatus;
  final String errorMsg;
  final bool isLoadMore;
  final int totalCount;
  final List properties;
  final String brokerImg;
  final String brokerName;
  final String brokerId;

  @override
  List<Object?> get props => [
    loadStatus,
    errorMsg,
    isLoadMore,
    totalCount,
    properties,
    brokerImg,
    brokerName,
    brokerId,
   ];
  OwnerPropertiesState copyWith({
    RequestStatus? loadStatus,
    String? errorMsg,
    bool? isLoadMore,
    int? totalCount,
    List? properties,
    String? brokerImg,
    String? brokerId,
    String? brokerName,
  }) {
    return OwnerPropertiesState(
      loadStatus: loadStatus ?? this.loadStatus,
      errorMsg: errorMsg ?? this.errorMsg,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      totalCount: totalCount ?? this.totalCount,
      properties: properties ?? this.properties,
      brokerImg: brokerImg ?? this.brokerImg,
      brokerId: brokerId ?? this.brokerId,
      brokerName: brokerName ?? this.brokerName,
    );
  }
}
