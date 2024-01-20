package com.github.jing332.alistflutter.model.alist

import alistlib.Alistlib
import alistlib.Event
import alistlib.LogCallback
import android.annotation.SuppressLint
import android.util.Log
import com.github.jing332.alistflutter.R
import com.github.jing332.alistflutter.app
import com.github.jing332.alistflutter.config.AppConfig
import com.github.jing332.alistflutter.constant.LogLevel
import com.github.jing332.alistflutter.utils.ToastUtils.longToast
import java.io.File
import java.text.SimpleDateFormat
import java.util.Locale

object AList : Event, LogCallback {
    const val TAG = "AList"

    val context = app

    val dataDir: String
        get() = AppConfig.dataDir

    val configPath: String
        get() = "$dataDir${File.separator}config.json"


    fun init() {
        runCatching {
            Alistlib.setConfigData(dataDir)
            Alistlib.setConfigLogStd(true)
            Alistlib.init(this, this)
        }.onFailure {
            Log.e(TAG, "init:", it)
        }
    }

    interface Listener {
        fun onShutdown(type: String)
    }

    private val mListeners = mutableListOf<Listener>()

    fun addListener(listener: Listener) {
        mListeners.add(listener)
    }

    fun removeListener(listener: Listener) {
        mListeners.remove(listener)
    }

    override fun onShutdown(p0: String) {
        Log.d(TAG, "onShutdown: $p0")
        mListeners.forEach { it.onShutdown(p0) }
    }

    override fun onStartError(type: String, msg: String) {
        Log.e(TAG, "onStartError: $type, $msg")
        Logger.log(LogLevel.FATAL, type, msg)
    }

    private val mDateFormatter by lazy  { SimpleDateFormat("MM-dd HH:mm:ss", Locale.getDefault())}

    override fun onLog(level: Short, time: Long, log: String) {
        Log.d(TAG, "onLog: $level, $time, $log")
        Logger.log(level.toInt(), mDateFormatter.format(time), log)
    }

    override fun onProcessExit(code: Long) {

    }

    fun isRunning(): Boolean {
        return Alistlib.isRunning("")
    }

    fun setAdminPassword(pwd: String) {
        if (!isRunning()) init()

        Log.d(TAG, "setAdminPassword: $dataDir")
        Alistlib.setConfigData(dataDir)
        Alistlib.setAdminPassword(pwd)
    }


    fun shutdown() {
        Log.d(TAG, "shutdown")
        runCatching {
            Alistlib.shutdown(5000)
        }.onFailure {
            context.longToast(R.string.shutdown_failed)
        }
    }

    @SuppressLint("SdCardPath")
    fun startup() {
        Log.d(TAG, "startup: $dataDir")
        init()
        Alistlib.start()
    }

    fun getHttpPort(): Int {
        return AListConfigManager.config().scheme.httpPort
    }
}