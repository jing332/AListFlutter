package com.github.jing332.alistflutter.bridge

import android.content.Context
import android.content.Intent
import android.os.Build
import com.github.jing332.alistflutter.AListService
import com.github.jing332.alistflutter.BuildConfig
import com.github.jing332.alistflutter.R
import com.github.jing332.alistflutter.SwitchServerActivity
import com.github.jing332.alistflutter.model.alist.AList
import com.github.jing332.alistflutter.utils.MyTools
import com.github.jing332.alistflutter.utils.ToastUtils.longToast
import com.github.jing332.alistflutter.utils.ToastUtils.toast
import com.github.jing332.pigeon.GeneratedApi

class AndroidBridge(private val context: Context) : GeneratedApi.Android {
    override fun addShortcut() {
        MyTools.addShortcut(
            context,
            context.getString(R.string.app_switch),
            "alist_flutter_switch",
            R.drawable.alist_switch,
            Intent(context, SwitchServerActivity::class.java)
        )
    }

    override fun startService() {
        context.startService(Intent(context, AListService::class.java))
    }

    override fun setAdminPwd(pwd: String) {
        AList.setAdminPassword(pwd)
    }

    override fun getAListHttpPort(): Long {
        return AList.getHttpPort().toLong()
    }

    override fun isRunning() = AListService.isRunning


    override fun getAListVersion() = BuildConfig.ALIST_VERSION
}