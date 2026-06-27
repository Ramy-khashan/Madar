import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/connection/concept/end_points.dart';
import '../../../../core/connection/interfaces/api_consumer.dart';
import '../../../../core/utils/constants/app_enums.dart';
import '../../../../core/utils/constants/app_images.dart';
import '../../../../core/utils/functions/service_locator.dart';
import '../model/real_estate_news_item_model.dart';

part 'real_estate_news_event.dart';
part 'real_estate_news_state.dart';

class RealEstateNewsBloc
    extends Bloc<RealEstateNewsEvent, RealEstateNewsState> {
  RealEstateNewsBloc() : super(const RealEstateNewsState()) {
    on<RealEstateNewsLoad>(_onLoad);
  }

  static RealEstateNewsBloc get(BuildContext context) =>
      context.read<RealEstateNewsBloc>();

  Future<void> _onLoad(
    RealEstateNewsLoad event,
    Emitter<RealEstateNewsState> emit,
  ) async {

    final List<RealEstateNewsItemModel> _mockNews = [
    const RealEstateNewsItemModel(
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
    ),
    const RealEstateNewsItemModel(
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
    ),
    const RealEstateNewsItemModel(
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
    ),
  ];
  emit(state.copyWith(newsStatus: RequestStatus.success, items: _mockNews));
    // try {
    //   emit(state.copyWith(newsStatus: RequestStatus.loading));
    //   final response = await sl.get<ApiConsumer>().get(
    //     EndPoints.realEstateNews,
    //   );
    //   await response.fold(
    //     (failedResponse) async {
    //       emit(
    //         state.copyWith(
    //           newsStatus: RequestStatus.failed,
    //           errorMsg: failedResponse,
    //         ),
    //       );
    //     },
    //     (successResponse) async {
    //       final List<RealEstateNewsItemModel> items = [];
    //       for (var item in List.from(successResponse.response['news'])) {
    //         items.add(RealEstateNewsItemModel.fromJson(item));
    //       }

    //       emit(state.copyWith(newsStatus: RequestStatus.success, items: items));
    //     },
    //   );
    // } catch (e) {
    //   emit(
    //     state.copyWith(
    //       errorMsg: e.toString(),
    //       newsStatus: RequestStatus.failed,
    //     ),
    //   );
    // }
  }
}
