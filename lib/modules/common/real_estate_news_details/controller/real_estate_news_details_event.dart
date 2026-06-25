part of 'real_estate_news_details_bloc.dart';

abstract class RealEstateNewsDetailsEvent extends Equatable {
  const RealEstateNewsDetailsEvent();

  @override
  List<Object?> get props => [];
}

class RealEstateNewsDetailsLoad extends RealEstateNewsDetailsEvent {
  const RealEstateNewsDetailsLoad(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}
