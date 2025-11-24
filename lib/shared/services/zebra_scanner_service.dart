import 'dart:async';
import 'package:flutter/services.dart';

/// Service for integrating with Zebra TC15 hardware barcode scanner via DataWedge
class ZebraScannerService {
  static const EventChannel _scanChannel =
      EventChannel('com.invygo.scanner/scans');
  static const MethodChannel _controlChannel =
      MethodChannel('com.invygo.scanner/control');

  Stream<ScanResult>? _scanStream;
  StreamSubscription? _subscription;

  /// Stream of scan results from hardware scanner
  Stream<ScanResult> get scanStream {
    _scanStream ??= _scanChannel.receiveBroadcastStream().map((event) {
      final map = Map<String, dynamic>.from(event);
      return ScanResult(
        data: map['data'] as String,
        type: map['type'] as String,
        timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
      );
    });
    return _scanStream!;
  }

  /// Enable hardware scanner
  Future<void> enableScanner() async {
    try {
      await _controlChannel.invokeMethod('enableScanner');
    } catch (e) {
      print('Error enabling scanner: $e');
    }
  }

  /// Disable hardware scanner
  Future<void> disableScanner() async {
    try {
      await _controlChannel.invokeMethod('disableScanner');
    } catch (e) {
      print('Error disabling scanner: $e');
    }
  }

  /// Start software trigger (programmatic scan)
  Future<void> startSoftTrigger() async {
    try {
      await _controlChannel.invokeMethod('softTriggerStart');
    } catch (e) {
      print('Error starting soft trigger: $e');
    }
  }

  /// Stop software trigger
  Future<void> stopSoftTrigger() async {
    try {
      await _controlChannel.invokeMethod('softTriggerStop');
    } catch (e) {
      print('Error stopping soft trigger: $e');
    }
  }

  /// Dispose subscriptions
  void dispose() {
    _subscription?.cancel();
  }
}

/// Result from a barcode scan
class ScanResult {
  final String data;
  final String type;
  final DateTime timestamp;

  ScanResult({
    required this.data,
    required this.type,
    required this.timestamp,
  });

  @override
  String toString() => 'ScanResult(data: $data, type: $type, time: $timestamp)';
}
