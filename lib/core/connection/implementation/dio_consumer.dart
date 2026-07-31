import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';

import '../../../config/router/app_router_keys.dart';
import '../../../madar_app.dart';
import '../../model/api_model.dart';
import '../../model/error_handler_model.dart';
import '../../repository/error_tracking/crashlytics_collector.dart';
import '../../utils/constants/app_enums.dart';
import '../../utils/constants/storage_keys.dart';
import '../../utils/functions/camil_case.dart';
import '../../utils/functions/common_fun.dart';
import '../../utils/functions/handle_multi_callback.dart';
import '../../utils/functions/preference_utils.dart';
import '../../utils/functions/router_handler.dart';
import '../../utils/functions/service_locator.dart';
import '../concept/end_points.dart';
import '../concept/exceptions.dart';
import '../concept/status_code.dart';
import '../interfaces/api_consumer.dart';
import '../interfaces/network_info.dart';

class DioConsumer implements ApiConsumer {
  final Dio client;

  DioConsumer({required this.client}) {
    client.interceptors.addAll([
      _connectivityInterceptor(),
      _authInterceptor(),
      if (kDebugMode) HttpFormatter(),
    ]);

    client.options
      ..baseUrl = EndPoints.baseUrl
      ..connectTimeout = const Duration(milliseconds: 30000)
      ..receiveTimeout = const Duration(milliseconds: 30000)
      ..responseType = ResponseType.plain
      ..followRedirects = false
      ..validateStatus = (status) {
        return status != null && status < 500 ;
      };
  }

  // ---------------------------------------------------------------------------
  // Public API methods
  // ---------------------------------------------------------------------------

