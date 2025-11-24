part of 'network_cubit.dart';

class NetState {
  final bool isOnline;
  final bool isKnown;
  const NetState._(this.isOnline, this.isKnown);

  static const unknown = NetState._(false, false);
  static const online = NetState._(true, true);
  static const offline = NetState._(false, true);
}
