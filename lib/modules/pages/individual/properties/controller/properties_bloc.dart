import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/model/property_filter_model.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_images.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../individual_home/model/property_model.dart';

part 'properties_event.dart';
part 'properties_state.dart';

class PropertiesBloc extends Bloc<PropertiesEvent, PropertiesState> {
  PropertiesBloc() : super(PropertiesState()) {
    on<PropertiesLoad>(_onLoad);
    on<PropertiesFilterApplied>(_onFilterApplied);
  }
  int pageSize = 10;
  static PropertiesBloc get(BuildContext context) =>
      BlocProvider.of<PropertiesBloc>(context);
  Future<void> _onLoad(
    PropertiesLoad event,
    Emitter<PropertiesState> emit,
  ) async {
    final List<PropertyModel> mockProperties = [
      PropertyModel(
        id: '1',
        title: 'شقة فاخرة في الملقا',
        location: 'الرياض - حي الملقا',
        imageUrl: AppImages.propertyImage,
        beds: 3,
        baths: 2,
        area: '150 ${AppStrings.mesurement}',
        price: 850000,
        tag: 'فلل',
      ),
      PropertyModel(
        id: '2',
        title: 'فيلا حديثة في النرجس',
        location: 'الرياض - حي النرجس',
        imageUrl: AppImages.propertyImage,
        beds: 5,
        baths: 4,
        area: '350 ${AppStrings.mesurement}',
        price: 2200000,
        tag: 'شقه',
        isBookmarked: true,
      ),
      PropertyModel(
        id: '3',
        title: 'شقة في حي العليا',
        location: 'الرياض - حي العليا',
        imageUrl: AppImages.propertyImage,
        beds: 2,
        baths: 1,
        area: '110 ${AppStrings.mesurement}',
        price: 620000,
        tag: 'فلل',
      ),
    ];
    emit(
      state.copyWith(
        propertiesStatus: RequestStatus.success,
        properties: mockProperties,
        totalCount: mockProperties.length,
      ),
    );
    // try {
    // emit(
    //   state.copyWith(
    //     propertiesStatus: RequestStatus.loading,
    //     isLoadMore: event.isLoadMore,
    //   ),
    // );
    // final response = await sl.get<ApiConsumer>().get(
    //   EndPoints.properties,
    //   // queryParameters: {
    //   // 'isForSale': state.filter?.isForSale,
    //   // 'propertyTypeId': state.filter?.propertyTypeId,
    //   // 'maxPrice': state.filter?.maxPrice,
    //   // },
    // );

    // response.fold(
    //   (failedResponse) {
    //     emit(
    //       state.copyWith(
    //         propertiesStatus: RequestStatus.failed,
    //         errorMsg: failedResponse,
    //       ),
    //     );
    //   },
    //   (successResponse) {
    //     final List<PropertiesItemModel> properties = [...state.properties];
    //     for (var element in List.from(
    //       successResponse.response['properties'],
    //     )) {
    //       properties.add(PropertiesItemModel.fromJson(element));
    //     }

    //     emit(
    //       state.copyWith(
    //         propertiesStatus: RequestStatus.success,
    //         properties: properties,
    //         totalCount: properties.length,
    //       ),
    //     );
    //   },
    // );
    // } catch (e) {
    //   emit(
    //     state.copyWith(
    //       propertiesStatus: RequestStatus.failed,
    //       errorMsg: AppStrings.somethingWentWrong,
    //     ),
    //   );
    // }
  }

  void _onFilterApplied(
    PropertiesFilterApplied event,
    Emitter<PropertiesState> emit,
  ) {
    // final f = event.filter;
    // final filtered = state.properties.where((p) {
    //   if (p.isForSale != f.isForSale) return false;
    //   if (f.propertyTypeId != null && p.typeId != f.propertyTypeId)
    //     return false;
    //   if (p.price > f.maxPrice) return false;
    //   return true;
    // }).toList();
    // emit(PropertiesLoaded(properties: filtered, filter: f));
  }
}
