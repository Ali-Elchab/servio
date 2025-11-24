import '/shared/services/api_service.dart';
import '/core/constants/api_endpoints.dart';
import '/core/errors/app_exception.dart';
import '../models/user.dart';

class AuthRemoteSource {
  final ApiService api;
  AuthRemoteSource(this.api);

  Future<User> login(String identifier, String password) async {
    final res = await api.post(
      ApiEndPoints.login,
      data: {'email': identifier.trim(), 'password': password},
    );
    final data = res.data;
    if (data is! Map || data['status'] != 'Success') {
      throw ServerException('Login failed', debugMessage: '$data');
    }
    return User.fromMap(data['data']);
  }

  Future<User> register(Map<String, dynamic> payload) async {
    final res = await api.post(ApiEndPoints.register, data: payload);
    final data = res.data;
    if (data is! Map || data['status'] != 'Success') {
      throw ServerException('Register failed', debugMessage: '$data');
    }
    return User.fromMap(data['data']);
  }
}
