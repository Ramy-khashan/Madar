part of 'my_properties_bloc.dart';

sealed class MyPropertiesState extends Equatable {
  const MyPropertiesState();
  
  @override
  List<Object> get props => [];
}

final class MyPropertiesInitial extends MyPropertiesState {}

final class MyPropertiesLoaded extends MyPropertiesState {
  const MyPropertiesLoaded({
    required this.properties,
    this.filter = const PropertyFilterModel(),
  });

  final List<PortfolioPropertyModel> properties;
  final PropertyFilterModel filter;

  @override
  List<Object> get props => [properties, filter];
}
