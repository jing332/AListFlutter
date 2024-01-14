package com.github.jing332.alistflutter

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Bundle
import android.util.Log
import androidx.localbroadcastmanager.content.LocalBroadcastManager
import com.github.jing332.alistflutter.config.AppConfig
import com.github.jing332.alistflutter.model.ShortCuts
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity(), MethodChannel.MethodCallHandler,
    EventChannel.StreamHandler {
    companion object {
        private val TAG = "MainActivity"
        const val BRIDGE_CHANNEL = "alistflutter/bridge"
        const val CONFIG_CHANNEL = "alistflutter/config"

        const val EVENT_CHANNEL = "alistflutter/event"
    }

    private val receiver by lazy { MyReceiver() }
    private var mEventSink: EventChannel.EventSink? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        ShortCuts.buildShortCuts(this)
        LocalBroadcastManager.getInstance(this)
            .registerReceiver(receiver, IntentFilter(AListService.ACTION_STATUS_CHANGED))

        GeneratedPluginRegistrant.registerWith(this.flutterEngine!!)

        MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, BRIDGE_CHANNEL)
            .setMethodCallHandler(this)

        MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CONFIG_CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "isWakeLockEnabled" -> result.success(AppConfig.isWakeLockEnabled)
                    "setWakeLockEnabled" -> {
                        AppConfig.isWakeLockEnabled = call.arguments as Boolean
                        result.success(null)
                    }

                    "isStartAtBootEnabled" -> result.success(AppConfig.isStartAtBootEnabled)
                    "setStartAtBootEnabled" -> {
                        AppConfig.isStartAtBootEnabled = call.arguments as Boolean
                        result.success(null)
                    }

                    "isAutoCheckUpdateEnabled" -> result.success(AppConfig.isAutoCheckUpdateEnabled)
                    "setAutoCheckUpdateEnabled" -> {
                        AppConfig.isAutoCheckUpdateEnabled = call.arguments as Boolean
                        result.success(null)
                    }
                }
            }
        EventChannel(flutterEngine!!.dartExecutor.binaryMessenger, EVENT_CHANNEL)
            .setStreamHandler(this)
    }

    override fun onDestroy() {
        super.onDestroy()

        LocalBroadcastManager.getInstance(this).unregisterReceiver(receiver)
    }


    inner class MyReceiver : BroadcastReceiver() {
        override fun onReceive(context: Context, intent: Intent) {
            if (intent.action == AListService.ACTION_STATUS_CHANGED) {
                mEventSink?.success(AListService.isRunning)
            }
        }
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "startService" -> {
                Log.d(TAG, "startService")
                startService(Intent(this, AListService::class.java))
                result.success(null)
            }

            "isRunning" -> result.success(AListService.isRunning)

            else -> result.notImplemented()
        }
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        mEventSink = events
    }

    override fun onCancel(arguments: Any?) {

    }

}
