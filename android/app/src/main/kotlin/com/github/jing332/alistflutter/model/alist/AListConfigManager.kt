package com.github.jing332.alistflutter.model.alist

import android.os.FileObserver
import android.util.Log
import com.github.jing332.alistflutter.app
import com.github.jing332.alistflutter.constant.AppConst
import com.github.jing332.alistflutter.utils.ToastUtils.longToast
import kotlinx.coroutines.CancellationException
import kotlinx.coroutines.awaitCancellation
import kotlinx.coroutines.coroutineScope
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.channelFlow
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.ExperimentalSerializationApi
import kotlinx.serialization.json.decodeFromStream
import kotlinx.serialization.json.encodeToStream
import java.io.File

@Suppress("DEPRECATION")
object AListConfigManager {
    const val TAG = "AListConfigManager"

    val context
        get() = app

    suspend fun flowConfig(): Flow<AListConfig> = channelFlow {
        val obs = object : FileObserver(AList.configPath) {
            override fun onEvent(event: Int, p1: String?) {
                if (listOf(CLOSE_NOWRITE, CLOSE_WRITE).contains(event))
                    runBlocking {
                        Log.d(TAG, "config.json changed: $event")
                        send((config()))
                    }
            }
        }
        coroutineScope {
            val waitJob = launch {
                obs.startWatching()
                try {
                    awaitCancellation()
                } catch (_: CancellationException) {
                }

                obs.stopWatching()
            }
            waitJob.join()
        }
    }

    @OptIn(ExperimentalSerializationApi::class)
    fun config(): AListConfig {
        try {
            File(AList.configPath).inputStream().use {
                return AppConst.json.decodeFromStream<AListConfig>(it)
            }
        } catch (e: Exception) {
            AList.context.longToast("读取 config.json 失败：\n$e")
            return AListConfig()
        }
    }

    @OptIn(ExperimentalSerializationApi::class)
    fun update(cfg: AListConfig) {
        try {
            File(AList.configPath).outputStream().use {
                AppConst.json.encodeToStream(cfg, it)
            }
        } catch (e: Exception) {
            AList.context.longToast("更新 config.json 失败：\n$e")
        }
    }

}