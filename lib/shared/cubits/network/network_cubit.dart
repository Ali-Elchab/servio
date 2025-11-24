import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/shared/services/connectivity_service.dart';

part 'network_state.dart';

class NetworkCubit extends Cubit<NetState> {
  final ConnectivityService _svc;
  StreamSubscription<bool>? _sub;

  NetworkCubit(this._svc) : super(NetState.unknown) {
    _bootstrap();
    _sub = _svc.connectionStatusStream.distinct().listen((ok) {
      emit(ok ? NetState.online : NetState.offline);
    });
  }

  Future<void> _bootstrap() async {
    final ok = await _svc.isConnected;
    emit(ok ? NetState.online : NetState.offline);
  }

  bool get isOnline => state.isOnline;

  @override
  Future<void> close() async {
    await _sub?.cancel();
    return super.close();
  }
}
