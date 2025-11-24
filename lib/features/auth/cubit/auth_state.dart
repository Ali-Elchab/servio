part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

final class AuthChecking extends AuthState {
  const AuthChecking();
}

final class Authenticated extends AuthState {
  final User user;
  final Role? role;
  const Authenticated(this.user, {this.role});
  @override
  List<Object?> get props => [user, role];
}

final class Unauthenticated extends AuthState {
  final AppException? lastError;
  const Unauthenticated({this.lastError});
  @override
  List<Object?> get props => [lastError];
}

final class AuthFailure extends AuthState {
  final AppException? error;
  const AuthFailure(this.error);
  @override
  List<Object?> get props => [error];
}

final class AuthGuest extends AuthState {
  const AuthGuest();
}