  @override
  Future<Either<String, ApiModel>> globalApiGet(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await client.get(path, queryParameters: queryParameters);
      final isError =
          response.statusCode == StatusCode.badRequest ||
          response.statusCode == StatusCode.forbidden ||
          response.statusCode == StatusCode.notFound;

      return isError
          ? left(
              handleResponseAsJson(response)['message']?.toString() ?? 'Error',
            )
          : right(
              ApiModel(
                response: handleResponseAsJson(response),
                statusCode: response.statusCode!,
              ),
            );
    } on DioException catch (e, stackTrace) {
      await CrashlyticsCollector().logCaughtError(
        error: e,
        stackTrace: stackTrace,
        location: 'DioConsumer.globalApiGet',
        operation: 'Global API GET Request',
        contextData: {
          'path': path,
          'query_parameters': queryParameters,
          'endpoint_type': 'global_api',
        },
      );
      return left(handleDioError(e).toString());
    } catch (e, stackTrace) {
      await CrashlyticsCollector().logCaughtError(
        error: e,
        stackTrace: stackTrace,
        location: 'DioConsumer.globalApiGet',
        operation: 'Unexpected Error in Global API GET',
        contextData: {'path': path, 'query_parameters': queryParameters},
        isExpected: false,
      );
      return left('Unexpected error occurred');
    }
  }

  @override
  Future<Either<String, ApiModel>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await client.get(path, queryParameters: queryParameters);
      return handleResponseStatus(response);
    } on DioException catch (e, stackTrace) {
      await CrashlyticsCollector().logCaughtError(
        error: e,
        stackTrace: stackTrace,
        location: 'DioConsumer.get',
        operation: 'API GET Request',
        contextData: {'path': path, 'query_parameters': queryParameters},
      );
      return left(handleDioError(e).toString());
    } catch (e, stackTrace) {
      await CrashlyticsCollector().logCaughtError(
        error: e,
        stackTrace: stackTrace,
        location: 'DioConsumer.get',
        operation: 'Unexpected Error in API GET',
        contextData: {'path': path, 'query_parameters': queryParameters},
        isExpected: false,
      );
      return left('Unexpected error occurred');
    }
  }

  @override
  Future<Either<String, ApiModel>> getPrivate(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await client.get(
        path,
        queryParameters: queryParameters,
      );
      return handleResponseStatus(response);
    } on DioException catch (e, stackTrace) {
      await CrashlyticsCollector().logCaughtError(
        error: e,
        stackTrace: stackTrace,
        location: 'DioConsumer.getPrivate',
        operation: 'Private API GET Request',
        contextData: {'path': path, 'query_parameters': queryParameters},
      );
      return left(handleDioError(e).toString());
    } catch (e, stackTrace) {
      await CrashlyticsCollector().logCaughtError(
        error: e,
        stackTrace: stackTrace,
        location: 'DioConsumer.getPrivate',
        operation: 'Unexpected Error in Private API GET',
        contextData: {'path': path, 'query_parameters': queryParameters},
        isExpected: false,
      );
      return left('Unexpected error occurred');
    }
  }

  @override
  Future<Either<String, ApiModel>> post(
    String path, {
    dynamic body,
    bool formDataIsEnabled = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await client.post(
        path,
        queryParameters: queryParameters,
        data: body,
      );
      return handleResponseStatus(response);
    } on DioException catch (e, stackTrace) {
      await CrashlyticsCollector().logCaughtError(
        error: e,
        stackTrace: stackTrace,
        location: 'DioConsumer.post',
        operation: 'API POST Request',
        contextData: {
          'path': path,
          'has_body': body != null,
          'body_type': body.runtimeType.toString(),
          'form_data_enabled': formDataIsEnabled,
          'query_parameters': queryParameters,
          'request_size_estimate': body?.toString().length ?? 0,
        },
      );
      return left(handleDioError(e).toString());
    } catch (e, stackTrace) {
      await CrashlyticsCollector().logCaughtError(
        error: e,
        stackTrace: stackTrace,
        location: 'DioConsumer.post',
        operation: 'Unexpected Error in API POST',
        contextData: {
          'path': path,
          'has_body': body != null,
          'form_data_enabled': formDataIsEnabled,
          'query_parameters': queryParameters,
        },
        isExpected: false,
      );
      return left('Unexpected error occurred');
    }
  }

  @override
  Future<Either<String, ApiModel>> put(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await client.put(
        path,
        queryParameters: queryParameters,
        data: body,
      );
      return handleResponseStatus(response);
    } on DioException catch (e, stackTrace) {
      await CrashlyticsCollector().logCaughtError(
        error: e,
        stackTrace: stackTrace,
        location: 'DioConsumer.put',
        operation: 'API PUT Request',
        contextData: {
          'path': path,
          'has_body': body != null,
          'query_parameters': queryParameters,
        },
      );
      return left(handleDioError(e).toString());
    } catch (e, stackTrace) {
      await CrashlyticsCollector().logCaughtError(
        error: e,
        stackTrace: stackTrace,
        location: 'DioConsumer.put',
        operation: 'Unexpected Error in API PUT',
        contextData: {'path': path, 'query_parameters': queryParameters},
        isExpected: false,
      );
      return left('Unexpected error occurred');
    }
  }

  @override
  Future<Either<String, ApiModel>> patch(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await client.patch(
        path,
        queryParameters: queryParameters,
        data: body,
      );
      return handleResponseStatus(response);
    } on DioException catch (e, stackTrace) {
      await CrashlyticsCollector().logCaughtError(
        error: e,
        stackTrace: stackTrace,
        location: 'DioConsumer.patch',
        operation: 'API PATCH Request',
        contextData: {
          'path': path,
          'has_body': body != null,
          'query_parameters': queryParameters,
        },
      );
      return left(handleDioError(e).toString());
    } catch (e, stackTrace) {
      await CrashlyticsCollector().logCaughtError(
        error: e,
        stackTrace: stackTrace,
        location: 'DioConsumer.patch',
        operation: 'Unexpected Error in API PATCH',
        contextData: {'path': path, 'query_parameters': queryParameters},
        isExpected: false,
      );
      return left('Unexpected error occurred');
    }
  }

  @override
  Future<Either<String, ApiModel>> patchFormData(
    String path, {
    FormData? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await client.patch(
        path,
        queryParameters: queryParameters,
        data: body,
        options: Options(headers: {'Accept': 'application/json'}),
      );
      return handleResponseStatus(response);
    } on DioException catch (e, stackTrace) {
      await CrashlyticsCollector().logCaughtError(
        error: e,
        stackTrace: stackTrace,
        location: 'DioConsumer.patchFormData',
        operation: 'API PATCH FormData Request',
        contextData: {
          'path': path,
          'has_body': body != null,
          'form_fields': body?.fields.length ?? 0,
          'query_parameters': queryParameters,
        },
      );
      return left(handleDioError(e).toString());
    } catch (e, stackTrace) {
      await CrashlyticsCollector().logCaughtError(
        error: e,
        stackTrace: stackTrace,
        location: 'DioConsumer.patchFormData',
        operation: 'Unexpected Error in API PATCH FormData',
        contextData: {'path': path, 'query_parameters': queryParameters},
        isExpected: false,
      );
      return left('Unexpected error occurred');
    }
  }

  @override
  Future<Either<String, ApiModel>> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await client.delete(
        path,
        queryParameters: queryParameters,
      );
      return handleResponseStatus(response);
    } on DioException catch (e, stackTrace) {
      await CrashlyticsCollector().logCaughtError(
        error: e,
        stackTrace: stackTrace,
        location: 'DioConsumer.delete',
        operation: 'API DELETE Request',
        contextData: {'path': path, 'query_parameters': queryParameters},
      );
      return left(handleDioError(e).toString());
    } catch (e, stackTrace) {
      await CrashlyticsCollector().logCaughtError(
        error: e,
        stackTrace: stackTrace,
        location: 'DioConsumer.delete',
        operation: 'Unexpected Error in API DELETE',
        contextData: {'path': path, 'query_parameters': queryParameters},
        isExpected: false,
      );
      return left('Unexpected error occurred');
    }
  }

  @override
  Future<Either<String, ApiModel>> auth(
    String path, {
    Map<String, dynamic>? body,
    bool formDataIsEnabled = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await client.post(
        path,
        queryParameters: queryParameters,
        data: formDataIsEnabled ? FormData.fromMap(body!) : body,
        options: Options(extra: {'requiresToken': false}),
      );
      if (response.statusCode == StatusCode.ok || response.statusCode == 201) {
        return right(
          ApiModel(
            response: handleResponseAsJson(response),
            statusCode: response.statusCode!,
          ),
        );
      } else {
        return left(handleError(response));
      }
    } on DioException catch (e, stackTrace) {
      await CrashlyticsCollector().logCaughtError(
        error: e,
        stackTrace: stackTrace,
        location: 'DioConsumer.auth',
        operation: 'Authentication Request',
        contextData: {
          'path': path,
          'form_data_enabled': formDataIsEnabled,
          'query_parameters': queryParameters,
        },
      );
      return left(handleDioError(e).toString());
    } catch (e, stackTrace) {
      await CrashlyticsCollector().logCaughtError(
        error: e,
        stackTrace: stackTrace,
        location: 'DioConsumer.auth',
        operation: 'Unexpected Error in Authentication',
        contextData: {'path': path, 'form_data_enabled': formDataIsEnabled},
        isExpected: false,
      );
      return left('Unexpected error occurred');
    }
  }

  // ---------------------------------------------------------------------------
  // Response helpers
  // ---------------------------------------------------------------------------

  @override
  Map<String, dynamic> handleResponseAsJson(Response response) {
    if (response.data == null || response.data.toString().trim().isEmpty) {
      return {};
    }
    return jsonDecode(response.data.toString()) as Map<String, dynamic>;
  }

  @override
  Either<String, ApiModel> handleResponseStatus(Response response) {
    final status = response.statusCode ?? 0;

    if (status == StatusCode.timeOut1 ||
        status == StatusCode.timeOut2 ||
        status == StatusCode.timeOut3) {
      return left('Time Out');
    }

    if (status == StatusCode.badRequest ||
        status == StatusCode.unauthorized ||
        status == StatusCode.forbidden ||
        status == StatusCode.notFound) {
      return left(handleError(response));
    }

    return right(
      ApiModel(response: handleResponseAsJson(response), statusCode: status),
    );
  }

  @override
  Exception handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return FetchDataException();

      case DioExceptionType.cancel:
        return FetchDataException();

      case DioExceptionType.badCertificate:
      case DioExceptionType.connectionError:
        return NoInternetConnectionException();

      case DioExceptionType.unknown:
        if (error.error is SocketException) {
          return NoInternetConnectionException();
        }
        return FetchDataException(error.message);

      case DioExceptionType.badResponse:
        final code = error.response?.statusCode ?? 0;
        switch (code) {
          case StatusCode.badRequest:
            return BadRequestException();
          case StatusCode.unauthorized:
          case StatusCode.forbidden:
            return UnauthorizedException();
          case StatusCode.notFound:
            return NotFoundException();
          case StatusCode.conflict:
            return ConflictException();
          case StatusCode.internalServerError:
            return InternalServerException();
          default:
            return FetchDataException('Unexpected server error: $code');
        }
    }
  }

  String handleError(Response response) {
    final ErrorHandlerModel model;
    if (response.data is Map<String, dynamic>) {
      model = ErrorHandlerModel.fromJson(response.data as Map<String, dynamic>);
    } else {
      model = ErrorHandlerModel.fromJson(handleResponseAsJson(response));
    }
    return model.firstErrorMessage.toCamelCase;
  }

  // ---------------------------------------------------------------------------
  // Logout helper — clears token and navigates to the choose-account screen.
  // ---------------------------------------------------------------------------

  Future<void> _logOut() async {
    await sl<HandleMultiCallLocal>().clear();
    final context = MadarApp.navigatorKey.currentContext;
    if (context != null && context.mounted) {
      RouterHandler.navigate(
        context,
        AppRouterKeys.chooseAccount,
        routerType: RouterType.pushReplacementNamed,
      );
    }
  }

  // ---------------------------------------------------------------------------
  // Header sanitization helpers
  // ---------------------------------------------------------------------------

  Map<String, dynamic>? _sanitizeHeaders(Map<String, dynamic>? headers) {
    if (headers == null) return null;
    final sanitized = Map<String, dynamic>.from(headers);
    sanitized.remove('Authorization');
    sanitized.remove('Cookie');
    sanitized.remove('Set-Cookie');
    return sanitized;
  }

  Map<String, dynamic>? _sanitizeResponseHeaders(Headers? headers) {
    if (headers == null) return null;
    final map = <String, dynamic>{};
    headers.forEach((name, values) {
      map[name] = values.join(', ');
    });
    return _sanitizeHeaders(map);
  }

  // ---------------------------------------------------------------------------
  // Interceptors
  // ---------------------------------------------------------------------------

  InterceptorsWrapper _authInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        options.headers['Accept-Language'] =
            PreferenceUtils().getString(StorageKeys.lang, 'en');

        if (options.extra['requiresToken'] != false) {
          final token = await sl<HandleMultiCallLocal>().getLocalData(
            keyType: LocalEnumKey.accessToken,
          );
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
        }

        handler.next(options);
      },
      onError: (DioException e, ErrorInterceptorHandler handler) async {
        await CrashlyticsCollector().logInterceptorError(
          error: e,
          stackTrace: e.stackTrace,
          interceptorName: 'AuthInterceptor',
          url: e.requestOptions.uri.toString(),
          method: e.requestOptions.method,
          statusCode: e.response?.statusCode,
          requestInfo: {
            'headers': _sanitizeHeaders(e.requestOptions.headers),
            'query_parameters': e.requestOptions.queryParameters,
            'content_type': e.requestOptions.contentType,
          },
          responseInfo: {
            'headers': _sanitizeResponseHeaders(e.response?.headers),
            'data_type': e.response?.data?.runtimeType.toString(),
          },
        );

        // 401 — no refresh token; clear session and go to login.
        if (e.response?.statusCode == StatusCode.unauthorized) {
          await _logOut();
          return handler.reject(e);
        }

        // Network / timeout — show toast and retry up to 3 times.
        if (e.type == DioExceptionType.connectionError ||
            e.error is SocketException ||
            e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout) {
          AppToast('connection_error'.tr());

          const int maxRetries = 3;
          const Duration retryDelay = Duration(seconds: 5);

          for (int attempt = 1; attempt <= maxRetries; attempt++) {
            await Future.delayed(retryDelay);

            if (await sl<NetworkInfo>().isConnected) {
              try {
                final retryResponse = await client.fetch(e.requestOptions);
                await CrashlyticsCollector().logGeneralError(
                  error: 'Network retry successful on attempt $attempt',
                  context: 'Network Recovery',
                  additionalInfo: {
                    'retry_attempt': attempt,
                    'endpoint': e.requestOptions.path,
                    'original_error': e.type.toString(),
                  },
                  isFatal: false,
                  source: ErrorSource.network,
                );
                return handler.resolve(retryResponse);
              } catch (retryError) {
                if (attempt == maxRetries) {
                  await CrashlyticsCollector().logCaughtError(
                    error: retryError,
                    location: 'DioConsumer._authInterceptor',
                    operation: 'Network Retry Failed',
                    contextData: {
                      'max_retries_reached': true,
                      'final_attempt': attempt,
                      'endpoint': e.requestOptions.path,
                    },
                  );
                }
              }
            }

            if (attempt == maxRetries) {
              await CrashlyticsCollector().logCaughtError(
                error: 'Network retry exhausted after $maxRetries attempts',
                location: 'DioConsumer._authInterceptor',
                operation: 'Network Retry',
                contextData: {
                  'max_retries': maxRetries,
                  'endpoint': e.requestOptions.path,
                  'final_error_type': e.type.toString(),
                },
              );
              return handler.reject(e);
            }
          }
        }

        return handler.reject(e);
      },
    );
  }

  InterceptorsWrapper _connectivityInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        final results = await sl<Connectivity>().checkConnectivity();
        if (results.contains(ConnectivityResult.none)) {
          await CrashlyticsCollector().logCaughtError(
            error: 'No internet connection',
            location: 'DioConsumer._connectivityInterceptor',
            operation: 'Connectivity Check',
            contextData: {
              'endpoint': options.path,
              'method': options.method,
              'connectivity_result': results.toString(),
            },
            isExpected: true,
          );
          return handler.reject(
            DioException(
              requestOptions: options,
              type: DioExceptionType.connectionError,
              message: 'No internet connection',
            ),
          );
        }
        handler.next(options);
      },
    );
  }
}
