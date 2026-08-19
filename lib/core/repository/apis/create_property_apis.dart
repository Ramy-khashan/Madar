import 'package:dartz/dartz.dart';

import '../../../modules/pages/individual/add_property/model/add_property_model.dart';
import '../../../modules/pages/individual/add_property/model/add_property_request_mapper.dart';
import '../../../modules/pages/individual/add_property/model/create_property_request_model.dart';
import '../../connection/concept/end_points.dart';
import '../../connection/interfaces/api_consumer.dart';
import '../../utils/constants/app_strings.dart';
import '../../utils/functions/print_state.dart';
import '../../utils/functions/service_locator.dart';

class EvaluationPreview {
  const EvaluationPreview({
    required this.hasMarketData,
    this.suggestedMin,
    this.suggestedMax,
    this.aiDescription,
  });

  final bool hasMarketData;
  final num? suggestedMin;
  final num? suggestedMax;
  final String? aiDescription;
}

class CreatePropertyApis {
  CreatePropertyApis._();

  /// `POST /properties` as multipart form data.
  ///
  /// Returns the created property payload on success, or a user-facing error
  /// message on failure.
  static Future<Either<String, dynamic>> createProperty(
    CreatePropertyRequestModel request,
  ) async {
    try {
      printState("Property Request: " + request.toJson().toString());
      final formData = await request.toFormData();

      printState(
        'Creating ${request.type} property with '
        '${formData.fields.length} fields and ${formData.files.length} files',
      );

      final response = await sl.get<ApiConsumer>().postFormData(
        EndPoints.properties,
        body: formData,
      );

      return response.fold(
        (failedResponse) => Left(failedResponse),
        (successResponse) => Right(successResponse.response['data']),
      );
    } catch (e) {
      printState('Error creating property: $e');
      return Left(AppStrings.somethingWentWrong);
    }
  }

  /// `POST /evaluations/preview` — suggested price range + AI description.
  static Future<Either<String, EvaluationPreview>> previewEvaluation(
    AddPropertyModel model,
  ) async {
    try {
      final body = model.toEvaluationPreviewBody();
      printState('Preview evaluation body: $body');

      final response = await sl.get<ApiConsumer>().post(
        EndPoints.evaluationPreview,
        body: body,
      );

      return response.fold((failedResponse) => Left(failedResponse), (
        successResponse,
      ) {
        final data = successResponse.response['data'];
        final dataMap = data is Map ? data : const {};
        final smart = dataMap['smartEvaluation'];
        final smartMap = smart is Map ? smart : const {};
        return Right(
          EvaluationPreview(
            hasMarketData: smartMap['hasMarketData'] == true,
            suggestedMin: num.tryParse('${smartMap['suggestedMin'] ?? ''}'),
            suggestedMax: num.tryParse('${smartMap['suggestedMax'] ?? ''}'),
            aiDescription: dataMap['aiDescription']?.toString(),
          ),
        );
      });
    } catch (e) {
      printState('Error previewing evaluation: $e');
      return Left(AppStrings.somethingWentWrong);
    }
  }
}
