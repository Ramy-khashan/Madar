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
  }) async {
    try {
      final response = await sl.get<ApiConsumer>().get(
        path,
        queryParameters: period == null || period.isEmpty
            ? null
            : {'period': period},
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
  }) async {
    final overview = await fetch(
      EndPoints.financialReportsOverview,
      period: period,
    );
    if (overview.isRight()) return overview;
    return fetch(EndPoints.financialReports, period: period);
  }

  static Future<Either<String, Map<String, dynamic>>> revenues({
    required String period,
  }) => fetch(EndPoints.dashboardRevenues, period: period);

  static Future<Either<String, Map<String, dynamic>>> expenses({
    required String period,
  }) => fetch(EndPoints.dashboardExpenses, period: period);

  static Future<Either<String, Map<String, dynamic>>> profitLoss({
    String? period,
  }) => fetch(EndPoints.netProfitLoss, period: period);

  static Future<Either<String, Map<String, dynamic>>> performance({
    required String period,
  }) => fetch(EndPoints.performanceReports, period: period);
}
