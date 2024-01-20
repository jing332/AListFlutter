package com.github.jing332.alistflutter

import alistlib.Alistlib
import android.annotation.SuppressLint
import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Build
import android.os.IBinder
import android.os.PowerManager
import androidx.localbroadcastmanager.content.LocalBroadcastManager
import com.github.jing332.alistflutter.config.AppConfig
import com.github.jing332.alistflutter.model.alist.AList
import com.github.jing332.alistflutter.utils.AndroidUtils.registerReceiverCompat
import com.github.jing332.alistflutter.utils.ClipboardUtils
import com.github.jing332.alistflutter.utils.ToastUtils.toast
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Job
import splitties.systemservices.powerManager

class AListService : Service(), AList.Listener {
    companion object {
        const val TAG = "AlistService"
        const val ACTION_SHUTDOWN =
            "com.github.jing332.alistandroid.service.AlistService.ACTION_SHUTDOWN"

        const val ACTION_COPY_ADDRESS =
            "com.github.jing332.alistandroid.service.AlistService.ACTION_COPY_ADDRESS"

        const val ACTION_STATUS_CHANGED =
            "com.github.jing332.alistandroid.service.AlistService.ACTION_STATUS_CHANGED"

        const val NOTIFICATION_CHAN_ID = "alist_server"
        const val FOREGROUND_ID = 5224

        var isRunning: Boolean = false
    }

    private val mScope = CoroutineScope(Job())
    private val mNotificationReceiver = NotificationActionReceiver()
    private val mReceiver = MyReceiver()
    private var mWakeLock: PowerManager.WakeLock? = null
    private var mLocalAddress: String = ""

    override fun onBind(p0: Intent?): IBinder? = null

    @Suppress("DEPRECATION")
    private fun notifyStatusChanged() {
        LocalBroadcastManager.getInstance(this)
            .sendBroadcast(Intent(ACTION_STATUS_CHANGED))

        if (!isRunning) {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                stopForeground(STOP_FOREGROUND_REMOVE)
            } else
                stopForeground(true)

            stopSelf()
        }
    }

    @SuppressLint("WakelockTimeout")
    override fun onCreate() {
        super.onCreate()

        initOrUpdateNotification()

        if (AppConfig.isWakeLockEnabled) {
            mWakeLock = powerManager.newWakeLock(
                PowerManager.PARTIAL_WAKE_LOCK,
                "alist::service"
            )
            mWakeLock?.acquire()
        }

        LocalBroadcastManager.getInstance(this)
            .registerReceiver(
                mReceiver,
                IntentFilter(ACTION_STATUS_CHANGED)
            )
        registerReceiverCompat(
            mNotificationReceiver,
            ACTION_SHUTDOWN,
            ACTION_COPY_ADDRESS
        )

        AList.addListener(this)
    }


    @Suppress("DEPRECATION")
    override fun onDestroy() {
        super.onDestroy()

        mWakeLock?.release()
        mWakeLock = null

        stopForeground(true)

        LocalBroadcastManager.getInstance(this).unregisterReceiver(mReceiver)
        unregisterReceiver(mNotificationReceiver)

        AList.removeListener(this)
    }

    override fun onShutdown(type: String) {
        if (!AList.isRunning()) {
            isRunning = false
            notifyStatusChanged()
        }
    }

    private fun startOrShutdown() {
        if (isRunning) {
            AList.shutdown()
        } else {
            toast(getString(R.string.starting))
            isRunning = true
            AList.startup()
            notifyStatusChanged()
        }
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        startOrShutdown()

        return super.onStartCommand(intent, flags, startId)
    }

    inner class MyReceiver : BroadcastReceiver() {
        override fun onReceive(context: Context?, intent: Intent) {
            when (intent.action) {
                ACTION_STATUS_CHANGED -> {

                }
            }

        }
    }

    private fun localAddress(): String = Alistlib.getOutboundIPString()


    @Suppress("DEPRECATION")
    private fun initOrUpdateNotification() {
        // Android 12(S)+ 必须指定PendingIntent.FLAG_
        val pendingIntentFlags = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S)
            PendingIntent.FLAG_IMMUTABLE
        else
            0

        /*点击通知跳转*/
        val pendingIntent =
            PendingIntent.getActivity(
                this, 0, Intent(
                    this,
                    MainActivity::class.java
                ),
                pendingIntentFlags
            )
        /*当点击退出按钮时发送广播*/
        val shutdownAction: PendingIntent =
            PendingIntent.getBroadcast(
                this,
                0,
                Intent(ACTION_SHUTDOWN),
                pendingIntentFlags
            )
        val copyAddressPendingIntent =
            PendingIntent.getBroadcast(
                this,
                0,
                Intent(ACTION_COPY_ADDRESS),
                pendingIntentFlags
            )

//        val color = com.github.jing332.alistandroid.ui.theme.seed.androidColor
        val smallIconRes: Int
        val builder = Notification.Builder(applicationContext)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {/*Android 8.0+ 要求必须设置通知信道*/
            val chan = NotificationChannel(
                NOTIFICATION_CHAN_ID,
                getString(R.string.alist_server),
                NotificationManager.IMPORTANCE_NONE
            )
//            chan.lightColor = color
            chan.lockscreenVisibility = Notification.VISIBILITY_PRIVATE
            val service = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            service.createNotificationChannel(chan)
            smallIconRes = when ((0..1).random()) {
                0 -> R.drawable.server
                1 -> R.drawable.server2
                else -> R.drawable.server2
            }

            builder.setChannelId(NOTIFICATION_CHAN_ID)
        } else {
            smallIconRes = R.mipmap.ic_launcher_round
        }
        val notification = builder
//            .setColor(color)
            .setContentTitle(getString(R.string.alist_server_running))
            .setContentText(localAddress())
            .setSmallIcon(smallIconRes)
            .setContentIntent(pendingIntent)
            .addAction(0, getString(R.string.shutdown), shutdownAction)
            .addAction(0, getString(R.string.copy_address), copyAddressPendingIntent)

            .build()

        startForeground(FOREGROUND_ID, notification)
    }

    inner class NotificationActionReceiver : BroadcastReceiver() {
        override fun onReceive(ctx: Context?, intent: Intent?) {
            when (intent?.action) {
                ACTION_SHUTDOWN -> {
                    startOrShutdown()
                }

                ACTION_COPY_ADDRESS -> {
                    ClipboardUtils.copyText("AList", localAddress())
                    toast(R.string.address_copied)
                }
            }
        }
    }

}