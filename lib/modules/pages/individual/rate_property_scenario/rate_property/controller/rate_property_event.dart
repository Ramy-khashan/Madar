part of 'rate_property_bloc.dart';

abstract class RatePropertyEvent extends Equatable {
  const RatePropertyEvent();

  @override
  List<Object?> get props => [];
}

class RatePropertyLoad extends RatePropertyEvent {
  const RatePropertyLoad();
}

class RatePropertyTabChanged extends RatePropertyEvent {
  final int index;
  const RatePropertyTabChanged(this.index);

  @override
  List<Object?> get props => [index];
}
