package com.github.jing332.utils

object NativeLib {
    external fun getLocalIp(): String

    init {
        System.loadLibrary("utils")
    }

}