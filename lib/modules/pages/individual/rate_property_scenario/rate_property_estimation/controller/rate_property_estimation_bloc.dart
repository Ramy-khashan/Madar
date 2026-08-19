import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/connection/concept/end_points.dart';
import '../../../../../../core/connection/interfaces/api_consumer.dart';
import '../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/common_fun.dart';
import '../../../../../../core/utils/functions/service_locator.dart';

part 'rate_property_estimation_event.dart';
part 'rate_property_estimation_state.dart';

class RatePropertyEstimationBloc
    extends Bloc<RatePropertyEstimationEvent, RatePropertyEstimationState> {
  RatePropertyEstimationBloc() : super(const RatePropertyEstimationState()) {
    on<RatePropertyEstimationTypeSelected>(_onTypeSelected);
    on<RatePropertyEstimationFieldChanged>(_onFieldChanged);
    on<RatePropertyEstimationCalculate>(_onCalculate);
    on<RatePropertyEstimationSave>(_onSaveRateProperty);
    on<SearchFromApiEvent>(_searchFromApi);
    on<PropertySelectedEvent>(_onPropertySelected);
  }
  final TextEditingController propertyController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController areaController = TextEditingController();

  /// Maps property names to their IDs for quick lookup
  final Map<String, String> propertyNameToIdMap = {};
  static RatePropertyEstimationBloc get(BuildContext context) =>
      BlocProvider.of<RatePropertyEstimationBloc>(context);

  void _onTypeSelected(
    RatePropertyEstimationTypeSelected event,
    Emitter<RatePropertyEstimationState> emit,
  ) {
    emit(state.copyWith(selectedType: event.typeId));
  }

  void _onFieldChanged(
    RatePropertyEstimationFieldChanged event,
    Emitter<RatePropertyEstimationState> emit,
  ) {
    emit(
      state.copyWith(
        location: event.location ?? state.location,
        area: event.area ?? state.area,
        propertyAge: event.propertyAge ?? state.propertyAge,
        finishingLevel: event.finishingLevel ?? state.finishingLevel,
        purpose: event.purpose ?? state.purpose,
      ),
    );
  }

  Future<void> _onCalculate(
    RatePropertyEstimationCalculate event,
    Emitter<RatePropertyEstimationState> emit,
  ) async {
    try {
      if (state.selectedType.isEmpty ||
          locationController.text.isEmpty ||
          areaController.text.isEmpty ||
          state.propertyAge.isEmpty ||
          state.finishingLevel == null ||
          state.purpose == null) {
        AppToast(AppStrings.pleaseFillForm);
        return;
      }
      emit(state.copyWith(analyzeStatus: RequestStatus.loading));
      final res = await sl.get<ApiConsumer>().post(
        EndPoints.evaluations,
        body: {
          'propertyType': state.selectedType,
          'location': locationController.text,
          'area': int.parse(areaController.text),
          'propertyAge': state.propertyAge,
          'finishing': state.finishingLevel,
          'purpose': state.purpose,
        },
      );
      await res.fold(
        (failureResponse) {
          AppToast(failureResponse);
          emit(state.copyWith(analyzeStatus: RequestStatus.failed));
        },
        (successResponse) {
          try {
            if (!successResponse.response['data']['hasMarketData']) {
              AppToast(AppStrings.noMarketData);
              emit(state.copyWith(analyzeStatus: RequestStatus.failed));
              return;
            }
            final evaluation = successResponse.response['data'];
            emit(
              state.copyWith(
                analyzeStatus: RequestStatus.success,
                dealsCount: evaluation['dealsCount'] ?? 0,
                minValue: double.parse(
                  evaluation['suggestedMin']?.toString() ?? '0',
                ),
                maxValue: double.parse(
                  evaluation['suggestedMax']?.toString() ?? '0',
                ),
                periodDays: evaluation['periodDays'] ?? 0,
                // reasons:[]
              ),
            );
          } catch (e) {
            AppToast(AppStrings.somethingWentWrong);
            emit(state.copyWith(analyzeStatus: RequestStatus.failed));
          }
        },
      );
    } catch (e) {
      AppToast(AppStrings.somethingWentWrong);
      emit(state.copyWith(analyzeStatus: RequestStatus.failed));
    }
  }

  Future<void> _searchFromApi(
    SearchFromApiEvent event,
    Emitter<RatePropertyEstimationState> emit,
  ) async {
    try {
      final response = await sl.get<ApiConsumer>().get(
        'properties',
        queryParameters: {'search': event.propertyName},
      );
      await response.fold(
        (failureResponse) {
          emit(state.copyWith(suggestedProperties: []));
        },
        (successResponse) {
          final List<String> properties = [];
          propertyNameToIdMap.clear();

          for (var item in successResponse.response['properties']) {
            final title = item['title'] as String;
            final id = item['property_id'] as String;
            properties.add(title);
            propertyNameToIdMap[title] = id;
          }
          emit(state.copyWith(suggestedProperties: properties));
        },
      );
    } catch (e) {
      print('Error searching properties: $e');
    }
  }

  void _onPropertySelected(
    PropertySelectedEvent event,
    Emitter<RatePropertyEstimationState> emit,
  ) {
    emit(state.copyWith(propertyId: event.propertyId));
    propertyController.text = event.propertyName;
  }

  Future<void> _onSaveRateProperty(
    RatePropertyEstimationSave event,
    Emitter<RatePropertyEstimationState> emit,
  ) async {
    try {
      emit(state.copyWith(saveStatus: RequestStatus.loading));
      final res = await sl.get<ApiConsumer>().post(
        EndPoints.saveEvaluations,
        body: {
          'propertyType': state.selectedType,
          'location': locationController.text,
          'area': int.parse(areaController.text),
          'propertyAge': state.propertyAge,
          'finishing': state.finishingLevel,
          'purpose': state.purpose,
        },
      );
      await res.fold(
        (failureResponse) {
          AppToast(failureResponse);
          emit(state.copyWith(saveStatus: RequestStatus.failed));
        },
        (successResponse) {
          emit(state.copyWith(saveStatus: RequestStatus.success));
        },
      );
    } catch (e) {
      AppToast(AppStrings.somethingWentWrong);
      emit(state.copyWith(saveStatus: RequestStatus.failed));
    }
  }
}
