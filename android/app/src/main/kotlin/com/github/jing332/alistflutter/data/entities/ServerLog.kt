package com.github.jing332.alistflutter.data.entities

import com.github.jing332.alistflutter.constant.LogLevel

data class ServerLog(

    @LogLevel val level: Int,
    val message: String,
    val time: String,
) {
    companion object {

        @Suppress("RegExpRedundantEscape")
        fun String.evalLog(): ServerLog? {
            val logPattern = """(\w+)\[(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2})\] (.+)""".toRegex()
            val result = logPattern.find(this)
            if (result != null) {
                val (level, time, msg) = result.destructured
                val l = when (level[0].toString()) {
                    "D" -> LogLevel.DEBUG
                    "I" -> LogLevel.INFO
                    "W" -> LogLevel.WARN
                    "E" -> LogLevel.ERROR
                    else -> LogLevel.INFO
                }
                return ServerLog(level = l, message = msg, time = time)
            }
            return null
        }
    }
}
