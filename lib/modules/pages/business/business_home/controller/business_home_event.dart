part of 'business_home_bloc.dart';

sealed class BusinessHomeEvent extends Equatable {
  const BusinessHomeEvent();

  @override
  List<Object> get props => [];
}
class BusinessHomeItemsEvent extends BusinessHomeEvent {
  const BusinessHomeItemsEvent();
}