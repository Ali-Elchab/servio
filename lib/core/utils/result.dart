import '/core/errors/app_exception.dart';

sealed class Result<T> {
  const Result();
  bool get isOk => this is Ok<T>;
  bool get isErr => this is Err<T>;

  R fold<R>(R Function(T) onOk, R Function(AppException) onErr);
  Result<R> map<R>(R Function(T) fn);
  Result<R> flatMap<R>(Result<R> Function(T) fn);
}

final class Ok<T> extends Result<T> {
  final T value;
  const Ok(this.value);

  @override
  R fold<R>(R Function(T) onOk, R Function(AppException) onErr) => onOk(value);

  @override
  Result<R> map<R>(R Function(T) fn) => Ok(fn(value));

  @override
  Result<R> flatMap<R>(Result<R> Function(T) fn) => fn(value);
}

final class Err<T> extends Result<T> {
  final AppException error;
  const Err(this.error);

  @override
  R fold<R>(R Function(T) onOk, R Function(AppException) onErr) => onErr(error);

  @override
  Result<R> map<R>(R Function(T) fn) => Err<R>(error);

  @override
  Result<R> flatMap<R>(Result<R> Function(T) fn) => Err<R>(error);
}
