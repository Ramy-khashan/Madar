import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../modules/pages/individual/property_details/model/property_details_model.dart';
import '../../../modules/pages/properties_file_operation/property_file/model/property_file_model.dart';
import '../../connection/concept/end_points.dart';
import '../../connection/interfaces/api_consumer.dart';
import '../../utils/constants/app_strings.dart';
import '../../utils/functions/print_state.dart';
import '../../utils/functions/service_locator.dart';

class PropertyFileApis {
  PropertyFileApis._();

  static Future<Either<String, PropertyDetailsModel>> getProperty(
    String propertyId,
  ) async {
    try {
      final response = await sl.get<ApiConsumer>().get(
        EndPoints.propertyById(propertyId),
      );
      return response.fold(Left.new, (success) {
        final data = success.response['data'];
        if (data is! Map) return Left(AppStrings.somethingWentWrong);
        return Right(
          PropertyDetailsModel.fromJson(Map<String, dynamic>.from(data)),
        );
      });
    } catch (e) {
      printState('getProperty error: $e');
      return Left(AppStrings.somethingWentWrong);
    }
  }

  static Future<Either<String, PropertyDetailsModel>> updateProperty({
    required String propertyId,
    required String title,
    String? projectName,
  }) async {
    try {
      final body = <String, dynamic>{'title': title};
      if (projectName != null) body['projectName'] = projectName;
      final response = await sl.get<ApiConsumer>().put(
        EndPoints.propertyById(propertyId),
        body: body,
      );
      return response.fold(Left.new, (success) {
        final data = success.response['data'];
        if (data is Map) {
          return Right(
            PropertyDetailsModel.fromJson(Map<String, dynamic>.from(data)),
          );
        }
        return Right(PropertyDetailsModel(propertyId: propertyId, title: title));
      });
    } catch (e) {
      printState('updateProperty error: $e');
      return Left(AppStrings.somethingWentWrong);
    }
  }

  static Future<Either<String, Unit>> deleteProperty(String propertyId) async {
    try {
      final response = await sl.get<ApiConsumer>().delete(
        EndPoints.propertyById(propertyId),
      );
      return response.fold(Left.new, (_) => const Right(unit));
    } catch (e) {
      printState('deleteProperty error: $e');
      return Left(AppStrings.somethingWentWrong);
    }
  }

  static Future<Either<String, Unit>> saveExpenses({
    required String propertyId,
    required List<UnitExpenseModel> expenses,
    List<String> filePaths = const [],
  }) async {
    try {
      final form = FormData();
      form.fields.add(MapEntry('propertyId', propertyId));
      form.fields.add(
        MapEntry(
          'expenses',
          jsonEncode(
            expenses
                .where((e) => !e.isRemote)
                .map(
                  (e) => {'type': e.description, 'amount': e.amount},
                )
                .toList(),
          ),
        ),
      );
      for (final path in filePaths) {
        form.files.add(
          MapEntry(
            'file',
            await MultipartFile.fromFile(
              path,
              filename: path.split('/').last,
            ),
          ),
        );
      }
      final response = await sl.get<ApiConsumer>().postFormData(
        EndPoints.ownerPropertyExpense,
        body: form,
      );
      return response.fold(Left.new, (_) => const Right(unit));
    } catch (e) {
      printState('saveExpenses error: $e');
      return Left(AppStrings.somethingWentWrong);
    }
  }
}
