import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/connection/concept/end_points.dart';
import '../../../../../core/connection/interfaces/api_consumer.dart';
import '../../../../../core/utils/constants/app_enums.dart';
 import '../../../../../core/utils/functions/service_locator.dart';
 import '../../../../../core/model/property_filter_model.dart';
import '../model/properties_item_model.dart';

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
    // try {
      emit(
        state.copyWith(
          propertiesStatus: RequestStatus.loading,
          isLoadMore: event.isLoadMore,
        ),
      );
      final response = await sl.get<ApiConsumer>().get(
        EndPoints.properties,
        // queryParameters: {
        // 'isForSale': state.filter?.isForSale,
        // 'propertyTypeId': state.filter?.propertyTypeId,
        // 'maxPrice': state.filter?.maxPrice,
        // },
      );

      response.fold(
        (failedResponse) {
          emit(
            state.copyWith(
              propertiesStatus: RequestStatus.failed,
              errorMsg: failedResponse,
            ),
          );
        },
        (successResponse) {
          final List<PropertiesItemModel> properties = [...state.properties];
          for (var element in List.from(
            successResponse.response['properties'],
          )) {
            properties.add(PropertiesItemModel.fromJson(element));
          }

          emit(
            state.copyWith(
              propertiesStatus: RequestStatus.success,
              properties: properties,
              totalCount: properties.length,
            ),
          );
        },
      );
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
