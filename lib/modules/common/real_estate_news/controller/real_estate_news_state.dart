part of 'real_estate_news_bloc.dart';

class RealEstateNewsState extends Equatable {
  const RealEstateNewsState({
    this.newsStatus = RequestStatus.init,
    this.items = const [],
     this.errorMsg = '',
  });

  final RequestStatus newsStatus;
  final List<RealEstateNewsItemModel> items;
   final String errorMsg;

  

  RealEstateNewsState copyWith({
    RequestStatus? newsStatus,
    List<RealEstateNewsItemModel>? items,
    String  ? selectedCategory,
    String? errorMsg,
  }) {
    return RealEstateNewsState(
      newsStatus: newsStatus ?? this.newsStatus,
      items: items ?? this.items,
       errorMsg: errorMsg ?? this.errorMsg,
    );
  }

  @override
  List<Object?> get props => [newsStatus, items, errorMsg];
}
