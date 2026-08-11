import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../modules/pages/business/real_estate_development/add_project/shared/models/project_request_base.dart';
import '../../../modules/pages/business/real_estate_development/add_project/shared/models/project_stage_model.dart';
import '../../connection/concept/end_points.dart';
import '../../connection/interfaces/api_consumer.dart';
import '../../utils/constants/app_strings.dart';
import '../../utils/functions/print_state.dart';
import '../../utils/functions/service_locator.dart';

class RealEstateProjectsApis {
  RealEstateProjectsApis._();

  static Future<Either<String, List<ProjectStageModel>>> fetchProjectStages(
    String projectType,
  ) async {
    try {
      final response = await sl.get<ApiConsumer>().get(
        EndPoints.projectStages(projectType),
      );
      return response.fold((failedResponse) => Left(failedResponse), (
        successResponse,
      ) {
        printState(
          'Fetched stages for project type $projectType: ${successResponse.response}',
        );
        final data = successResponse.response['data'] as List<dynamic>?;
        if (data == null) {
          return const Right([]);
        }
        final stages = data
            .map((e) => ProjectStageModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return Right(stages);
      });
    } catch (e) {
      printState('Error fetching stages for project type $projectType: $e');
      return Left(AppStrings.somethingWentWrong);
    }
  }

  static Future<Either<String, dynamic>> createProject(
    ProjectRequestBase request,
    List<String> imagePaths,
  ) async {
    try {
      final stagesJson = jsonEncode(
        request.stages.map((s) => s.toJson()).toList(),
      );

      final managerJson = jsonEncode(request.manager.toJson());

      final formData = FormData.fromMap({
        'projectName': request.projectName,
        'location': request.location,
        'startDate': request.startDate,
        'endDate': request.endDate,
        'price': request.price,
        'type': request.type,
        'stages': stagesJson,
        'manager': managerJson,
      });

      for (final path in imagePaths) {
        formData.files.add(
          MapEntry(
            'attachments',
            await MultipartFile.fromFile(path, filename: path.split('/').last),
          ),
        );
      }

      final response = await sl.get<ApiConsumer>().postFormData(
        EndPoints.realStateProjectCreation,
        body: formData,
      );

      return response.fold(
        (failedResponse) => Left(failedResponse),
        (successResponse) => Right(successResponse.response['data']),
      );
    } catch (e) {
      return Left(AppStrings.somethingWentWrong);
    }
  }
}
