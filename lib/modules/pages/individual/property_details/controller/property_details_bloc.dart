import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 
import '../../../../../core/connection/concept/end_points.dart';
import '../../../../../core/connection/interfaces/api_consumer.dart';
import '../../../../../core/utils/constants/app_enums.dart';
 import '../../../../../core/utils/functions/service_locator.dart'; 
import '../model/property_details_model.dart';

part 'property_details_event.dart';
part 'property_details_state.dart';

class PropertyDetailsBloc
    extends Bloc<PropertyDetailsEvent, PropertyDetailsState> {
  PropertyDetailsBloc() : super(const PropertyDetailsState()) {
    on<PropertyDetailsLoad>(_onLoad);
    on<PropertyDetailsToggleBookmark>(_onToggleBookmark);
    on<PropertyDetailsSubmitRequest>(_onSubmitRequest);
  }

  static PropertyDetailsBloc get(BuildContext context) =>
      BlocProvider.of<PropertyDetailsBloc>(context);

  Future<void> _onLoad(
    PropertyDetailsLoad event,
    Emitter<PropertyDetailsState> emit,
  ) async {
    // try {
      emit(state.copyWith(getDetailsStatus: RequestStatus.loading));
      final response = await sl.get<ApiConsumer>().get(
        '${EndPoints.properties}/${event.propertyId}',
      );
      await response.fold(
        (failedResponse) {
          emit(
            state.copyWith(
              getDetailsStatus: RequestStatus.failed,
              errorMsg: failedResponse,
            ),
          );
        },
        (successResponse) {
          final property = PropertyDetailsModel.fromJson(
            successResponse.response['data'],
          );
          emit(
            state.copyWith(
              getDetailsStatus: RequestStatus.success,
              property: property,
            ),
          );
        },
      );
    // } catch (e) {
    //   printState(e);
    //   emit(
    //     state.copyWith(
    //       getDetailsStatus: RequestStatus.failed,
    //       errorMsg: AppStrings.somethingWentWrong,
    //     ),
    //   );
    // }
  }

  void _onToggleBookmark(
    PropertyDetailsToggleBookmark event,
    Emitter<PropertyDetailsState> emit,
  ) {
    emit(state.copyWith(isSavedWishList: !state.isSavedWishList));
    // emit(
    //   state.copyWith(
    //     property: state.property!.copyWith(
    //       isBookmarked: !state.property!.isBookmarked,
    //     ),
    //   ),
    // );
  }

  Future<void> _onSubmitRequest(
    PropertyDetailsSubmitRequest event,
    Emitter<PropertyDetailsState> emit,
  ) async {
    emit(state.copyWith(submitStatus: RequestStatus.loading));
    emit(state.copyWith(submitStatus: RequestStatus.success));
  }
}
