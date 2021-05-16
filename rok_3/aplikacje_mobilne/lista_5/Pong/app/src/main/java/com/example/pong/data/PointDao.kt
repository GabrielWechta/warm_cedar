package com.example.pong.data

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import kotlinx.coroutines.flow.Flow

@Dao
interface PointDao {
    @Insert(onConflict = OnConflictStrategy.IGNORE)
    suspend fun insert(point: Point)

    @Query("SELECT * FROM point_table")
    fun getAll(): Flow<List<Point>>

    @Query("SELECT COUNT(*) FROM point_table")
    fun getAllCount(): Int

    @Query("SELECT COUNT(*) FROM point_table WHERE player = :playerName")
    fun getPlayerCount(playerName: String): Int
}