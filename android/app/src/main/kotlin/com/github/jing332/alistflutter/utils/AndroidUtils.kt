package com.github.jing332.alistflutter.utils

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Context.RECEIVER_EXPORTED
import android.content.IntentFilter
import android.os.Build

object AndroidUtils {
    fun Context.registerReceiverCompat(
        receiver: BroadcastReceiver,
        vararg actions: String
    ) {
        val intentFilter = IntentFilter()
        actions.forEach { intentFilter.addAction(it) }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            registerReceiver(receiver, intentFilter, RECEIVER_EXPORTED)
        } else {
            registerReceiver(receiver, intentFilter)
        }
    }
}