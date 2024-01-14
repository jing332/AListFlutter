package com.github.jing332.alistflutter.config

import android.content.Context
import com.cioccarellia.ksprefs.KsPrefs
import com.cioccarellia.ksprefs.dynamic
import com.github.jing332.alistflutter.app

object AppConfig {
    val prefs by lazy { KsPrefs(app, "app") }

    var isWakeLockEnabled: Boolean by prefs.dynamic("isWakeLockEnabled", fallback = false)
    var isStartAtBootEnabled: Boolean by prefs.dynamic("isStartAtBootEnabled", fallback = false)
    var isAutoCheckUpdateEnabled: Boolean by prefs.dynamic(
        "isAutoCheckUpdateEnabled",
        fallback = false
    )

}