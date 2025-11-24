package com.example.servio.scanner

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log

class DataWedgeBroadcastReceiver : BroadcastReceiver() {
    
    companion object {
        private const val TAG = "DataWedgeReceiver"
        private const val EXTRA_DATA = "com.symbol.datawedge.data_string"
        private const val EXTRA_LABEL_TYPE = "com.symbol.datawedge.label_type"
        private const val EXTRA_DECODE_DATA = "com.symbol.datawedge.decode_data"
        
        // Callback to send data to Flutter
        var onScanReceived: ((String, String) -> Unit)? = null
    }

    override fun onReceive(context: Context?, intent: Intent?) {
        if (intent == null) return
        
        try {
            // Extract scan data
            val scannedData = intent.getStringExtra(EXTRA_DATA)
            val labelType = intent.getStringExtra(EXTRA_LABEL_TYPE) ?: "UNKNOWN"
            
            Log.d(TAG, "Scan received: $scannedData (Type: $labelType)")
            
            // Send to Flutter via callback
            scannedData?.let {
                onScanReceived?.invoke(it, labelType)
            }
        } catch (e: Exception) {
            Log.e(TAG, "Error processing scan: ${e.message}", e)
        }
    }
}
