part of 'owner_properties_bloc.dart';

abstract class OwnerPropertiesEvent extends Equatable {
  const OwnerPropertiesEvent();

  @override
  List<Object?> get props => [];
}

class OwnerPropertiesLoad extends OwnerPropertiesEvent {
  final String brokerId;
  final int page;
  final bool isLoadMore;
  const OwnerPropertiesLoad({
    required this.brokerId,
      this.page = 1,
    this.isLoadMore = false,
  });
}
