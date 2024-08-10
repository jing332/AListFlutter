package com.github.jing332.alistflutter.bridge

import com.github.jing332.alistflutter.config.AppConfig
import com.github.jing332.pigeon.GeneratedApi


object AppConfigBridge : GeneratedApi.AppConfig {
    override fun isWakeLockEnabled() = AppConfig.isWakeLockEnabled

    override fun isStartAtBootEnabled() = AppConfig.isStartAtBootEnabled

    override fun isAutoCheckUpdateEnabled() = AppConfig.isAutoCheckUpdateEnabled
    override fun isAutoOpenWebPageEnabled() = AppConfig.isAutoOpenWebPageEnabled
    override fun getDataDir() = AppConfig.dataDir

    override fun setDataDir(dir: String) {
        AppConfig.dataDir = dir
    }

    override fun isSilentJumpAppEnabled(): Boolean = AppConfig.isSilentJumpAppEnabled

    override fun setSilentJumpAppEnabled(enabled: Boolean) {
        AppConfig.isSilentJumpAppEnabled = enabled
    }

    override fun setAutoOpenWebPageEnabled(enabled: Boolean) {
        AppConfig.isAutoOpenWebPageEnabled = enabled
    }

    override fun setAutoCheckUpdateEnabled(enabled: Boolean) {
        AppConfig.isAutoCheckUpdateEnabled = enabled
    }

    override fun setStartAtBootEnabled(enabled: Boolean) {
        AppConfig.isStartAtBootEnabled = enabled
    }

    override fun setWakeLockEnabled(enabled: Boolean) {
        AppConfig.isWakeLockEnabled = enabled
    }
}