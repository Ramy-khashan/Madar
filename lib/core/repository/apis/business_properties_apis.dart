import 'package:dartz/dartz.dart';

import '../../../modules/pages/business/business_properties/model/business_property_request_model.dart';
import '../../connection/concept/end_points.dart';
import '../../connection/interfaces/api_consumer.dart';
import '../../utils/constants/app_strings.dart';
import '../../utils/functions/print_state.dart';
import '../../utils/functions/service_locator.dart';
import 'user_requests_apis.dart';

class BusinessPropertiesApis {
  BusinessPropertiesApis._();

  static const approveAction = 'APPROVE';
  static const rejectAction = 'REJECT';

  static Future<Either<String, List<BusinessPropertyRequestModel>>>
  fetchRequests() async {
    try {
      final response = await sl.get<ApiConsumer>().get(EndPoints.requests);
      return response.fold((failed) => Left(failed), (success) {
        printState('broker/requests: ${success.response}');
        final items = _mapsFrom(success.response)
            .map(BusinessPropertyRequestModel.fromJson)
            .where((e) => (e.requestId ?? '').isNotEmpty)
            .toList();
        return Right(items);
      });
    } catch (e) {
      printState('fetchRequests error: $e');
      return Left(AppStrings.somethingWentWrong);
    }
  }

  static Future<Either<String, List<BusinessRequestPublishedPropertyModel>>>
  fetchPublished() async {
    try {
      final items = <BusinessRequestPublishedPropertyModel>[];
      var page = 1;
      const pageSize = 50;
      while (page <= 10) {
        final response = await sl.get<ApiConsumer>().get(
          EndPoints.incomingRequests,
          queryParameters: {'page': page, 'limit': pageSize},
        );
        String? error;
        dynamic body;
        response.fold((failed) => error = failed, (success) {
          body = success.response;
        });
        if (error != null) {
          return items.isEmpty ? Left(error!) : Right(items);
        }
        printState('requests/incoming page $page: $body');
        items.addAll(
          _mapsFrom(body)
              .map(BusinessRequestPublishedPropertyModel.fromJson)
              .where((e) => e.id.isNotEmpty),
        );
        if (!_hasNextPage(body)) break;
        page++;
      }
      return Right(items);
    } catch (e) {
      printState('fetchPublished error: $e');
      return Left(AppStrings.somethingWentWrong);
    }
  }

  static Future<Either<String, dynamic>> respondToRequest({
    required String requestId,
    required String action,
    String? adLicenseNumber,
    String? rejectReason,
    bool isIncoming = false,
  }) async {
    try {
      final path = isIncoming
          ? EndPoints.propertyRequestStatus(requestId)
          : EndPoints.brokerRequestAction(requestId);
      final body = isIncoming
          ? <String, dynamic>{
              'status': action == approveAction
                  ? UserRequestsApis.approvedStatus
                  : UserRequestsApis.rejectedStatus,
              if (action == rejectAction &&
                  (rejectReason?.trim().isNotEmpty ?? false))
                'rejectReason': rejectReason!.trim(),
            }
          : <String, dynamic>{
              'action': action,
              if (action == approveAction)
                'adLicenseNumber': adLicenseNumber?.trim() ?? '',
              if (action == rejectAction)
                'rejectReason': rejectReason?.trim() ?? '',
            };
      final response = await sl.get<ApiConsumer>().patch(path, body: body);
      return response.fold((failed) => Left(failed), (success) {
        printState(
          '${isIncoming ? 'incoming' : 'broker'} request $action: ${success.response}',
        );
        return Right(success.response);
      });
    } catch (e) {
      printState('request $action error: $e');
      return Left(AppStrings.somethingWentWrong);
    }
  }

  static List<Map<String, dynamic>> _mapsFrom(dynamic body) {
    dynamic raw = body;
    if (raw is Map) {
      raw =
          raw['data'] ??
          raw['requests'] ??
          raw['items'] ??
          raw['properties'] ??
          raw;
      if (raw is Map) {
        raw =
            raw['data'] ??
            raw['items'] ??
            raw['requests'] ??
            raw['properties'] ??
            raw['list'] ??
            [];
      }
    }
    if (raw is! List) return const [];
    return raw
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }

  static bool _hasNextPage(dynamic body) {
    if (body is! Map) return false;
    dynamic pagination = body['pagination'];
    final requests = body['requests'];
    if (pagination == null && requests is Map) {
      pagination = requests['pagination'];
    }
    if (pagination is! Map) return false;
    return pagination['hasNext'] == true || pagination['has_next'] == true;
  }
}
