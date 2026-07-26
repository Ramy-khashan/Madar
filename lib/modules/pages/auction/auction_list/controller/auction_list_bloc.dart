import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/connection/concept/end_points.dart';
import '../../../../../core/connection/interfaces/api_consumer.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/print_state.dart';
import '../../../../../core/utils/functions/service_locator.dart';
import '../model/auction_item_model.dart';

part 'auction_list_event.dart';
part 'auction_list_state.dart';

class AuctionListBloc extends Bloc<AuctionListEvent, AuctionListState> {
  AuctionListBloc() : super(const AuctionListState()) {
    on<AuctionListLoad>(_onLoad);
    on<AuctionListFilterChanged>(_onFilterChanged);
  }

  static AuctionListBloc get(BuildContext context) =>
      BlocProvider.of<AuctionListBloc>(context);

  int pageSize = 10;

  static String? _filterToStatus(AuctionFilterTab filter) {
    switch (filter) {
      case AuctionFilterTab.live:
        return 'ACTIVE';
      case AuctionFilterTab.upcoming:
        return 'UPCOMING';
      case AuctionFilterTab.ended:
        return 'CLOSED';
      default:
        return null;
    }
  }

  Future<void> _onLoad(
    AuctionListLoad event,
    Emitter<AuctionListState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          loadStatus: RequestStatus.loading,
          isLoadMore: event.isLoadMore,
        ),
      );

      final statusParam = _filterToStatus(state.activeFilter);
      final queryParams = <String, dynamic>{
        'page': event.page,
        'limit': pageSize,
        if (statusParam != null) 'status': statusParam,
      };

      final response = await sl.get<ApiConsumer>().get(
        EndPoints.myAuctions,
        queryParameters: queryParams,
      );

      await response.fold(
        (failedResponse) async {
          emit(
            state.copyWith(
              loadStatus: RequestStatus.failed,
              errorMsg: failedResponse,
              isLoadMore: false,
            ),
          );
        },
        (successResponse) async {
          final auctionsData =
              successResponse.response['auctions'] as Map<String, dynamic>? ??
              {};
          final List<AuctionItemModel> items = [];
          for (var item in List.from(auctionsData['data'] ?? [])) {
            items.add(AuctionItemModel.fromJson(item));
          }
          final pagination =
              auctionsData['pagination'] as Map<String, dynamic>? ?? {};
          final total = pagination['total'] ?? 0;

          emit(
            state.copyWith(
              loadStatus: RequestStatus.success,
              allItems: items,
              totalCount: total,
              isLoadMore: false,
            ),
          );
        },
      );
    } catch (e) {
      printState(e.toString());
      emit(
        state.copyWith(
          loadStatus: RequestStatus.failed,
          errorMsg: AppStrings.somethingWentWrong,
          isLoadMore: false,
        ),
      );
    }
  }

  void _onFilterChanged(
    AuctionListFilterChanged event,
    Emitter<AuctionListState> emit,
  ) {
    emit(state.copyWith(activeFilter: event.filter, allItems: [], totalCount: 0));
    add(const AuctionListLoad());
  }
}
