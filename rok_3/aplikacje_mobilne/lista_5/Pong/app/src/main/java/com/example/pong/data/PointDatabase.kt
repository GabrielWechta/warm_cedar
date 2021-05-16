package com.example.pong.data

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase
import androidx.room.TypeConverters
import androidx.sqlite.db.SupportSQLiteDatabase
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.launch
import java.time.LocalDate

@Database(entities = [Point::class], version = 1, exportSchema = false)
@TypeConverters(Converters::class)
abstract class PointDatabase : RoomDatabase() {
    abstract fun getPointDao(): PointDao

    private class PointDatabaseCallback(private val scope: CoroutineScope) :
        RoomDatabase.Callback() {
        override fun onCreate(db: SupportSQLiteDatabase) {
            super.onCreate(db)
            INSTANCE?.let { database ->
                scope.launch {
                    populateDatabase(database.getPointDao())
                }
            }
        }

        suspend fun populateDatabase(pointDao: PointDao) {
            val point = Point("N", LocalDate.now())
            pointDao.insert(point)
        }
    }

    companion object {
        @Volatile
        private var INSTANCE: PointDatabase? = null
        fun getDatabase(context: Context, scope: CoroutineScope): PointDatabase {
            return INSTANCE ?: synchronized(this) {
                val instance = Room.databaseBuilder(
                    context.applicationContext,
                    PointDatabase::class.java,
                    "point_database"
                ).addCallback(
                    PointDatabaseCallback(
                        scope
                    )
                )
                    .build()
                INSTANCE = instance
                instance
            }
        }
    }
}