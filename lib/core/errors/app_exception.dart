sealed class AppException implements Exception {
  final String message;
  final String? debugMessage;
  final Object? cause;
  final StackTrace? stackTrace;

  const AppException(this.message, {this.debugMessage, this.cause, this.stackTrace});

  @override
  String toString() => '$runtimeType: $message'
      '${debugMessage != null ? ' ($debugMessage)' : ''}';
}

// ---- Network / HTTP ----
final class NetworkException extends AppException {
  const NetworkException(super.msg, {super.debugMessage, super.cause, super.stackTrace});
}

final class TimeoutExceptionX extends AppException {
  const TimeoutExceptionX(super.msg, {super.debugMessage, super.cause, super.stackTrace});
}

final class BadRequestException extends AppException {
  const BadRequestException(super.msg, {super.debugMessage, super.cause, super.stackTrace});
}

final class UnauthorizedException extends AppException {
  const UnauthorizedException(super.msg, {super.debugMessage, super.cause, super.stackTrace});
}

final class ForbiddenException extends AppException {
  const ForbiddenException(super.msg, {super.debugMessage, super.cause, super.stackTrace});
}

final class NotFoundException extends AppException {
  const NotFoundException(super.msg, {super.debugMessage, super.cause, super.stackTrace});
}

final class ConflictException extends AppException {
  const ConflictException(super.msg, {super.debugMessage, super.cause, super.stackTrace});
}

final class ServerException extends AppException {
  const ServerException(super.msg, {super.debugMessage, super.cause, super.stackTrace});
}

final class RateLimitException extends AppException {
  const RateLimitException(super.msg, {super.debugMessage, super.cause, super.stackTrace});
}

// ---- Data & Device ----
final class ParseException extends AppException {
  const ParseException(super.msg, {super.debugMessage, super.cause, super.stackTrace});
}

final class DbException extends AppException {
  const DbException(super.msg, {super.debugMessage, super.cause, super.stackTrace});
}

final class CacheException extends AppException {
  const CacheException(super.msg, {super.debugMessage, super.cause, super.stackTrace});
}

final class ValidationException extends AppException {
  const ValidationException(super.msg, {super.debugMessage, super.cause, super.stackTrace});
}

// ---- Generic ----
final class CancelledException extends AppException {
  const CancelledException(super.msg, {super.debugMessage, super.cause, super.stackTrace});
}

final class UnknownException extends AppException {
  const UnknownException(super.msg, {super.debugMessage, super.cause, super.stackTrace});
}
