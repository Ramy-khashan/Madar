import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../model/api_model.dart';
 
abstract class ApisCalls {
  Future<Either<String, ApiModel>> globalApiGet(String path,
      {Map<String, dynamic>? queryParameters});
  Future<Either<String, ApiModel>> get(String path,
      {Map<String, dynamic>? queryParameters});
  Future<Either<String, ApiModel>> getPrivate(String path,
      {Map<String, dynamic>? queryParameters});
  Future<Either<String, ApiModel>> post(String path,
      {Map<String, dynamic> body, Map<String, dynamic>? queryParameters});
  Future<Either<String, ApiModel>> auth(String path,
      {Map<String, dynamic> body, Map<String, dynamic>? queryParameters});
  Future<Either<String, ApiModel>> put(String path,
      {Map<String, dynamic> body, Map<String, dynamic>? queryParameters});
  Future<Either<String, ApiModel>> delete(String path,
      {Map<String, dynamic>? queryParameters});
  Future<Either<String, ApiModel>> patch(String path,
      {Map<String, dynamic>? body, Map<String, dynamic>? queryParameters});
  Future<Either<String, ApiModel>> patchFormData(String path,
      {FormData body, Map<String, dynamic>? queryParameters});
}
