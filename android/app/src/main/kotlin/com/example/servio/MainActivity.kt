package com.example.InvyGo

import android.content.Intent
import android.content.IntentFilter
import android.os.Bundle
import android.util.Log
import com.example.servio.scanner.DataWedgeBroadcastReceiver
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    
    private val SCAN_CHANNEL = "com.invygo.scanner/scans"
    private val CONTROL_CHANNEL = "com.invygo.scanner/control"
    
    private var scanEventSink: EventChannel.EventSink? = null
    private val receiver = DataWedgeBroadcastReceiver()

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        // EventChannel: Stream scans to Flutter
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, SCAN_CHANNEL).setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    scanEventSink = events
                    Log.d("MainActivity", "Scan stream listener attached")
                }

                override fun onCancel(arguments: Any?) {
                    scanEventSink = null
                    Log.d("MainActivity", "Scan stream listener cancelled")
                }
            }
        )
        
        // MethodChannel: Control DataWedge (enable/disable scanner)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CONTROL_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "enableScanner" -> {
                    sendDataWedgeCommand("ENABLE_SCANNER", true)
                    result.success(true)
                }
                "disableScanner" -> {
                    sendDataWedgeCommand("ENABLE_SCANNER", false)
                    result.success(true)
                }
                "softTriggerStart" -> {
                    sendDataWedgeCommand("SOFT_SCAN_TRIGGER", "START_SCANNING")
                    result.success(true)
                }
                "softTriggerStop" -> {
                    sendDataWedgeCommand("SOFT_SCAN_TRIGGER", "STOP_SCANNING")
                    result.success(true)
                }
                else -> result.notImplemented()
            }
        }
        
        // Set callback for receiver
        DataWedgeBroadcastReceiver.onScanReceived = { data, type ->
            scanEventSink?.success(mapOf(
                "data" to data,
                "type" to type,
                "timestamp" to System.currentTimeMillis()
            ))
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        // Register receiver dynamically with RECEIVER_EXPORTED flag
        val filter = IntentFilter("com.invygo.scanner.SCAN")
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.TIRAMISU) {
            registerReceiver(receiver, filter, android.content.Context.RECEIVER_EXPORTED)
        } else {
            registerReceiver(receiver, filter)
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        try {
            unregisterReceiver(receiver)
        } catch (e: Exception) {
            Log.e("MainActivity", "Error unregistering receiver: ${e.message}")
        }
    }

    // Send commands to DataWedge API
    private fun sendDataWedgeCommand(command: String, value: Any) {
        val intent = Intent().apply {
            action = "com.symbol.datawedge.api.ACTION"
            when (value) {
                is Boolean -> putExtra("com.symbol.datawedge.api.$command", value)
                is String -> putExtra("com.symbol.datawedge.api.$command", value)
                is Int -> putExtra("com.symbol.datawedge.api.$command", value)
                else -> putExtra("com.symbol.datawedge.api.$command", value.toString())
            }
        }
        sendBroadcast(intent)
        Log.d("MainActivity", "Sent DataWedge command: $command = $value")
    }
}
