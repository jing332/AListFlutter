package com.github.jing332.alistflutter

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import com.github.jing332.alistflutter.config.AppConfig

class BootReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        if (intent.action == Intent.ACTION_BOOT_COMPLETED && AppConfig.isStartAtBootEnabled) {
            context.startService(Intent(context, AListService::class.java))
        }
    }
}
