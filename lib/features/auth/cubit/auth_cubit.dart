import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invygo/core/config/dev_reset.dart';
import '/shared/models/role.dart';
import '/features/auth/data/models/user.dart';
import '/features/auth/data/repositories/auth_repository.dart';
import '/shared/services/api_service.dart';

import '/core/errors/app_exception.dart';
import '/shared/services/cache_manager.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._repo, this._cache, this._api) : super(const AuthInitial()) {
    _api.setUnauthorizedHandler(logout);
    _bootstrap();
  }

  final AuthRepository _repo;
  final CacheManager _cache;
  final ApiService _api;

  StreamSubscription<User?>? _sub;

  Future<void> _bootstrap() async {
    // devResetAll();
    // _cache.clearAll();

    if (!_cache.hasToken) {
      emit(const Unauthenticated());
      return;
    }

    emit(const AuthChecking());

    // One-shot bootstrap
    final user = await _repo.loadCachedUser();
    if (user == null) {
      emit(const Unauthenticated());
      return;
    }
    emit(Authenticated(user, role: _cache.cachedRole));

    // OPTIONAL (if you implemented watchCachedUser):
    // _sub = _repo.watchCachedUser().listen((u) {
    //   if (u == null) {
    //     emit(const Unauthenticated());
    //   } else {
    //     emit(Authenticated(u, role: _cache.cachedRole));
    //   }
    // });
  }

  Future<AppException?> login(String identifier, String password) async {
    emit(const AuthChecking());
    final res = await _repo.login(identifier, password);
    return res.fold(
      (user) {
        emit(Authenticated(user, role: _cache.cachedRole));
        return null;
      },
      (e) {
        emit(AuthFailure(e));
        return e;
      },
    );
  }

  Future<AppException?> register({
    required String phone,
    required String password,
    required String name,
    required String email,
  }) async {
    emit(const AuthChecking());
    final res = await _repo.register({'phone': phone, 'password': password, 'name': name, 'email': email});
    return res.fold(
      (user) {
        emit(Authenticated(user, role: _cache.cachedRole));
        return null;
      },
      (e) {
        emit(Unauthenticated(lastError: e));
        return e;
      },
    );
  }

  Future<void> logout() async {
    await _repo.logout();
    emit(const Unauthenticated());
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }

  void enterGuest() => emit(const AuthGuest());
}
