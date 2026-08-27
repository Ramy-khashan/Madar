import 'package:dartz/dartz.dart';

import '../../../modules/pages/individual/my_requests/model/my_property_request_model.dart';
import '../../connection/concept/end_points.dart';
import '../../connection/interfaces/api_consumer.dart';
import '../../utils/constants/app_strings.dart';
import '../../utils/functions/print_state.dart';
import '../../utils/functions/service_locator.dart';

class UserRequestsApis {
  UserRequestsApis._();

  static const approvedStatus = 'approved';
  static const rejectedStatus = 'rejected';

  static Future<Either<String, MyPropertyRequestModel>> createRequest({
    required String propertyId,
  }) async {
    try {
      final response = await sl.get<ApiConsumer>().post(
        EndPoints.propertyRequests,
        body: {'propertyId': propertyId},
      );
      return response.fold((failed) => Left(failed), (success) {
        printState('POST /requests: ${success.response}');
        final model = _requestFrom(success.response);
        if (model == null || model.id.isEmpty) {
          return Left(AppStrings.somethingWentWrong);
        }
        return Right(model);
      });
    } catch (e) {
      printState('createRequest error: $e');
      return Left(AppStrings.somethingWentWrong);
    }
  }

  static Future<Either<String, List<MyPropertyRequestModel>>>
  fetchMyRequests() async {
    try {
      final response = await sl.get<ApiConsumer>().get(
        EndPoints.myPropertyRequests,
      );
      return response.fold((failed) => Left(failed), (success) {
        printState('GET /requests/me: ${success.response}');
        return Right(
          _mapsFrom(success.response)
              .map(MyPropertyRequestModel.fromJson)
              .where((e) => e.id.isNotEmpty)
              .toList(),
        );
      });
    } catch (e) {
      printState('fetchMyRequests error: $e');
      return Left(AppStrings.somethingWentWrong);
    }
  }

  static Future<Either<String, MyPropertyRequestModel>> fetchRequestDetails({
    required String requestId,
  }) async {
    try {
      final response = await sl.get<ApiConsumer>().get(
        EndPoints.propertyRequestById(requestId),
      );
      return response.fold((failed) => Left(failed), (success) {
        printState('GET /requests/$requestId: ${success.response}');
        final model = _requestFrom(success.response);
        if (model == null || model.id.isEmpty) {
          return Left(AppStrings.somethingWentWrong);
        }
        return Right(model);
      });
    } catch (e) {
      printState('fetchRequestDetails error: $e');
      return Left(AppStrings.somethingWentWrong);
    }
  }

  static Future<Either<String, List<MyPropertyRequestModel>>>
  fetchPropertyRequests({required String propertyId}) async {
    try {
      final response = await sl.get<ApiConsumer>().get(
        EndPoints.propertyRequestsByProperty(propertyId),
      );
      return response.fold((failed) => Left(failed), (success) {
        printState('GET /requests/property/$propertyId: ${success.response}');
        return Right(
          _mapsFrom(success.response)
              .map(MyPropertyRequestModel.fromJson)
              .where((e) => e.id.isNotEmpty)
              .toList(),
        );
      });
    } catch (e) {
      printState('fetchPropertyRequests error: $e');
      return Left(AppStrings.somethingWentWrong);
    }
  }

  static Future<Either<String, dynamic>> updateRequestStatus({
    required String requestId,
    required String status,
    String? rejectReason,
  }) async {
    try {
      final body = <String, dynamic>{'status': status};
      if (rejectReason != null && rejectReason.trim().isNotEmpty) {
        body['rejectReason'] = rejectReason.trim();
      }
      final response = await sl.get<ApiConsumer>().patch(
        EndPoints.propertyRequestStatus(requestId),
        body: body,
      );
      return response.fold((failed) => Left(failed), (success) {
        printState(
          'PATCH /requests/$requestId/status: ${success.response}',
        );
        return Right(success.response);
      });
    } catch (e) {
      printState('updateRequestStatus error: $e');
      return Left(AppStrings.somethingWentWrong);
    }
  }

  static Future<Either<String, dynamic>> deleteRequest({
    required String requestId,
  }) async {
    try {
      final response = await sl.get<ApiConsumer>().delete(
        EndPoints.propertyRequestById(requestId),
      );
      return response.fold((failed) => Left(failed), (success) {
        printState('DELETE /requests/$requestId: ${success.response}');
        return Right(success.response);
      });
    } catch (e) {
      printState('deleteRequest error: $e');
      return Left(AppStrings.somethingWentWrong);
    }
  }

  static MyPropertyRequestModel? _requestFrom(dynamic body) {
    if (body is! Map) return null;
    final map = Map<String, dynamic>.from(body);
    final data = map['data'];
    if (data is Map) {
      return MyPropertyRequestModel.fromJson({
        ...map,
        ...Map<String, dynamic>.from(data),
      });
    }
    return MyPropertyRequestModel.fromJson(map);
  }

  static List<Map<String, dynamic>> _mapsFrom(dynamic body) {
    dynamic raw = body;
    if (raw is Map) {
      raw =
          raw['data'] ??
          raw['requests'] ??
          raw['items'] ??
          raw['results'] ??
          raw;
      if (raw is Map) {
        if (raw['request'] is Map) {
          return [Map<String, dynamic>.from(raw)];
        }
        raw =
            raw['data'] ??
            raw['items'] ??
            raw['requests'] ??
            raw['list'] ??
            raw['results'] ??
            [];
      }
    }
    if (raw is! List) return const [];
    return raw
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }
}
