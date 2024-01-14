package com.github.jing332.alistflutter.utils

import android.content.Context
import android.widget.Toast
import androidx.annotation.StringRes
import kotlinx.coroutines.DelicateCoroutinesApi
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch

object ToastUtils {
    @OptIn(DelicateCoroutinesApi::class)
    fun runMain(block: () -> Unit) {
        GlobalScope.launch(Dispatchers.Main) {
            block()
        }
    }

    fun Context.toast(str: String) {
        runMain {
            Toast.makeText(this, str, Toast.LENGTH_SHORT).show()
        }
    }

    fun Context.toast(@StringRes strId: Int, vararg args: Any) {
        runMain {
            Toast.makeText(
                this,
                getString(strId, *args),
                Toast.LENGTH_SHORT
            ).show()
        }
    }

    fun Context.longToast(str: String) {
        runMain {
            Toast.makeText(this, str, Toast.LENGTH_LONG).show()
        }
    }

    fun Context.longToast(@StringRes strId: Int) {
        runMain {
            Toast.makeText(this, strId, Toast.LENGTH_LONG).show()
        }
    }

    fun Context.longToast(@StringRes strId: Int, vararg args: Any) {
        runMain {
            Toast.makeText(
                this,
                getString(strId, *args),
                Toast.LENGTH_LONG
            ).show()
        }
    }
}