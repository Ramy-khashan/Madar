import 'dart:async';

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
import '../../individual_home/model/properties_item_model.dart';

part 'properties_event.dart';
part 'properties_state.dart';

class PropertiesBloc extends Bloc<PropertiesEvent, PropertiesState> {
  PropertiesBloc({
    PropertyFilterModel? initialFilter,
    String initialSearch = '',
  }) : super(
         PropertiesState(filter: initialFilter, search: initialSearch),
       ) {
    on<PropertiesLoad>(_onLoad);
    on<PropertiesFilterApplied>(_onFilterApplied);
    on<PropertiesSearchChanged>(_onSearchChanged);
  }

  int pageSize = 10;
  Timer? _searchDebounce;

  static PropertiesBloc get(BuildContext context) =>
      BlocProvider.of<PropertiesBloc>(context);

  Map<String, dynamic> _query({required int page}) {
    if (state.filter == null) {
      return {
        'page': page,
        'limit': pageSize,
        if (state.search.trim().isNotEmpty) 'title': state.search.trim(),
      };
    }
    return state.filter!.toQuery(
      page: page,
      pageSize: pageSize,
      title: state.search,
    );
  }

  Future<void> _onLoad(
    PropertiesLoad event,
    Emitter<PropertiesState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          propertiesStatus: event.isLoadMore
              ? state.propertiesStatus
              : RequestStatus.loading,
          isLoadMore: event.isLoadMore,
          errorMsg: '',
        ),
      );
      final query = _query(page: event.page);
      printState('GET /properties $query');
      final response = await sl.get<ApiConsumer>().get(
        EndPoints.properties,
        queryParameters: query,
      );

      response.fold(
        (failedResponse) {
          emit(
            state.copyWith(
              propertiesStatus: RequestStatus.failed,
              errorMsg: failedResponse,
              isLoadMore: false,
            ),
          );
        },
        (successResponse) {
          final items = _itemsFrom(successResponse.response);
          emit(
            state.copyWith(
              propertiesStatus: RequestStatus.success,
              properties: event.isLoadMore
                  ? [...state.properties, ...items]
                  : items,
              totalCount: _totalFrom(successResponse.response, items.length),
              isLoadMore: false,
            ),
          );
        },
      );
    } catch (e) {
      printState('properties load error: $e');
      emit(
        state.copyWith(
          propertiesStatus: RequestStatus.failed,
          errorMsg: AppStrings.somethingWentWrong,
          isLoadMore: false,
        ),
      );
    }
  }

  void _onFilterApplied(
    PropertiesFilterApplied event,
    Emitter<PropertiesState> emit,
  ) {
    emit(
      state.copyWith(
        filter: event.filter,
        properties: const [],
        totalCount: 0,
      ),
    );
    add(const PropertiesLoad());
  }

  void _onSearchChanged(
    PropertiesSearchChanged event,
    Emitter<PropertiesState> emit,
  ) {
    emit(state.copyWith(search: event.search));
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 400), () {
      add(const PropertiesLoad());
    });
  }

  List<PropertiesItemModel> _itemsFrom(Map<String, dynamic> response) {
    final raw = response['properties'] ??
        (response['data'] is Map
            ? (response['data'] as Map)['properties']
            : response['data']);
    if (raw is! List) return const [];
    return raw
        .whereType<Map>()
        .map((e) => PropertiesItemModel.fromJson(Map<String, dynamic>.from(e)))
        .where((e) => (e.propertyId ?? '').isNotEmpty)
        .toList();
  }

  int _totalFrom(Map<String, dynamic> response, int fallback) {
    final pagination = response['pagination'];
    if (pagination is Map) {
      return (pagination['total'] as num?)?.toInt() ?? fallback;
    }
    return (response['total'] as num?)?.toInt() ?? fallback;
  }

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    return super.close();
  }
}
