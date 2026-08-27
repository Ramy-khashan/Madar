import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/connection/concept/end_points.dart';
import '../../../../../core/connection/interfaces/api_consumer.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_images.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/service_locator.dart';
import '../../individual_home/model/properties_item_model.dart';

part 'owner_properties_event.dart';
part 'owner_properties_state.dart';

class OwnerPropertiesBloc
    extends Bloc<OwnerPropertiesEvent, OwnerPropertiesState> {
  OwnerPropertiesBloc() : super(const OwnerPropertiesState()) {
    on<OwnerPropertiesLoad>(_onLoad);
  }

  final int pageSize = 20;
  Future<void> _onLoad(
    OwnerPropertiesLoad event,
    Emitter<OwnerPropertiesState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          loadStatus: RequestStatus.loading,
          isLoadMore: event.isLoadMore,
        ),
      );
      final res = await sl.get<ApiConsumer>().get(
        EndPoints.brokerProperties(event.brokerId),
        queryParameters: {'page': event.page, 'limit': pageSize},
      );
      await res.fold(
        (l) async {
          emit(
            state.copyWith(
              loadStatus: RequestStatus.failed,
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
              loadStatus: RequestStatus.success,
              brokerId: event.brokerId,
              brokerName: r.response['broker']['fullName'] ?? '',
              totalCount: totalCount,
              brokerImg: AppImages.building,
              properties: event.isLoadMore
                  ? [...state.properties, ...properties]
                  : properties,
              isLoadMore: false,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadStatus: RequestStatus.failed,
          errorMsg: AppStrings.somethingWentWrong,
          isLoadMore: false,
        ),
      );
    }
  }
}
