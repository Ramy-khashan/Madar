import 'package:dartz/dartz.dart';

import '../../../modules/common/contract_details/model/contract_details_model.dart';
import '../../../modules/common/contracts/model/contract_model.dart';
import '../../connection/concept/end_points.dart';
import '../../connection/interfaces/api_consumer.dart';
import '../../utils/constants/app_strings.dart';
import '../../utils/functions/print_state.dart';
import '../../utils/functions/service_locator.dart';

class ContractsListResult {
  const ContractsListResult({
    required this.items,
    required this.total,
    required this.counts,
    this.hasNext = false,
  });

  final List<ContractModel> items;
  final int total;
  final Map<String, int> counts;
  final bool hasNext;
}

class ContractsApis {
  ContractsApis._();

  static Future<Either<String, ContractsListResult>> fetchContracts({
    required int page,
    required int pageSize,
    String? status,
  }) async {
    try {
      final query = <String, dynamic>{
        'page': page,
        'limit': pageSize,
        if (status != null && status.isNotEmpty && status != 'ALL')
          'status': status,
      };
      final response = await sl.get<ApiConsumer>().get(
        EndPoints.getContracts,
        queryParameters: query,
      );
      return response.fold((failed) => Left(failed), (success) {
        printState('GET /contracts: ${success.response}');
        return Right(_listFrom(success.response));
      });
    } catch (e) {
      printState('fetchContracts error: $e');
      return Left(AppStrings.somethingWentWrong);
    }
  }

  static Future<Either<String, ContractDetailsModel>> fetchDetails({
    required String contractId,
  }) async {
    try {
      final response = await sl.get<ApiConsumer>().get(
        EndPoints.contractDetails(contractId),
      );
      return response.fold((failed) => Left(failed), (success) {
        printState('GET /contracts/$contractId: ${success.response}');
        return Right(ContractDetailsModel.fromJson(
          Map<String, dynamic>.from(success.response as Map),
        ));
      });
    } catch (e) {
      printState('fetchContractDetails error: $e');
      return Left(AppStrings.somethingWentWrong);
    }
  }

  static Future<Either<String, dynamic>> approve({
    required String contractId,
    required String durationInYears,
    required num finalPrice,
  }) async {
    try {
      final response = await sl.get<ApiConsumer>().patch(
        EndPoints.approveContract(contractId),
        body: {
          if (durationInYears.trim().isNotEmpty)
            'durationInYears': durationInYears,
          'finalPrice': finalPrice,
        },
      );
      return response.fold((failed) => Left(failed), (success) {
        printState('PATCH /contracts/$contractId/approve: ${success.response}');
        return Right(success.response);
      });
    } catch (e) {
      printState('approveContract error: $e');
      return Left(AppStrings.somethingWentWrong);
    }
  }

  static Future<Either<String, dynamic>> reject({
    required String contractId,
  }) async {
    try {
      final response = await sl.get<ApiConsumer>().patch(
        EndPoints.rejectContract(contractId),
        body: <String, dynamic>{},
      );
      return response.fold((failed) => Left(failed), (success) {
        printState('PATCH /contracts/$contractId/reject: ${success.response}');
        return Right(success.response);
      });
    } catch (e) {
      printState('rejectContract error: $e');
      return Left(AppStrings.somethingWentWrong);
    }
  }

  static Future<Either<String, dynamic>> renew({
    required String contractId,
  }) async {
    try {
      final response = await sl.get<ApiConsumer>().post(
        EndPoints.renewContract,
        body: {'contractId': contractId},
      );
      return response.fold((failed) => Left(failed), (success) {
        printState('POST /contracts/renew: ${success.response}');
        return Right(success.response);
      });
    } catch (e) {
      printState('renewContract error: $e');
      return Left(AppStrings.somethingWentWrong);
    }
  }

  static ContractsListResult _listFrom(dynamic body) {
    if (body is! Map) {
      return const ContractsListResult(items: [], total: 0, counts: {});
    }
    final map = Map<String, dynamic>.from(body);
    final raw = map['contracts'] ?? map['data'] ?? map;
    var counts = const <String, int>{};
    var total = 0;
    var hasNext = false;
    List list = const [];

    if (raw is Map) {
      counts = _countsFrom(raw['counts']);
      final pagination = raw['pagination'];
      if (pagination is Map) {
        total = _asInt(pagination['total']) ?? counts['all'] ?? 0;
        hasNext = pagination['hasNext'] == true || pagination['has_next'] == true;
      }
      final data = raw['data'] ?? raw['items'] ?? raw['list'] ?? [];
      if (data is List) list = data;
    } else if (raw is List) {
      list = raw;
      total = _asInt(map['total']) ?? list.length;
    }

    if (total == 0) total = counts['all'] ?? list.length;

    final items = list
        .whereType<Map>()
        .map((e) => ContractModel.fromJson(Map<String, dynamic>.from(e)))
        .where((e) => (e.id ?? '').isNotEmpty)
        .toList();

    return ContractsListResult(
      items: items,
      total: total,
      counts: counts,
      hasNext: hasNext,
    );
  }

  static Map<String, int> _countsFrom(dynamic raw) {
    if (raw is! Map) return const {};
    return raw.map((key, value) => MapEntry('$key', _asInt(value) ?? 0));
  }

  static int? _asInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '');
  }
}
