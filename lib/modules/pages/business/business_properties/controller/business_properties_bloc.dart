import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/repository/apis/business_properties_apis.dart';
import '../../../../../core/repository/apis/contracts_apis.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../model/business_property_request_model.dart';

part 'business_properties_event.dart';
part 'business_properties_state.dart';

class BusinessPropertiesBloc
    extends Bloc<BusinessPropertiesEvent, BusinessPropertiesState> {
  BusinessPropertiesBloc() : super(const BusinessPropertiesState()) {
    on<BusinessPropertiesLoad>(_onLoad);
    on<BusinessPropertiesTabChanged>(_onTabChanged);
    on<BusinessPropertiesAccept>(_onAccept);
    on<BusinessPropertiesReject>(_onReject);
  }

  void _onTabChanged(
    BusinessPropertiesTabChanged event,
    Emitter<BusinessPropertiesState> emit,
  ) {
    emit(state.copyWith(currentTab: event.index));
  }

  Future<void> _onLoad(
    BusinessPropertiesLoad event,
    Emitter<BusinessPropertiesState> emit,
  ) async {
    emit(
      state.copyWith(
        requestsStatus: RequestStatus.loading,
        publishedStatus: RequestStatus.loading,
      ),
    );

    final requestsFuture = BusinessPropertiesApis.fetchRequests();
    final publishedFuture = BusinessPropertiesApis.fetchPublished();

    final requestsResult = await requestsFuture;
    requestsResult.fold(
      (err) => emit(
        state.copyWith(
          requestsStatus: RequestStatus.failed,
          requestsErrorMessage: err,
          requests: const [],
        ),
      ),
      (items) => emit(
        state.copyWith(
          requestsStatus: RequestStatus.success,
          requests: items.where((e) => e.isPending).toList(),
          requestsErrorMessage: '',
        ),
      ),
    );

    final publishedResult = await publishedFuture;
    publishedResult.fold(
      (err) => emit(
        state.copyWith(
          publishedStatus: RequestStatus.failed,
          publishedErrorMessage: err,
          published: const [],
        ),
      ),
      (items) => emit(
        state.copyWith(
          publishedStatus: RequestStatus.success,
          published: items,
          publishedErrorMessage: '',
        ),
      ),
    );
  }

  Future<void> _onAccept(
    BusinessPropertiesAccept event,
    Emitter<BusinessPropertiesState> emit,
  ) async {
    await _handleAction(
      emit,
      requestId: event.id,
      action: () {
        if (event.isIncoming) {
          if (event.contractId.trim().isEmpty) {
            return Future<Either<String, dynamic>>.value(
              Left(AppStrings.somethingWentWrong),
            );
          }
          return ContractsApis.approve(
            contractId: event.contractId,
            durationInYears: event.durationInYears,
            finalPrice: event.finalPrice ?? 0,
          );
        }
        return BusinessPropertiesApis.respondToRequest(
          requestId: event.id,
          action: BusinessPropertiesApis.approveAction,
          adLicenseNumber: event.adLicenseNumber,
        );
      },
      successMessage: event.isIncoming
          ? AppStrings.contractApprovedSuccess
          : AppStrings.businessPropertiesAcceptSuccess,
      publishedStatus: event.isIncoming ? 'APPROVED' : 'ACCEPTED',
    );
  }

  Future<void> _onReject(
    BusinessPropertiesReject event,
    Emitter<BusinessPropertiesState> emit,
  ) async {
    await _handleAction(
      emit,
      requestId: event.id,
      action: () {
        if (event.isIncoming && event.contractId.trim().isNotEmpty) {
          return ContractsApis.reject(contractId: event.contractId);
        }
        return BusinessPropertiesApis.respondToRequest(
          requestId: event.id,
          action: BusinessPropertiesApis.rejectAction,
          rejectReason: event.rejectReason,
          isIncoming: event.isIncoming,
        );
      },
      successMessage: AppStrings.businessPropertiesRejectSuccess,
      publishedStatus: 'REJECTED',
      rejectReason: event.rejectReason,
    );
  }

  Future<void> _handleAction(
    Emitter<BusinessPropertiesState> emit, {
    required String requestId,
    required Future<Either<String, dynamic>> Function() action,
    required String successMessage,
    required String publishedStatus,
    String? rejectReason,
  }) async {
    if (requestId.isEmpty || state.actionStatus == RequestStatus.loading) {
      return;
    }

    emit(
      state.copyWith(
        actionStatus: RequestStatus.loading,
        actionRequestId: requestId,
      ),
    );

    final result = await action();
    await result.fold(
      (err) async {
        emit(
          state.copyWith(
            actionStatus: RequestStatus.failed,
            actionMessage: err,
            clearActionRequestId: true,
          ),
        );
      },
      (_) async {
        emit(
          state.copyWith(
            requests: state.requests
                .where((r) => r.requestId != requestId)
                .toList(),
            published: state.published
                .map(
                  (item) => item.id == requestId
                      ? item.copyWith(
                          status: publishedStatus,
                          rejectReason: rejectReason,
                          contractStatus: publishedStatus,
                        )
                      : item,
                )
                .toList(),
            actionStatus: RequestStatus.success,
            actionMessage: successMessage,
            clearActionRequestId: true,
          ),
        );
      },
    );
  }
}
