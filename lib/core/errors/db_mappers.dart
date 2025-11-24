import '/core/errors/app_exception.dart';

AppException dbToApp(Exception e, StackTrace st) {
  return DbException('Database error', debugMessage: e.toString(), cause: e, stackTrace: st);
}
