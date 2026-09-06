import 'package:dartz/dartz.dart';

import '../../connection/concept/end_points.dart';
import '../../connection/interfaces/api_consumer.dart';
import '../../utils/constants/app_strings.dart';
import '../../utils/functions/print_state.dart';
import '../../utils/functions/service_locator.dart';

class DashboardApis {
  DashboardApis._();

  static Future<Either<String, Map<String, dynamic>>> fetch(
    String path, {
    String? period,
    // String? scope,
    List<String>? propertyTypes,
  }) async {
    try {
      final query = <String, dynamic>{};
      if (period != null && period.isNotEmpty) query['period'] = period;
      // if (scope != null && scope.isNotEmpty) query['scope'] = scope;
      if (propertyTypes != null && propertyTypes.isNotEmpty) {
        query['type'] = propertyTypes.join(',');
      }
      final response = await sl.get<ApiConsumer>().get(
        path,
        queryParameters: query.isEmpty ? null : query,
      );
      return response.fold((failed) => Left(failed), (success) {
        printState('$path: ${success.response}');
        final data = success.response['data'];
        if (data is Map) {
          return Right(Map<String, dynamic>.from(data));
        }
        return Left(AppStrings.somethingWentWrong);
      });
    } catch (e) {
      printState('$path error: $e');
      return Left(AppStrings.somethingWentWrong);
    }
  }

  static Future<Either<String, Map<String, dynamic>>> overview({
    required String period,
    // String? scope,
  }) async {
    final overview = await fetch(
      EndPoints.financialReportsOverview,
      period: period,
      // scope: scope,
    );
    if (overview.isRight()) return overview;
    return fetch(EndPoints.financialReports, period: period /* , scope: scope */);
  }

  static Future<Either<String, Map<String, dynamic>>> revenues({
    required String period,
    // String? scope,
  }) => fetch(EndPoints.dashboardRevenues, period: period /* , scope: scope */);

  static Future<Either<String, Map<String, dynamic>>> expenses({
    required String period,
    // String? scope,
  }) => fetch(EndPoints.dashboardExpenses, period: period /* , scope: scope */);

  static Future<Either<String, Map<String, dynamic>>> profitLoss({
    String? period,
    // String? scope,
  }) => fetch(EndPoints.netProfitLoss, period: period /* , scope: scope */);

  static Future<Either<String, Map<String, dynamic>>> performance({
    required String period,
    // String? scope,
    List<String>? propertyTypes,
  }) => fetch(
    EndPoints.performanceReports,
    period: period,
    // scope: scope,
    propertyTypes: propertyTypes,
  );

  static Future<Either<String, Map<String, dynamic>>> addOtherIncome({
    required String title,
    required num amount,
  }) async {
    try {
      final response = await sl.get<ApiConsumer>().post(
        EndPoints.dashboardOtherIncome,
        body: {'title': title, 'amount': amount},
      );
      return response.fold(Left.new, (success) {
        printState('${EndPoints.dashboardOtherIncome}: ${success.response}');
        final data = success.response['data'];
        if (data is Map) {
          return Right(Map<String, dynamic>.from(data));
        }
        return const Right(<String, dynamic>{});
      });
    } catch (e) {
      printState('addOtherIncome error: $e');
      return Left(AppStrings.somethingWentWrong);
    }
  }
}
