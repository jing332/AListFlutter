package com.github.jing332.alistflutter

import android.content.Context
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor.DartEntrypoint
import io.flutter.plugin.common.MethodChannel
import io.flutter.view.FlutterMain
import kotlinx.coroutines.Job
import kotlinx.coroutines.awaitCancellation
import kotlinx.coroutines.coroutineScope
import kotlinx.coroutines.job
import kotlinx.coroutines.launch


object BridgeUtils {
    private val CHANNEL = "main"

    fun getMethodChannel(context: Context): MethodChannel {
        FlutterMain.startInitialization(context)
        FlutterMain.ensureInitializationComplete(context, arrayOfNulls(0))
        val engine = FlutterEngine(context.applicationContext)
        val entrypoint = DartEntrypoint("lib/main.dart", "widget")
        engine.dartExecutor.executeDartEntrypoint(entrypoint)

        return MethodChannel(engine.dartExecutor.binaryMessenger, CHANNEL)
    }

    suspend fun MethodChannel.invokeMethodSync(
        method: String,
        arguments: Any? = null
    ): MethodChannelResult = coroutineScope {
        var result: MethodChannelResult? = null
        var waitJob: Job? = null

        invokeMethod(
            method, arguments,
            object : MethodChannel.Result {
                override fun success(r: Any?) {
                    result = MethodChannelResult.Success(r)
                }

                override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
                    result = MethodChannelResult.Error(errorCode, errorMessage, errorDetails)
                }

                override fun notImplemented() {
                    result = MethodChannelResult.NotImplemented
                }
            }
        )


        waitJob = launch {
            awaitCancellation()
        }.job
        waitJob.start()


        return@coroutineScope result!!
    }

    sealed class MethodChannelResult {
        data class Success(val result: Any?) : MethodChannelResult()
        data class Error(val errorCode: String, val errorMessage: String?, val errorDetails: Any?) :
            MethodChannelResult()

        object NotImplemented : MethodChannelResult()
    }
}