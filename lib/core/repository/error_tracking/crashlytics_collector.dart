import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../firebase_options.dart';
import '../../utils/functions/service_locator.dart';
import '../../utils/functions/translation.dart';
 
 
class CrashlyticsCollector {
  static final CrashlyticsCollector _instance =
      CrashlyticsCollector._internal();
  factory CrashlyticsCollector() => _instance;
  CrashlyticsCollector._internal();

  Map<String, dynamic>? _deviceInfoCache;
  DateTime? _lastCacheUpdate;
  static const Duration _cacheValidDuration = Duration(hours: 1);

  final Map<String, DateTime> _lastErrorTime = {};
  static const Duration _rateLimitDuration = Duration(minutes: 1);
  static const int _maxBodyLength = 8192;
  static const int _maxUrlLength = 2048;

  bool _isGlobalErrorHandlerSetup = false;
  final Set<String> _loggedErrorHashes = {};
  Timer? _errorCleanupTimer;
  bool _isLogging = false;

  void setup() {

    _setupFlutterErrorHandling();
    _setupPlatformErrorHandling();
    _setupErrorWidgetHandling();
    _setupErrorCleanup();
  }

  Future<void> setupGlobalErrorTracking({
    required Widget Function() appBuilder,
    bool trackHandledErrors = true,
    bool trackAsyncErrors = true,
  }) async {
    _isGlobalErrorHandlerSetup = true;

   await runZonedGuarded<Future<void>>(
      () async {
          WidgetsFlutterBinding.ensureInitialized();
      await intiService();
  await initLocalization();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);


        setup();
        runApp(appBuilder());
      },
      (error, stack) {
        logGeneralError(
          error: error,
          stackTrace: stack,
          context: 'Global Zone Error',
          isFatal: true,
        );
      },
      zoneSpecification: ZoneSpecification(
        handleUncaughtError: (self, parent, zone, error, stackTrace) {
          logGeneralError(
            error: error,
            stackTrace: stackTrace,
            context: 'Uncaught Zone Error',
            isFatal: true,
          );
          parent.handleUncaughtError(zone, error, stackTrace);
        },
      ),
    );
  }

  void _setupFlutterErrorHandling() {
    FlutterError.onError = (details) async {
      await _setCrashlyticsCustomKeys();
      await _logFlutterError(details);
      await FirebaseCrashlytics.instance.recordFlutterError(details);
    };
  }

  void _setupPlatformErrorHandling() {
    PlatformDispatcher.instance.onError = (error, stack) {
      _setCrashlyticsCustomKeys().then((_) async {
        await _logPlatformError(error, stack);
        await FirebaseCrashlytics.instance.recordError(
          error,
          stack,
          fatal: true,
        );
      });
      return true;
    };
  }

  void _setupErrorWidgetHandling() {
    ErrorWidget.builder = (details) {
      logGeneralError(
        error: details.exception,
        stackTrace: details.stack,
        context: 'Error Widget',
        isFatal: true,
      );
      return ErrorWidget(details.exception);
    };
  }

  void _setupErrorCleanup() {
    _errorCleanupTimer = Timer.periodic(const Duration(hours: 1), (timer) {
      _cleanupErrorCache();
    });
  }

  void dispose() {
    _errorCleanupTimer?.cancel();
    _errorCleanupTimer = null;
    _loggedErrorHashes.clear();
    _lastErrorTime.clear();
  }

  bool get isGlobalErrorHandlerSetup => _isGlobalErrorHandlerSetup;

  void _cleanupErrorCache() {
    if (_loggedErrorHashes.length > 10000) {
      final toRemove = _loggedErrorHashes.length - 5000;
      final list = _loggedErrorHashes.toList();
      for (int i = 0; i < toRemove; i++) {
        _loggedErrorHashes.remove(list[i]);
      }
    }

    final cutoffTime = DateTime.now().subtract(const Duration(hours: 2));
    _lastErrorTime.removeWhere((key, value) => value.isBefore(cutoffTime));
  }

  Future<void> _setCrashlyticsCustomKeys() async {
    try {
      await _setBasicKeys();
      await _setCachedDeviceInfo();
    } catch (_) {}
  }

  Future<void> _setBasicKeys() async {
    final now = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    await FirebaseCrashlytics.instance.setCustomKey('error_time', now);
  }

  Future<void> _setCachedDeviceInfo() async {
    if (_deviceInfoCache != null &&
        _lastCacheUpdate != null &&
        DateTime.now().difference(_lastCacheUpdate!) < _cacheValidDuration) {
      await _setDeviceInfoFromCache();
      return;
    }

    await _refreshDeviceInfoCache();
    await _setDeviceInfoFromCache();
  }

  Future<void> _refreshDeviceInfoCache() async {
    _deviceInfoCache = {};

    try {
      final info = await PackageInfo.fromPlatform();
      _deviceInfoCache!.addAll({
        'app_name': info.appName,
        'package_name': info.packageName,
        'version': info.version,
        'build_number': info.buildNumber,
      });
    } catch (_) {}

    try {
      final deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        _deviceInfoCache!.addAll({
          'device_model': androidInfo.model,
          'device_brand': androidInfo.brand,
          'android_version': androidInfo.version.release,
          'android_sdk': androidInfo.version.sdkInt.toString(),
          'manufacturer': androidInfo.manufacturer,
          'device': androidInfo.device,
          'hardware': androidInfo.hardware,
        });
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        _deviceInfoCache!.addAll({
          'device_model': iosInfo.utsname.machine,
          'ios_version': iosInfo.systemVersion,
          'device_name': iosInfo.name,
          'system_name': iosInfo.systemName,
          'model': iosInfo.model,
          'identifier_for_vendor': iosInfo.identifierForVendor,
        });
      }
    } catch (_) {}

    _lastCacheUpdate = DateTime.now();
  }

  Future<void> _setDeviceInfoFromCache() async {
    if (_deviceInfoCache == null) return;

    for (final entry in _deviceInfoCache!.entries) {
      try {
        await FirebaseCrashlytics.instance.setCustomKey(entry.key, entry.value);
      } catch (_) {}
    }
  }

  Future<void> logGeneralError({
    required dynamic error,
    StackTrace? stackTrace,
    String? context,
    Map<String, dynamic>? additionalInfo,
    bool isFatal = false,
    ErrorSource source = ErrorSource.userCode,
  }) async {
    if (_isLogging) return;
    _isLogging = true;

    try {
      final errorHash = _generateErrorHash(error, stackTrace, context);

      if (_loggedErrorHashes.contains(errorHash)) {
        return;
      }
      _loggedErrorHashes.add(errorHash);

      await _setCrashlyticsCustomKeys();
      await _setGeneralErrorContext(
        error,
        stackTrace,
        context,
        additionalInfo,
        source,
      );

      await FirebaseCrashlytics.instance.recordError(
        error,
        stackTrace,
        reason: context ?? '${source.displayName} Error',
        fatal: isFatal,
      );
    } catch (_) {
    } finally {
      _isLogging = false;
    }
  }

  Future<void> logCaughtError({
    required dynamic error,
    StackTrace? stackTrace,
    required String location,
    String? operation,
    Map<String, dynamic>? contextData,
    bool isExpected = false,
  }) async {
    await logGeneralError(
      error: error,
      stackTrace: stackTrace,
      context: 'Caught in $location${operation != null ? ' ($operation)' : ''}',
      additionalInfo: {
        'location': location,
        'operation': operation,
        'is_expected': isExpected,
        ...?contextData,
      },
      isFatal: false,
      source: ErrorSource.caughtError,
    );
  }

  Future<void> logInterceptorError({
    required dynamic error,
    StackTrace? stackTrace,
    required String interceptorName,
    String? url,
    String? method,
    int? statusCode,
    Map<String, dynamic>? requestInfo,
    Map<String, dynamic>? responseInfo,
  }) async {
    await logGeneralError(
      error: error,
      stackTrace: stackTrace,
      context: 'Interceptor Error: $interceptorName',
      additionalInfo: {
        'interceptor_name': interceptorName,
        'url': url,
        'method': method,
        'status_code': statusCode,
        'request_info': requestInfo,
        'response_info': responseInfo,
      },
      isFatal: false,
      source: ErrorSource.interceptor,
    );
  }

  Future<void> logBusinessLogicError({
    required String errorMessage,
    required String feature,
    String? userAction,
    String? expectedBehavior,
    Map<String, dynamic>? userContext,
    StackTrace? stackTrace,
  }) async {
    await logGeneralError(
      error: errorMessage,
      stackTrace: stackTrace,
      context: 'Business Logic Error in $feature',
      additionalInfo: {
        'feature': feature,
        'user_action': userAction,
        'expected_behavior': expectedBehavior,
        'user_context': userContext,
      },
      isFatal: false,
      source: ErrorSource.businessLogic,
    );
  }

  Future<void> _logFlutterError(FlutterErrorDetails details) async {
    await _setGeneralErrorContext(
      details.exception,
      details.stack,
      'Flutter Framework Error',
      {
        'library': details.library,
        'informationCollector': details.informationCollector?.toString(),
        'silent': details.silent,
      },
      ErrorSource.flutterFramework,
    );
  }

  Future<void> _logPlatformError(Object error, StackTrace stack) async {
    await _setGeneralErrorContext(
      error,
      stack,
      'Platform Error',
      {},
      ErrorSource.platform,
    );
  }

  Future<void> _setGeneralErrorContext(
    dynamic error,
    StackTrace? stackTrace,
    String? context,
    Map<String, dynamic>? additionalInfo,
    ErrorSource source,
  ) async {
    final futures = <Future>[];

    futures.add(
      FirebaseCrashlytics.instance.setCustomKey('error_source', source.name),
    );
    futures.add(
      FirebaseCrashlytics.instance.setCustomKey(
        'error_context',
        context ?? 'Unknown',
      ),
    );

    if (stackTrace != null) {
      final stackString = stackTrace.toString();
      futures.add(
        FirebaseCrashlytics.instance.setCustomKey(
          'stack_preview',
          _truncateString(stackString, 2000),
        ),
      );

      final methodNames = _extractMethodNames(stackString);
      if (methodNames.isNotEmpty) {
        futures.add(
          FirebaseCrashlytics.instance.setCustomKey(
            'error_methods',
            methodNames.join(' -> '),
          ),
        );
      }
    }

    if (additionalInfo != null && additionalInfo.isNotEmpty) {
      for (final entry in additionalInfo.entries) {
        if (entry.value != null) {
          futures.add(
            FirebaseCrashlytics.instance.setCustomKey(
              'info_${entry.key}',
              _truncateString(entry.value.toString(), 1000),
            ),
          );
        }
      }
    }

    try {
      await Future.wait(futures);
    } catch (_) {}
  }

  String _generateErrorHash(
    dynamic error,
    StackTrace? stackTrace,
    String? context,
  ) {
    final errorType = error.runtimeType.toString();
    final errorMsg = error.toString();
    final stackKey =
        stackTrace
            ?.toString()
            .split('\n')
            .take(3)
            .join()
            .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '') ??
        '';
    final contextKey = context ?? '';

    return '${errorType}_${errorMsg.hashCode}_${stackKey.hashCode}_${contextKey.hashCode}';
  }

  List<String> _extractMethodNames(String stackTrace) {
    final methodNames = <String>[];
    final lines = stackTrace.split('\n');

    for (final line in lines.take(5)) {
      final match = RegExp(r'#\d+\s+(.+?)\s+\(').firstMatch(line);
      if (match != null) {
        final method = match.group(1)?.split('.').last ?? '';
        if (method.isNotEmpty && !methodNames.contains(method)) {
          methodNames.add(method);
        }
      }
    }

    return methodNames;
  }

  Future<void> logApiError({
    required String url,
    String? method,
    int? statusCode,
    String? requestBody,
    String? responseBody,
    Map<String, dynamic>? requestHeaders,
    Map<String, dynamic>? responseHeaders,
    Duration? requestDuration,
    dynamic error,
    StackTrace? stackTrace,
    String? userAgent,
    String? networkType,
    ApiErrorSeverity severity = ApiErrorSeverity.medium,
    Map<String, dynamic>? additionalContext,
  }) async {
    try {
      final errorKey = _generateErrorKey(url, method, statusCode);

      if (_isRateLimited(errorKey)) {
        return;
      }

      final errorCategory = _categorizeError(statusCode, error);
      final truncatedUrl = _truncateString(url, _maxUrlLength);

      await _setCrashlyticsCustomKeys();
      await _setApiErrorContext(
        url: truncatedUrl,
        method: method,
        statusCode: statusCode,
        requestBody: requestBody,
        responseBody: responseBody,
        requestHeaders: requestHeaders,
        responseHeaders: responseHeaders,
        requestDuration: requestDuration,
        userAgent: userAgent,
        networkType: networkType,
        errorCategory: errorCategory,
        severity: severity,
        additionalContext: additionalContext,
      );

      await _recordApiError(
        error: error,
        stackTrace: stackTrace,
        method: method,
        url: truncatedUrl,
        severity: severity,
        errorCategory: errorCategory,
      );

      _updateRateLimit(errorKey);
    } catch (_, _) {}
  }

  Future<void> logApiErrorWithSeverity({
    required String url,
    required ApiErrorSeverity severity,
    String? method,
    int? statusCode,
    dynamic error,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) async {
    await logApiError(
      url: url,
      method: method,
      statusCode: statusCode,
      error: error,
      stackTrace: stackTrace,
      severity: severity,
      additionalContext: context,
    );
  }

  String _generateErrorKey(String url, String? method, int? statusCode) {
    final uri = Uri.tryParse(url);
    final path = uri?.path ?? url;
    return '${method ?? 'UNKNOWN'}_${path}_$statusCode';
  }

  bool _isRateLimited(String errorKey) {
    final lastTime = _lastErrorTime[errorKey];
    if (lastTime == null) return false;
    return DateTime.now().difference(lastTime) < _rateLimitDuration;
  }

  void _updateRateLimit(String errorKey) {
    _lastErrorTime[errorKey] = DateTime.now();

    if (_lastErrorTime.length > 1000) {
      final cutoffTime = DateTime.now().subtract(const Duration(hours: 1));
      _lastErrorTime.removeWhere((key, value) => value.isBefore(cutoffTime));
    }
  }

  ApiErrorCategory _categorizeError(int? statusCode, dynamic error) {
    if (statusCode == null) {
      if (error.toString().toLowerCase().contains('timeout')) {
        return ApiErrorCategory.timeout;
      } else if (error.toString().toLowerCase().contains('connection')) {
        return ApiErrorCategory.network;
      }
      return ApiErrorCategory.unknown;
    }

    if (statusCode >= 500) return ApiErrorCategory.serverError;
    if (statusCode >= 400 && statusCode < 500) {
      return ApiErrorCategory.clientError;
    }
    if (statusCode >= 300) return ApiErrorCategory.redirection;
    return ApiErrorCategory.unknown;
  }

  Future<void> _setApiErrorContext({
    required String url,
    String? method,
    int? statusCode,
    String? requestBody,
    String? responseBody,
    Map<String, dynamic>? requestHeaders,
    Map<String, dynamic>? responseHeaders,
    Duration? requestDuration,
    String? userAgent,
    String? networkType,
    required ApiErrorCategory errorCategory,
    required ApiErrorSeverity severity,
    Map<String, dynamic>? additionalContext,
  }) async {
    final futures = <Future>[];

    futures.add(FirebaseCrashlytics.instance.setCustomKey('api_url', url));
    futures.add(
      FirebaseCrashlytics.instance.setCustomKey(
        'error_category',
        errorCategory.name,
      ),
    );
    futures.add(
      FirebaseCrashlytics.instance.setCustomKey(
        'error_severity',
        severity.name,
      ),
    );

    if (method != null) {
      futures.add(
        FirebaseCrashlytics.instance.setCustomKey('api_method', method),
      );
    }

    if (statusCode != null) {
      futures.add(
        FirebaseCrashlytics.instance.setCustomKey('status_code', statusCode),
      );
      futures.add(
        FirebaseCrashlytics.instance.setCustomKey(
          'status_class',
          '${statusCode ~/ 100}xx',
        ),
      );
    }

    if (requestDuration != null) {
      futures.add(
        FirebaseCrashlytics.instance.setCustomKey(
          'request_duration_ms',
          requestDuration.inMilliseconds,
        ),
      );
      futures.add(
        FirebaseCrashlytics.instance.setCustomKey(
          'is_slow_request',
          requestDuration.inSeconds > 10,
        ),
      );
    }

    if (userAgent != null) {
      futures.add(
        FirebaseCrashlytics.instance.setCustomKey(
          'user_agent',
          _truncateString(userAgent, 500),
        ),
      );
    }

    if (networkType != null) {
      futures.add(
        FirebaseCrashlytics.instance.setCustomKey('network_type', networkType),
      );
    }

    if (requestBody != null) {
      final truncated = _smartTruncateBody(requestBody, 'request');
      futures.add(
        FirebaseCrashlytics.instance.setCustomKey('request_body', truncated),
      );
    }

    if (responseBody != null) {
      final truncated = _smartTruncateBody(responseBody, 'response');
      futures.add(
        FirebaseCrashlytics.instance.setCustomKey('response_body', truncated),
      );
    }

    if (requestHeaders != null && requestHeaders.isNotEmpty) {
      final headersJson = _truncateString(
        jsonEncode(_sanitizeHeaders(requestHeaders)),
        _maxBodyLength ~/ 4,
      );
      futures.add(
        FirebaseCrashlytics.instance.setCustomKey(
          'request_headers',
          headersJson,
        ),
      );
    }

    if (responseHeaders != null && responseHeaders.isNotEmpty) {
      final headersJson = _truncateString(
        jsonEncode(_sanitizeHeaders(responseHeaders)),
        _maxBodyLength ~/ 4,
      );
      futures.add(
        FirebaseCrashlytics.instance.setCustomKey(
          'response_headers',
          headersJson,
        ),
      );
    }

    if (additionalContext != null && additionalContext.isNotEmpty) {
      for (final entry in additionalContext.entries) {
        futures.add(
          FirebaseCrashlytics.instance.setCustomKey(
            'ctx_${entry.key}',
            _truncateString(entry.value.toString(), 1000),
          ),
        );
      }
    }

    try {
      await Future.wait(futures);
    } catch (_) {}
  }

  Future<void> _recordApiError({
    required dynamic error,
    StackTrace? stackTrace,
    String? method,
    required String url,
    required ApiErrorSeverity severity,
    required ApiErrorCategory errorCategory,
  }) async {
    final errorMessage = error?.toString() ?? 'Unknown API error';
    final reason = 'API ${errorCategory.name} [${severity.name}]: $method $url';

    await FirebaseCrashlytics.instance.recordError(
      errorMessage,
      stackTrace,
      reason: reason,
      fatal: severity == ApiErrorSeverity.critical,
    );
  }

  String _truncateString(String input, int maxLength) {
    if (input.length <= maxLength) return input;

    const suffix = '... [TRUNCATED]';
    final availableLength = maxLength - suffix.length;

    if (availableLength <= 0) return suffix;

    return input.substring(0, availableLength) + suffix;
  }

  String _smartTruncateBody(String body, String type) {
    if (body.length <= _maxBodyLength) return body;

    try {
      final jsonData = jsonDecode(body);
      if (jsonData is Map) {
        final important = <String, dynamic>{};
        var charCount = 0;

        const importantKeys = [
          'error',
          'message',
          'code',
          'status',
          'id',
          'userId',
        ];
        for (final key in importantKeys) {
          if (jsonData.containsKey(key)) {
            final value = jsonData[key].toString();
            if (charCount + value.length < _maxBodyLength ~/ 2) {
              important[key] = jsonData[key];
              charCount += value.length;
            }
          }
        }

        important['_truncation_info'] = {
          'original_length': body.length,
          'truncated_at': DateTime.now().toIso8601String(),
          'type': type,
        };

        return jsonEncode(important);
      }
    } catch (_) {}

    return _truncateString(body, _maxBodyLength);
  }

  Map<String, dynamic> _sanitizeHeaders(Map<String, dynamic> headers) {
    const sensitiveKeys = [
      'authorization',
      'cookie',
      'set-cookie',
      'x-api-key',
      'x-auth-token',
      'bearer',
      'password',
      'secret',
    ];

    final sanitized = <String, dynamic>{};

    for (final entry in headers.entries) {
      final key = entry.key.toLowerCase();
      if (sensitiveKeys.any((sensitive) => key.contains(sensitive))) {
        sanitized[entry.key] = '[REDACTED]';
      } else {
        sanitized[entry.key] = entry.value;
      }
    }

    return sanitized;
  }
}

enum ErrorSource {
  userCode('User Code'),
  caughtError('Caught Error'),
  interceptor('Interceptor'),
  businessLogic('Business Logic'),
  flutterFramework('Flutter Framework'),
  platform('Platform'),
  network('Network'),
  database('Database'),
  fileSystem('File System'),
  unknown('Unknown');

  const ErrorSource(this.displayName);
  final String displayName;
}

enum ApiErrorCategory {
  network('Network'),
  timeout('Timeout'),
  serverError('Server Error'),
  clientError('Client Error'),
  redirection('Redirection'),
  authentication('Authentication'),
  authorization('Authorization'),
  rateLimit('Rate Limit'),
  unknown('Unknown');

  const ApiErrorCategory(this.displayName);
  final String displayName;
}

enum ApiErrorSeverity {
  low('Low'),
  medium('Medium'),
  high('High'),
  critical('Critical');

  const ApiErrorSeverity(this.displayName);
  final String displayName;
}
 