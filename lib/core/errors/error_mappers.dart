import 'package:dio/dio.dart';
import 'app_exception.dart';

extension DioToAppException on DioException {
  AppException toAppException() {
    // timeouts / network / cancel
    if (type == DioExceptionType.connectionTimeout ||
        type == DioExceptionType.receiveTimeout ||
        type == DioExceptionType.sendTimeout) {
      return TimeoutExceptionX('Request timed out', debugMessage: message, cause: this, stackTrace: stackTrace);
    }
    if (type == DioExceptionType.connectionError || type == DioExceptionType.unknown) {
      return NetworkException('Network error', debugMessage: message, cause: this, stackTrace: stackTrace);
    }
    if (type == DioExceptionType.cancel) {
      return CancelledException('Request cancelled', debugMessage: message, cause: this, stackTrace: stackTrace);
    }

    final code = response?.statusCode ?? -1;
    final data = response?.data;
    final serverMsg = _extractServerMessage(data);

    switch (code) {
      case 400:
        return BadRequestException(serverMsg ?? 'Bad request', debugMessage: message, cause: this, stackTrace: stackTrace);
      case 401:
        return UnauthorizedException(serverMsg ?? 'Unauthorized', debugMessage: message, cause: this, stackTrace: stackTrace);
      case 403:
        return ForbiddenException(serverMsg ?? 'Forbidden', debugMessage: message, cause: this, stackTrace: stackTrace);
      case 404:
        return NotFoundException(serverMsg ?? 'Not found', debugMessage: message, cause: this, stackTrace: stackTrace);
      case 409:
        return ConflictException(serverMsg ?? 'Conflict', debugMessage: message, cause: this, stackTrace: stackTrace);
      case 422:
        return ValidationException(serverMsg ?? 'Validation error', debugMessage: message, cause: this, stackTrace: stackTrace);
      case 429:
        return RateLimitException(serverMsg ?? 'Too many requests', debugMessage: message, cause: this, stackTrace: stackTrace);
      default:
        if (code >= 500 && code < 600) {
          return ServerException(serverMsg ?? 'Server error',
              debugMessage: 'HTTP $code ${message ?? ''}', cause: this, stackTrace: stackTrace);
        }
        return UnknownException(serverMsg ?? 'Unexpected HTTP error',
            debugMessage: 'HTTP $code ${message ?? ''}', cause: this, stackTrace: stackTrace);
    }
  }
}

// Pull "message" or first field error from {"data": {...}}
String? _extractServerMessage(dynamic data) {
  if (data is Map) {
    if (data['message'] is String && (data['message'] as String).isNotEmpty) {
      return data['message'] as String;
    }
    final d = data['data'];
    // look for first validation error like {email: ["Email not exists"]}
    if (d is Map) {
      for (final v in d.values) {
        if (v is List && v.isNotEmpty && v.first is String) return v.first as String;
        if (v is String && v.isNotEmpty) return v;
      }
    }
  }
  return null;
}
