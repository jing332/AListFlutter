package com.github.jing332.alistflutter.model.alist

import android.annotation.SuppressLint
import android.util.Log
import com.github.jing332.alistflutter.R
import com.github.jing332.alistflutter.app
import com.github.jing332.alistflutter.constant.LogLevel
import com.github.jing332.alistflutter.data.entities.ServerLog.Companion.evalLog
import com.github.jing332.alistflutter.utils.FileUtils.readAllText
import com.github.jing332.alistflutter.utils.StringUtils.removeAnsiCodes
import com.github.jing332.alistflutter.utils.ToastUtils.longToast
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.isActive
import kotlinx.coroutines.launch
import java.io.File
import java.io.IOException
import java.io.InputStream
import kotlin.coroutines.coroutineContext

object AList {
    const val TAG = "AList"

    private val execPath by lazy {
        context.applicationInfo.nativeLibraryDir + File.separator + "libalist.so"
    }

    val context = app

    val dataPath: String
        get() = context.getExternalFilesDir("data")?.absolutePath!!

    val configPath: String
        get() = "$dataPath${File.separator}config.json"


    fun setAdminPassword(pwd: String) {
        val log = execWithParams(
            redirect = true,
            params = arrayOf("admin", "set", pwd, "--data", dataPath)
        ).inputStream.readAllText()
//        appDb.serverLogDao.insert(ServerLog(level = LogLevel.INFO, message = log.removeAnsiCodes()))
    }


    fun shutdown() {
        runCatching {
            mProcess?.destroy()
        }.onFailure {
            context.longToast(R.string.server_shutdown_failed, it.toString())
        }
    }

    private var mProcess: Process? = null

    private suspend fun InputStream.logWatcher(onNewLine: (String) -> Unit) {
        bufferedReader().use {
            while (coroutineContext.isActive) {
                runCatching {
                    val line = it.readLine() ?: return@use
                    onNewLine(line)
                }.onFailure {
                    Log.e(TAG, "logWatcher: ", it)
                    return@use
                }
            }

        }
    }


    private val mScope = CoroutineScope(Dispatchers.IO + Job())
    private fun initOutput() {
        val onNewLine = { msg: String ->
            msg.removeAnsiCodes().evalLog()?.let {
                Logger.log(level = it.level, time = it.time, msg = it.message)
            } ?: run {
                Logger.log(level = LogLevel.INFO, time = "", msg = msg)
            }
        }

        mScope.launch {
            mProcess?.inputStream?.logWatcher(onNewLine)
        }
        mScope.launch {
            mProcess?.errorStream?.logWatcher(onNewLine)
        }
    }


    @SuppressLint("SdCardPath")
    fun startup(
        dataFolder: String = context.getExternalFilesDir("data")?.absolutePath
            ?: "/data/data/${context.packageName}/files/data"
    ): Int {
//        appDb.serverLogDao.deleteAll()
        mProcess =
            execWithParams(params = arrayOf("server", "--data", dataFolder))
        initOutput()

        return mProcess!!.waitFor()
    }


    private fun execWithParams(
        redirect: Boolean = false,
        vararg params: String
    ): Process {
        val cmdline = arrayOfNulls<String>(params.size + 1)
        cmdline[0] = execPath
        System.arraycopy(params, 0, cmdline, 1, params.size)
        return ProcessBuilder(*cmdline).redirectErrorStream(redirect).start()
            ?: throw IOException("Process is null!")
    }
}