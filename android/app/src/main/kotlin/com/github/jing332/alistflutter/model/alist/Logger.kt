package com.github.jing332.alistflutter.model.alist

object Logger {
    private var listeners = mutableListOf<Listener>()

    fun addListener(listener: Listener) {
        listeners.add(listener)
    }

    fun removeListener(listener: Listener) {
        listeners.remove(listener)
    }

    interface Listener {
        fun onLog(level: Int, time: String, msg: String)
    }

    fun log(level: Int, time: String, msg: String) {
        listeners.forEach {
            it.onLog(level, time, msg)
        }
    }
}