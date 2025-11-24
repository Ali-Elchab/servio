import 'app_exception.dart';

String userMessage(AppException e) {
  return switch (e) {
    UnauthorizedException _ => 'errors.errUnauthorized',
    NetworkException _ => 'errors.errNetwork',
    TimeoutExceptionX _ => 'errors.errTimeout',
    ServerException _ => 'errors.errServer',
    DbException _ => 'errors.errDb',
    _ => e.message,
  };
}
