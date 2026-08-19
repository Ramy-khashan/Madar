import 'package:dartz/dartz.dart';

import '../../connection/concept/end_points.dart';
import '../../connection/interfaces/api_consumer.dart';
import '../../utils/constants/app_strings.dart';
import '../../utils/functions/service_locator.dart';

class WishlistApis {
  WishlistApis._(); 
  static Future<Either<String, dynamic>> getWishlist() async {
    try {
      final response = await sl.get<ApiConsumer>().get(EndPoints.wishlist);
      return response.fold(
        (failedResponse) => Left(failedResponse),
        (successResponse) => Right(successResponse.response['data']['data']),
      );
    } catch (e) {
      return Left(AppStrings.somethingWentWrong);
    }
  }

  static Future<Either<String, dynamic>> addToWishlist(String id) async {
    try {
      final response = await sl.get<ApiConsumer>().post(
        EndPoints.addToWishlist(id),
      );
      return response.fold(
        (failedResponse) => Left(failedResponse),
        (successResponse) => Right(successResponse.response['data']),
      );
    } catch (e) {
      return Left(AppStrings.somethingWentWrong);
    }
  }

  static Future<Either<String, dynamic>> removeFromWishlist(String id) async {
    try {
      final response = await sl.get<ApiConsumer>().post(
        EndPoints.removeFromWishlist(id),
      );
      return response.fold(
        (failedResponse) => Left(failedResponse),
        (successResponse) => Right(successResponse.response['data']),
      );
    } catch (e) {
      return Left(AppStrings.somethingWentWrong);
    }
  }

  static Future<Either<String, dynamic>> wishlistCount() async {
    try {
      final response = await sl.get<ApiConsumer>().get(EndPoints.wishlistCount);
      return response.fold(
        (failedResponse) => Left(failedResponse),
        (successResponse) => Right(successResponse.response['data']),
      );
    } catch (e) {
      return Left(AppStrings.somethingWentWrong);
    }
  }

  static Future<Either<String, dynamic>> checkWishlist(String id) async {
    try {
      final response = await sl.get<ApiConsumer>().get(
        EndPoints.checkWishlist(id),
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
