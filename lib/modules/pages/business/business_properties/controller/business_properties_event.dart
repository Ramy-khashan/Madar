part of 'business_properties_bloc.dart';

sealed class BusinessPropertiesEvent extends Equatable {
  const BusinessPropertiesEvent();

  @override
  List<Object> get props => [];
}

final class BusinessPropertiesLoad extends BusinessPropertiesEvent {
  const BusinessPropertiesLoad();
}

final class BusinessPropertiesTabChanged extends BusinessPropertiesEvent {
  const BusinessPropertiesTabChanged(this.index);
  final int index;

  @override
  List<Object> get props => [index];
}

final class BusinessPropertiesAccept extends BusinessPropertiesEvent {
  const BusinessPropertiesAccept(this.id);
  final String id;

  @override
  List<Object> get props => [id];
}

final class BusinessPropertiesReject extends BusinessPropertiesEvent {
  const BusinessPropertiesReject(this.id);
  final String id;

  @override
  List<Object> get props => [id];
}
