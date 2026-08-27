import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/repository/apis/user_requests_apis.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/guest_mode.dart';
import '../model/my_property_request_model.dart';

part 'my_requests_event.dart';
part 'my_requests_state.dart';

class MyRequestsBloc extends Bloc<MyRequestsEvent, MyRequestsState> {
  MyRequestsBloc() : super(const MyRequestsState()) {
    on<MyRequestsLoad>(_onLoad);
    on<MyRequestDetailsLoad>(_onDetailsLoad);
    on<MyRequestDelete>(_onDelete);
    on<MyRequestUpdateStatus>(_onUpdateStatus);
  }

  static MyRequestsBloc get(BuildContext context) =>
      BlocProvider.of<MyRequestsBloc>(context);

  Future<void> _onLoad(
    MyRequestsLoad event,
    Emitter<MyRequestsState> emit,
  ) async {
    if (GuestMode.isGuest) {
      emit(
        state.copyWith(
          listStatus: RequestStatus.success,
          requests: [],
          errorMsg: '',
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        listStatus: RequestStatus.loading,
        errorMsg: '',
        actionMessage: '',
      ),
    );
    final result = await UserRequestsApis.fetchMyRequests();
    result.fold(
      (err) => emit(
        state.copyWith(listStatus: RequestStatus.failed, errorMsg: err),
      ),
      (items) => emit(
        state.copyWith(listStatus: RequestStatus.success, requests: items),
      ),
    );
  }

  Future<void> _onDetailsLoad(
    MyRequestDetailsLoad event,
    Emitter<MyRequestsState> emit,
  ) async {
    emit(
      state.copyWith(
        detailsStatus: RequestStatus.loading,
        errorMsg: '',
        actionMessage: '',
        requestId: event.requestId,
      ),
    );
    final result = await UserRequestsApis.fetchRequestDetails(
      requestId: event.requestId,
    );
    result.fold(
      (err) => emit(
        state.copyWith(detailsStatus: RequestStatus.failed, errorMsg: err),
      ),
      (item) => emit(
        state.copyWith(detailsStatus: RequestStatus.success, details: item),
      ),
    );
  }

  Future<void> _onDelete(
    MyRequestDelete event,
    Emitter<MyRequestsState> emit,
  ) async {
    if (event.requestId.isEmpty || state.actionStatus == RequestStatus.loading) {
      return;
    }
    emit(
      state.copyWith(
        actionStatus: RequestStatus.loading,
        actionRequestId: event.requestId,
        actionMessage: '',
      ),
    );
    final result = await UserRequestsApis.deleteRequest(
      requestId: event.requestId,
    );
    result.fold(
      (err) => emit(
        state.copyWith(actionStatus: RequestStatus.failed, actionMessage: err),
      ),
      (_) {
        emit(
          state.copyWith(
            actionStatus: RequestStatus.success,
            actionMessage: AppStrings.requestDeletedSuccess,
            requests: state.requests
                .where((e) => e.id != event.requestId)
                .toList(),
            clearDetails: state.details?.id == event.requestId,
          ),
        );
      },
    );
  }

  Future<void> _onUpdateStatus(
    MyRequestUpdateStatus event,
    Emitter<MyRequestsState> emit,
  ) async {
    if (event.requestId.isEmpty || state.actionStatus == RequestStatus.loading) {
      return;
    }
    emit(
      state.copyWith(
        actionStatus: RequestStatus.loading,
        actionRequestId: event.requestId,
        actionMessage: '',
      ),
    );
    final result = await UserRequestsApis.updateRequestStatus(
      requestId: event.requestId,
      status: event.status,
    );
    result.fold(
      (err) => emit(
        state.copyWith(actionStatus: RequestStatus.failed, actionMessage: err),
      ),
      (_) {
        final nextStatus = event.status.toUpperCase() ==
                UserRequestsApis.approvedStatus.toUpperCase()
            ? 'APPROVED'
            : 'REJECTED';
        emit(
          state.copyWith(
            actionStatus: RequestStatus.success,
            actionMessage: event.status == UserRequestsApis.approvedStatus
                ? AppStrings.contractAcceptedSuccess
                : AppStrings.contractRejectedSuccess,
            details: state.details?.id == event.requestId
                ? state.details?.copyWith(
                    status: nextStatus,
                    contract: state.details?.contract?.copyWith(
                      status: nextStatus,
                    ),
                  )
                : state.details,
            requests: state.requests
                .map(
                  (e) => e.id == event.requestId
                      ? e.copyWith(
                          status: nextStatus,
                          contract: e.contract?.copyWith(status: nextStatus),
                        )
                      : e,
                )
                .toList(),
          ),
        );
      },
    );
  }
}
