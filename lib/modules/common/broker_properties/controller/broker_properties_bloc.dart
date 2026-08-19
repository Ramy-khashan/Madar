import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/constants/app_images.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../core/connection/concept/end_points.dart';
import '../../../../core/connection/interfaces/api_consumer.dart';
import '../../../../core/utils/constants/app_enums.dart';
import '../../../../core/utils/functions/service_locator.dart';
import '../../../pages/individual/individual_home/model/properties_item_model.dart';

part 'broker_properties_event.dart';
part 'broker_properties_state.dart';

class BrokerPropertiesBloc
    extends Bloc<BrokerPropertiesEvent, BrokerPropertiesState> {
  BrokerPropertiesBloc() : super(const BrokerPropertiesState()) {
    on<BrokerPropertiesLoad>(_onLoad);
  }

  static BrokerPropertiesBloc get(BuildContext context) =>
      context.read<BrokerPropertiesBloc>();

  final int pageSize = 3;

  Future<void> _onLoad(
    BrokerPropertiesLoad event,
    Emitter<BrokerPropertiesState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          loadingStatus: RequestStatus.loading,
          isLoadMore: event.isLoadMore,
        ),
      );
      final res = await sl.get<ApiConsumer>().get(
        EndPoints.brokerProperties(event.brokerId),
        queryParameters: {'page': event.page, 'page_size': pageSize},
      );
      await res.fold(
        (l) async {
          emit(
            state.copyWith(
              loadingStatus: RequestStatus.failed,
              errorMsg: l,
              isLoadMore: false,
            ),
          );
        },
        (r) async {
          final properties = (r.response['properties'] as List)
              .map((e) => PropertiesItemModel.fromJson(e))
              .toList();
          final pagination = r.response['pagination'] as Map<String, dynamic>?;
          final totalCount = pagination?['total'] as int? ?? 0;
          emit(
            state.copyWith(
              loadingStatus: RequestStatus.success,
              brokerId: event.brokerId,
              brokerName: r.response['broker']['fullName'] ?? '',
              brokerPropertiesCount: totalCount,
              brokerImageUrl: AppImages.building,
              properties: event.isLoadMore
                  ? [...state.properties, ...properties]
                  : properties,
              totalCount: totalCount,
              isLoadMore: false,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadingStatus: RequestStatus.failed,
          errorMsg: AppStrings.somethingWentWrong,
          isLoadMore: false,
        ),
      );
    }
  }
}
