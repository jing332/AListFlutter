package com.github.jing332.alistflutter.model.alist

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable


@Serializable
data class AListConfig(
    @SerialName("bleve_dir")
    val bleveDir: String = "", // /storage/emulated/0/Android/data/com.github.jing332.alistandroid.debug/files/data/bleve
    @SerialName("cdn")
    val cdn: String = "",
//    @SerialName("database")
//    val database: Database = Database(),
    @SerialName("delayed_start")
    val delayedStart: Int = 0, // 0
    @SerialName("force")
    val force: Boolean = false, // false
    @SerialName("jwt_secret")
    val jwtSecret: String = "", //
//    @SerialName("log")
//    val log: Log = Log(),
    @SerialName("max_connections")
    val maxConnections: Int = 0, // 0
    @SerialName("scheme")
    val scheme: Scheme = Scheme(),
    @SerialName("site_url")
    val siteUrl: String = "",
    @SerialName("temp_dir")
    val tempDir: String = "", // /storage/emulated/0/Android/data/com.github.jing332.alistandroid.debug/files/data/temp
    @SerialName("tls_insecure_skip_verify")
    val tlsInsecureSkipVerify: Boolean = true, // true
    @SerialName("token_expires_in")
    val tokenExpiresIn: Int = 48 // 48
) {
    @Serializable
    data class Database(
        @SerialName("db_file")
        val dbFile: String = "", // /storage/emulated/0/Android/data/com.github.jing332.alistandroid.debug/files/data/data.db
        @SerialName("host")
        val host: String = "",
        @SerialName("name")
        val name: String = "",
        @SerialName("password")
        val password: String = "",
        @SerialName("port")
        val port: Int = 0, // 0
        @SerialName("ssl_mode")
        val sslMode: String = "",
        @SerialName("table_prefix")
        val tablePrefix: String = "x_", // x_
        @SerialName("type")
        val type: String = "sqlite3", // sqlite3
        @SerialName("user")
        val user: String = ""
    )

    @Serializable
    data class Log(
        @SerialName("compress")
        val compress: Boolean = false, // false
        @SerialName("enable")
        val enable: Boolean = true, // true
        @SerialName("max_age")
        val maxAge: Int = 28, // 28
        @SerialName("max_backups")
        val maxBackups: Int = 5, // 5
        @SerialName("max_size")
        val maxSize: Int = 10, // 10
        @SerialName("name")
        val name: String = "" // /storage/emulated/0/Android/data/com.github.jing332.alistandroid.debug/files/data/log/log.log
    )

    @Serializable
    data class Scheme(
        @SerialName("address")
        val address: String = "0.0.0.0", // 0.0.0.0
        @SerialName("cert_file")
        val certFile: String = "",
        @SerialName("force_https")
        val forceHttps: Boolean = false, // false
        @SerialName("http_port")
        val httpPort: Int = 5244, // 5244
        @SerialName("https_port")
        val httpsPort: Int = -1, // -1
        @SerialName("key_file")
        val keyFile: String = "",
        @SerialName("unix_file")
        val unixFile: String = "",
        @SerialName("unix_file_perm")
        val unixFilePerm: String = ""
    )
}