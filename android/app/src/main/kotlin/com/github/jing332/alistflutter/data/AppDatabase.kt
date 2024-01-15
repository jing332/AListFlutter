/*
package com.github.jing332.alistflutter.data

import androidx.room.AutoMigration
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase
import com.github.jing332.alistandroid.data.dao.ServerLogDao
import com.github.jing332.alistflutter.data.entities.ServerLog
import com.github.jing332.alistflutter.App.Companion.app

val appDb by lazy { AppDatabase.create() }

@Database(
    version = 2,
    entities = [ServerLog::class],
    autoMigrations = [
        AutoMigration(from = 1, to = 2)
    ]
)
abstract class AppDatabase : RoomDatabase() {
    abstract val serverLogDao: ServerLogDao

    companion object {
        fun create() = Room.databaseBuilder(
            app,
            AppDatabase::class.java,
            "alistandroid.db"
        )
            .allowMainThreadQueries()
            .build()
    }
}*/
