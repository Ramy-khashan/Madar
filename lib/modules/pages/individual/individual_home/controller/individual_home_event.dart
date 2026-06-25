part of 'individual_home_bloc.dart';

sealed class IndividualHomeEvent extends Equatable {
  const IndividualHomeEvent();

  @override
  List<Object> get props => [];
}

final class IndividualHomeLoad extends IndividualHomeEvent {
  const IndividualHomeLoad();
}
