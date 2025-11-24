import 'dart:developer';
import '/shared/services/connectivity_service.dart';
import '/core/errors/error_mappers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '/core/constants/app_constants.dart';
import '/shared/services/cache_manager.dart';

class ApiService {
  final Dio dio;
  final CacheManager _cache;
  final ConnectivityService _net;
  Future<void> Function()? _onUnauthorized;
  bool _handlingUnauthorized = false;

  ApiService(this._cache, this._net)
      : dio = Dio(
          BaseOptions(
            baseUrl: '${AppConstants.baseUrl}/',
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
            sendTimeout: const Duration(seconds: 30),
            contentType: 'application/json',
            headers: {'Accept': 'application/json', 'X-Api-Key': AppConstants.xApiKey},
          ),
        ) {
    dio.interceptors.add(_ConnectivityGuard(_net));

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = _cache.token;
          if (_needsApiKey(options.path)) {
            options.headers['X-Api-Key'] = AppConstants.xApiKey; // or from secure storage/env
          }
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (error, handler) async {
          final status = error.response?.statusCode;
          if (status == 401) {
            await _handleUnauthorized();
          }
          handler.next(error);
        },
      ),
    );

    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    }
  }

  void setUnauthorizedHandler(Future<void> Function()? handler) => _onUnauthorized = handler;

  Future<Response> get(String url, {Map<String, dynamic>? query, Map<String, dynamic>? headers}) async {
    try {
      return await dio.get(
        url,
        queryParameters: query,
        options: Options(headers: headers),
      );
    } on DioException catch (e) {
      _logError('GET', url, e);
      throw e.toAppException();
    }
  }

  Future<Response> post(String url,
      {required Map<String, dynamic> data, Map<String, dynamic>? query, Map<String, dynamic>? headers}) async {
    try {
      return await dio.post(
        url,
        data: data,
        queryParameters: query,
        options: Options(headers: headers),
      );
    } on DioException catch (e) {
      _logError('POST', url, e);
      throw e.toAppException();
    }
  }

  Future<Response> postFormData(String url,
      {required FormData data, Map<String, dynamic>? query, Map<String, dynamic>? headers}) async {
    try {
      return await dio.post(
        url,
        data: data,
        queryParameters: query,
        options: Options(headers: {...?headers, 'Content-Type': 'multipart/form-data'}),
      );
    } on DioException catch (e) {
      _logError('POST_FORM', url, e);
      throw e.toAppException();
    }
  }

  Future<void> download(
    String url,
    String savePath, {
    Map<String, dynamic>? query,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    try {
      await dio.download(url, savePath, queryParameters: query, onReceiveProgress: onReceiveProgress, cancelToken: cancelToken);
    } on DioException catch (e) {
      _logError('DOWNLOAD', url, e);
      throw e.toAppException();
    }
  }

  void _logError(String method, String url, DioException e) {
    final status = e.response?.statusCode;
    log("❌ [$method] $url → $status ${e.message}");
    if (kDebugMode && e.response?.data != null) {
      log('↪ body: ${e.response?.data}');
    }
  }

  bool _needsApiKey(String path) {
    // tweak as needed (e.g., only for /v1/* or exclude /auth/*)
    return true;
  }

  Future<void> _handleUnauthorized() async {
    final handler = _onUnauthorized;
    if (handler == null || _handlingUnauthorized) return;
    _handlingUnauthorized = true;
    try {
      await handler();
    } catch (e, st) {
      log('Unauthorized handler failed', error: e, stackTrace: st);
    } finally {
      _handlingUnauthorized = false;
    }
  }
}

class _ConnectivityGuard extends Interceptor {
  final ConnectivityService _net;
  _ConnectivityGuard(this._net);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final connected = await _net.isConnected;
    if (!connected) {
      handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.unknown,
          error: const OfflineException('No internet connection'),
        ),
      );
      return;
    }
    handler.next(options);
  }
}

class OfflineException implements Exception {
  final String message;
  const OfflineException(this.message);
  @override
  String toString() => message;
}
