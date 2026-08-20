import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/connection/concept/end_points.dart';
import '../../../../../core/connection/interfaces/api_consumer.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
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
    on<PropertyDetailsCheckIfPropertyIsSaved>(_onCheckIfPropertyIsSaved);
    on<AddedPropertyToSavedEvent>(_onAddedPropertyToSaved);
  }

  static PropertyDetailsBloc get(BuildContext context) =>
      BlocProvider.of<PropertyDetailsBloc>(context);

  Future<void> _onLoad(
    PropertyDetailsLoad event,
    Emitter<PropertyDetailsState> emit,
  ) async {
    try {
        if (isClosed) return;

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
        final data = successResponse.response['data'];
        if (data is! Map) {
          emit(
            state.copyWith(
              getDetailsStatus: RequestStatus.failed,
              errorMsg: AppStrings.somethingWentWrong,
            ),
          );
          return;
        }
        final property = PropertyDetailsModel.fromJson(
          Map<String, dynamic>.from(data),
        );
        emit(
          state.copyWith(
            getDetailsStatus: RequestStatus.success,
            property: property,
          ),
        );
        if (isClosed) return;
        add(PropertyDetailsCheckIfPropertyIsSaved(event.propertyId));
      },
    );
    } catch (e) {
       emit(
        state.copyWith(
          getDetailsStatus: RequestStatus.failed,
          errorMsg: AppStrings.somethingWentWrong,
        ),
      );
    }
  }

  void _onToggleBookmark(
    PropertyDetailsToggleBookmark event,
    Emitter<PropertyDetailsState> emit,
  ) {
    add(AddedPropertyToSavedEvent(state.property!.propertyId ?? ''));
  }

  Future<void> _onSubmitRequest(
    PropertyDetailsSubmitRequest event,
    Emitter<PropertyDetailsState> emit,
  ) async {
    emit(state.copyWith(submitStatus: RequestStatus.loading));
    emit(state.copyWith(submitStatus: RequestStatus.success));
  }

  Future<void> _onCheckIfPropertyIsSaved(
    PropertyDetailsCheckIfPropertyIsSaved event,
    Emitter<PropertyDetailsState> emit,
  ) async {
    try {
      final response = await sl.get<ApiConsumer>().get(
        EndPoints.checkWishlist(event.propertyId),
      );
      response.fold(
        (failedResponse) {
          emit(state.copyWith(isSavedWishList: false));
        },
        (successResponse) {
          emit(
            state.copyWith(
              isSavedWishList: successResponse.response['data']['saved'],
            ),
          );
        },
      );
    } catch (e) {
      emit(state.copyWith(isSavedWishList: false));
    }
  }

  Future<void> _onAddedPropertyToSaved(
    AddedPropertyToSavedEvent event,
    Emitter<PropertyDetailsState> emit,
  ) async {
    try {
      final response = await sl.get<ApiConsumer>().post(
        EndPoints.addToWishlist(event.propertyId),
      );
      response.fold((failedResponse) {}, (successResponse) {
        emit(
          state.copyWith(
            isSavedWishList: successResponse.response['data']['saved'],
          ),
        );
      });
    } catch (e) {}
  }
}
