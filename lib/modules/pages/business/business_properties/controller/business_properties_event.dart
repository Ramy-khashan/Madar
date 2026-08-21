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
  const BusinessPropertiesAccept(
    this.id, {
    this.adLicenseNumber = '',
    this.isIncoming = false,
  });
  final String id;
  final String adLicenseNumber;
  final bool isIncoming;

  @override
  List<Object> get props => [id, adLicenseNumber, isIncoming];
}

final class BusinessPropertiesReject extends BusinessPropertiesEvent {
  const BusinessPropertiesReject(
    this.id, {
    required this.rejectReason,
    this.isIncoming = false,
  });
  final String id;
  final String rejectReason;
  final bool isIncoming;

  @override
  List<Object> get props => [id, rejectReason, isIncoming];
}
