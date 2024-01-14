package com.github.jing332.alistflutter.model

import android.content.Context
import android.content.Intent
import androidx.core.content.pm.ShortcutInfoCompat
import androidx.core.content.pm.ShortcutManagerCompat
import androidx.core.graphics.drawable.IconCompat
import com.github.jing332.alistflutter.R
import com.github.jing332.alistflutter.SwitchServerActivity


object ShortCuts {
    private inline fun <reified T> buildIntent(context: Context): Intent {
        val intent = Intent(context, T::class.java)
        intent.action = Intent.ACTION_VIEW
        return intent
    }


    private fun buildAlistSwitchShortCutInfo(context: Context): ShortcutInfoCompat {
        val msSwitchIntent = buildIntent<SwitchServerActivity>(context)
        return ShortcutInfoCompat.Builder(context, "alist_switch")
            .setShortLabel(context.getString(R.string.app_switch))
            .setLongLabel(context.getString(R.string.app_switch))
            .setIcon(IconCompat.createWithResource(context, R.drawable.alist_switch))
            .setIntent(msSwitchIntent)
            .build()
    }


    fun buildShortCuts(context: Context) {
        ShortcutManagerCompat.setDynamicShortcuts(
            context, listOf(
                buildAlistSwitchShortCutInfo(context),
            )
        )
    }


}