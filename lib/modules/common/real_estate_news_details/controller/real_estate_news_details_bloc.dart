import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 
import '../../../../core/utils/constants/app_enums.dart';
import '../../../../core/utils/constants/app_images.dart'; 
import '../../real_estate_news/model/real_estate_news_item_model.dart';

part 'real_estate_news_details_event.dart';
part 'real_estate_news_details_state.dart';

class RealEstateNewsDetailsBloc
    extends Bloc<RealEstateNewsDetailsEvent, RealEstateNewsDetailsState> {
  RealEstateNewsDetailsBloc() : super(const RealEstateNewsDetailsState()) {
    on<RealEstateNewsDetailsLoad>(_onLoad);
  }

  static RealEstateNewsDetailsBloc get(BuildContext context) =>
      context.read<RealEstateNewsDetailsBloc>();

  Future<void> _onLoad(
    RealEstateNewsDetailsLoad event,
    Emitter<RealEstateNewsDetailsState> emit,
  ) async {
    emit(state.copyWith(article:   const RealEstateNewsItemModel(
      id: '3',
      title: 'تحديثات تشريعية جديدة لتنظيم الإيجارات',
      summary: 'اعتماد ضوابط جديدة لحماية الملاك والمستأجرين وتعزيز الاستقرار',
      body:
          'تم الإعلان عن تشريعات محدثة لتنظيم العلاقة الإيجارية ورفع كفاءة توثيق العقود، بما يحقق التوازن بين أطراف العملية العقارية.',
      image: AppImages.propertyImage,
      category: 'legislation',
      readTime:  '5',
      createdAt: '2024-06-01T10:00:00Z', publishedAt: '2024-06-01T12:00:00Z', tags: [
        'تشريعات',
        'إيجارات',
        'عقارات',
      ], updatedAt: '',
    ),));
    // emit(state.copyWith(status: RequestStatus.loading));

    // final res = await sl.get<ApiConsumer>().get(
    //   EndPoints.realEstateNewsDetails(event.id),
    // );
    // res.fold(
    //   (failedResponse) => emit(
    //     state.copyWith(status: RequestStatus.failed, errorMsg: failedResponse),
    //   ),
    //   (successResponse) {
    //     final article = RealEstateNewsItemModel.fromJson(
    //       successResponse.response['news'],
    //     );

    //     emit(state.copyWith(status: RequestStatus.success, article: article));
    //   },
    // );
  }
}
