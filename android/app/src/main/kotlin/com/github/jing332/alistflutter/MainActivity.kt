package com.github.jing332.alistflutter

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Bundle
import android.util.Log
import androidx.localbroadcastmanager.content.LocalBroadcastManager
import com.github.jing332.alistflutter.bridge.AndroidBridge
import com.github.jing332.alistflutter.bridge.AppConfigBridge
import com.github.jing332.alistflutter.model.ShortCuts
import com.github.jing332.pigeon.GeneratedApi
import com.github.jing332.pigeon.GeneratedApi.VoidResult
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    companion object {
        private val TAG = "MainActivity"
        const val BRIDGE_CHANNEL = "alistflutter/bridge"
        const val CONFIG_CHANNEL = "alistflutter/config"

        const val EVENT_CHANNEL = "alistflutter/event"
    }

    private val receiver by lazy { MyReceiver() }
    private var mEvent: GeneratedApi.Event? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        ShortCuts.buildShortCuts(this)
        LocalBroadcastManager.getInstance(this)
            .registerReceiver(receiver, IntentFilter(AListService.ACTION_STATUS_CHANGED))

        GeneratedPluginRegistrant.registerWith(this.flutterEngine!!)

        val binaryMessage = flutterEngine!!.dartExecutor.binaryMessenger
        GeneratedApi.AppConfig.setUp(binaryMessage, AppConfigBridge)
        GeneratedApi.Android.setUp(binaryMessage, AndroidBridge(this))
        mEvent = GeneratedApi.Event(binaryMessage)

    }

    override fun onDestroy() {
        super.onDestroy()

        LocalBroadcastManager.getInstance(this).unregisterReceiver(receiver)
    }


    inner class MyReceiver : BroadcastReceiver() {
        override fun onReceive(context: Context, intent: Intent) {
            if (intent.action == AListService.ACTION_STATUS_CHANGED) {
                Log.e(TAG, "onReceive: ${AListService.isRunning}")
                mEvent?.onServiceStatusChanged(AListService.isRunning, object : VoidResult {
                    override fun success() {

                    }

                    override fun error(error: Throwable) {
                    }

                })
            }
        }
    }

}
