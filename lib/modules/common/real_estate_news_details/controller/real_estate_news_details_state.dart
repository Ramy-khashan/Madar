part of 'real_estate_news_details_bloc.dart';

class RealEstateNewsDetailsState extends Equatable {
  const RealEstateNewsDetailsState({
    this.status = RequestStatus.init,
    this.article,
    this.errorMsg = '',
  });

  final RequestStatus status;
  final RealEstateNewsItemModel? article;
  final String errorMsg;

  RealEstateNewsDetailsState copyWith({
    RequestStatus? status,
    RealEstateNewsItemModel? article,
    String? errorMsg,
  }) {
    return RealEstateNewsDetailsState(
      status: status ?? this.status,
      article: article ?? this.article,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }

  @override
  List<Object?> get props => [status, article, errorMsg];
}
