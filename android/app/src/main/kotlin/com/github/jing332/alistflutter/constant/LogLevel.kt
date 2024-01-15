package com.github.jing332.alistflutter.constant

import androidx.annotation.IntDef

@IntDef(
    LogLevel.PANIC,
    LogLevel.FATAL,
    LogLevel.ERROR,
    LogLevel.WARN,
    LogLevel.INFO,
    LogLevel.DEBUG,
    LogLevel.TRACE
)
annotation class LogLevel {
    companion object {
        const val PANIC = 0
        const val FATAL = 1
        const val ERROR = 2
        const val WARN = 3
        const val INFO = 4
        const val DEBUG = 5
        const val TRACE = 6

        fun Int.toLevelString(): String {
            return when (this) {
                PANIC -> "PANIC"
                FATAL -> "FATAL"
                ERROR -> "ERROR"
                WARN -> "WARN"
                INFO -> "INFO"
                DEBUG -> "DEBUG"
                TRACE -> "TRACE"
                else -> "UNKNOWN"
            }
        }
    }

}