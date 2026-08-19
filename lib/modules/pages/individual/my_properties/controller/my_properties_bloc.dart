import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/connection/concept/end_points.dart';
import '../../../../../core/connection/interfaces/api_consumer.dart';
import '../../../../../core/model/property_filter_model.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/print_state.dart';
import '../../../../../core/utils/functions/service_locator.dart';
import '../../../business/business_home/model/business_portfolio_property_model.dart';
import '../../individual_home/model/portfolio_property_model.dart';

part 'my_properties_event.dart';
part 'my_properties_state.dart';

class MyPropertiesBloc extends Bloc<MyPropertiesEvent, MyPropertiesState> {
  MyPropertiesBloc() : super(const MyPropertiesState()) {
    on<MyPropertiesLoad>(_onLoad);
  }
  static MyPropertiesBloc get(BuildContext context) =>
      BlocProvider.of<MyPropertiesBloc>(context);
  int pageSize = 10;
  Future<void> _onLoad(
    MyPropertiesLoad event,
    Emitter<MyPropertiesState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          propertiesStatus: RequestStatus.loading,
          isLoadMore: event.isLoadMore,
        ),
      );
      final response = await sl.get<ApiConsumer>().get(
        EndPoints.portfolio,
        queryParameters: {'page': event.page, 'limit': pageSize},
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
          final List<MyPropertiesModel> properties = [...state.properties];
          final dataArray = successResponse.response['data'] as List;
          
          for (var element in dataArray) {
            properties.add(MyPropertiesModel.fromJson(element));
          }

          final pagination = successResponse.response['pagination'] as Map;
          emit(
            state.copyWith(
              propertiesStatus: RequestStatus.success,
              properties: properties,
              totalCount: pagination['total'] as int? ?? 0,
            ),
          );
        },
      );
    } catch (e) {
      printState(e);
      emit(
        state.copyWith(
          propertiesStatus: RequestStatus.failed,
          errorMsg: AppStrings.somethingWentWrong,
        ),
      );
    }
  }
}
