import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/connection/concept/end_points.dart';
import '../../../../core/connection/interfaces/api_consumer.dart';
import '../../../../core/utils/constants/app_enums.dart';
import '../../../../core/utils/functions/service_locator.dart';
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
    emit(state.copyWith(status: RequestStatus.loading));

    final res = await sl.get<ApiConsumer>().get(
      EndPoints.realEstateNewsDetails(event.id),
    );
    res.fold(
      (failedResponse) => emit(
        state.copyWith(status: RequestStatus.failed, errorMsg: failedResponse),
      ),
      (successResponse) {
        final article = RealEstateNewsItemModel.fromJson(
          successResponse.response['news'],
        );

        emit(state.copyWith(status: RequestStatus.success, article: article));
      },
    );
  }
}
