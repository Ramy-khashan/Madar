import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/connection/concept/end_points.dart';
import '../../../../../core/connection/interfaces/api_consumer.dart';
import '../../../../../core/repository/apis/business_properties_apis.dart';
import '../../../../../core/repository/apis/user_requests_apis.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/constants/storage_keys.dart';
import '../../../../../core/utils/functions/guest_mode.dart';
import '../../../../../core/utils/functions/preference_utils.dart';
import '../../../../../core/utils/functions/print_state.dart';
import '../../../../../core/utils/functions/service_locator.dart';
import '../../my_requests/model/my_property_request_model.dart';
import '../model/property_details_model.dart';

part 'property_details_event.dart';
part 'property_details_state.dart';

class PropertyDetailsBloc
    extends Bloc<PropertyDetailsEvent, PropertyDetailsState> {
  PropertyDetailsBloc() : super(const PropertyDetailsState()) {
    on<PropertyDetailsLoad>(_onLoad);
    on<PropertyDetailsToggleBookmark>(_onToggleBookmark);
    on<PropertyDetailsSubmitRequest>(_onSubmitRequest);
    on<PropertyDetailsCheckExistingRequest>(_onCheckExistingRequest);
    on<PropertyDetailsCheckIfPropertyIsSaved>(_onCheckIfPropertyIsSaved);
    on<AddedPropertyToSavedEvent>(_onAddedPropertyToSaved);
    on<PropertyDetailsBrokerAccept>(_onBrokerAccept);
    on<PropertyDetailsBrokerReject>(_onBrokerReject);
  }

  static PropertyDetailsBloc get(BuildContext context) =>
      BlocProvider.of<PropertyDetailsBloc>(context);

  Future<void> _onLoad(
    PropertyDetailsLoad event,
    Emitter<PropertyDetailsState> emit,
  ) async {
    try {
      if (isClosed) return;

      emit(
        state.copyWith(
          getDetailsStatus: RequestStatus.loading,
          brokerRequestId: event.brokerRequestId,
          adLicenseNumber: event.adLicenseNumber,
        ),
      );
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
          if (!GuestMode.isGuest) {
            add(PropertyDetailsCheckIfPropertyIsSaved(event.propertyId));
            add(PropertyDetailsCheckExistingRequest(event.propertyId));
          }
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
    if (GuestMode.isGuest) return;
    add(AddedPropertyToSavedEvent(state.property!.propertyId ?? ''));
  }

  Future<void> _onSubmitRequest(
    PropertyDetailsSubmitRequest event,
    Emitter<PropertyDetailsState> emit,
  ) async {
    if (GuestMode.isGuest) return;
    final propertyId = state.property?.propertyId ?? '';
    if (propertyId.isEmpty || state.submitStatus == RequestStatus.loading) {
      return;
    }
    emit(
      state.copyWith(submitStatus: RequestStatus.loading, submitMessage: ''),
    );
    final result = await UserRequestsApis.createRequest(propertyId: propertyId);
    result.fold(
      (err) => emit(
        state.copyWith(submitStatus: RequestStatus.failed, submitMessage: err),
      ),
      (request) => emit(
        state.copyWith(
          submitStatus: RequestStatus.success,
          submitMessage: AppStrings.requestSentSuccess,
          existingRequest: request,
        ),
      ),
    );
  }

  Future<void> _onCheckExistingRequest(
    PropertyDetailsCheckExistingRequest event,
    Emitter<PropertyDetailsState> emit,
  ) async {
    final userId = sl.get<PreferenceUtils>().getString(StorageKeys.userID);
    MyPropertyRequestModel? mine;
    var propertyCallFailed = false;
    final propertyResult = await UserRequestsApis.fetchPropertyRequests(
      propertyId: event.propertyId,
    );
    propertyResult.fold((_) => propertyCallFailed = true, (items) {
      for (final item in items) {
        if (userId.isNotEmpty && item.userId == userId) {
          mine = item;
          break;
        }
      }
    });
    if (mine == null && propertyCallFailed) {
      final meResult = await UserRequestsApis.fetchMyRequests();
      meResult.fold((_) {}, (items) {
        for (final item in items) {
          if (item.propertyId == event.propertyId) {
            mine = item;
            break;
          }
        }
      });
    }
    if (mine != null && !isClosed) {
      emit(state.copyWith(existingRequest: mine));
    }
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
    if (GuestMode.isGuest) return;
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
    } catch (e){
      printState('Error adding property to saved: $e');
    } 
  }

  Future<void> _onBrokerAccept(
    PropertyDetailsBrokerAccept event,
    Emitter<PropertyDetailsState> emit,
  ) async {
    await _respondToBrokerRequest(
      emit,
      action: BusinessPropertiesApis.approveAction,
      adLicenseNumber: event.adLicenseNumber,
      successMessage: AppStrings.businessPropertiesAcceptSuccess,
    );
  }

  Future<void> _onBrokerReject(
    PropertyDetailsBrokerReject event,
    Emitter<PropertyDetailsState> emit,
  ) async {
    await _respondToBrokerRequest(
      emit,
      action: BusinessPropertiesApis.rejectAction,
      rejectReason: event.rejectReason,
      successMessage: AppStrings.businessPropertiesRejectSuccess,
    );
  }

  Future<void> _respondToBrokerRequest(
    Emitter<PropertyDetailsState> emit, {
    required String action,
    String? adLicenseNumber,
    String? rejectReason,
    required String successMessage,
  }) async {
    final requestId = state.brokerRequestId ?? '';
    if (requestId.isEmpty || state.actionStatus == RequestStatus.loading) {
      return;
    }
    emit(
      state.copyWith(actionStatus: RequestStatus.loading, actionMessage: ''),
    );
    final result = await BusinessPropertiesApis.respondToRequest(
      requestId: requestId,
      action: action,
      adLicenseNumber: adLicenseNumber,
      rejectReason: rejectReason,
    );
    result.fold(
      (err) => emit(
        state.copyWith(actionStatus: RequestStatus.failed, actionMessage: err),
      ),
      (_) => emit(
        state.copyWith(
          actionStatus: RequestStatus.success,
          actionMessage: successMessage,
        ),
      ),
    );
  }
}
