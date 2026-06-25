/// Parses Node.js / Express error response bodies.
///
/// Handles the common shapes emitted by Express and express-validator:
///   { "message": "..." }
///   { "error": "..." }
///   { "errors": [{ "msg": "..." }, ...] }           ← express-validator array
///   { "errors": { "field": "...", ... } }            ← object / map shape
class ErrorHandlerModel {
  final String? message;
  final String? error;
  final dynamic errors;

  const ErrorHandlerModel({this.message, this.error, this.errors});

  factory ErrorHandlerModel.fromJson(Map<String, dynamic> json) {
    return ErrorHandlerModel(
      message: json['message'] as String?,
      error: json['error'] as String?,
      errors: json['errors'],
    );
  }

  /// Returns the first meaningful error string from the response.
  String get firstErrorMessage {
    // 1. Top-level "message" field
    if (message != null && message!.trim().isNotEmpty) return message!.trim();

    // 2. Top-level "error" field
    if (error != null && error!.trim().isNotEmpty) return error!.trim();

    // 3. express-validator: errors is a List
    if (errors is List && (errors as List).isNotEmpty) {
      for (final item in errors as List) {
        if (item is Map<String, dynamic>) {
          final msg =
              item['msg'] as String? ??
              item['message'] as String? ??
              item['error'] as String?;
          if (msg != null && msg.trim().isNotEmpty) return msg.trim();
        } else if (item is String && item.trim().isNotEmpty) {
          return item.trim();
        }
      }
    }

    // 4. errors is a Map (field-keyed errors)
    if (errors is Map<String, dynamic>) {
      for (final value in (errors as Map<String, dynamic>).values) {
        if (value is String && value.trim().isNotEmpty) return value.trim();
        if (value is List && (value).isNotEmpty) {
          final first = value.first;
          if (first is String && first.trim().isNotEmpty) return first.trim();
        }
      }
    }

    return 'An unexpected error occurred';
  }
}
