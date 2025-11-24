import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class ConnectivityService {
  Stream<bool> get connectionStatusStream;
  Future<bool> get isConnected;
}

class ConnectivityServiceImpl implements ConnectivityService {
  final Connectivity _connectivity;
  final InternetConnectionChecker _checker;

  ConnectivityServiceImpl({
    Connectivity? connectivity,
    InternetConnectionChecker? checker,
  })  : _connectivity = connectivity ?? Connectivity(),
        _checker = checker ??
            InternetConnectionChecker.createInstance(
              checkTimeout: const Duration(milliseconds: 800),
              checkInterval: const Duration(seconds: 2),
              addresses: [
                // Use fast 204 endpoints on HTTPS
                AddressCheckOption(uri: Uri.parse('https://www.google.com/generate_204')),
                AddressCheckOption(uri: Uri.parse('https://www.gstatic.com/generate_204')),
                AddressCheckOption(uri: Uri.parse('https://www.cloudflare.com/cdn-cgi/trace')),
                AddressCheckOption(uri: Uri.parse('https://httpstat.us/204')),
              ],
            );

  @override
  Future<bool> get isConnected async {
    final res = await _connectivity.checkConnectivity();
    final hasTransport = res.any((r) => r != ConnectivityResult.none);
    if (!hasTransport) return false;
    return _checker.hasConnection;
  }

  @override
  Stream<bool> get connectionStatusStream {
    return _connectivity.onConnectivityChanged.asyncMap((dynamic res) async {
      final hasTransport =
          res is List<ConnectivityResult> ? res.any((r) => r != ConnectivityResult.none) : (res != ConnectivityResult.none);
      if (!hasTransport) return false;
      return _checker.hasConnection;
    }).distinct();
  }
}
