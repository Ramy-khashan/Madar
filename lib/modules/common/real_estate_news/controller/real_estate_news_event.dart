part of 'real_estate_news_bloc.dart';

abstract class RealEstateNewsEvent extends Equatable {
  const RealEstateNewsEvent();

  @override
  List<Object?> get props => [];
}

class RealEstateNewsLoad extends RealEstateNewsEvent {
  const RealEstateNewsLoad();
}

class RealEstateNewsCategoryChanged extends RealEstateNewsEvent {
  const RealEstateNewsCategoryChanged(this.category);

  final String category;

  @override
  List<Object?> get props => [category];
}
