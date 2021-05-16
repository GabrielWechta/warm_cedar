package com.example.pong.data

import androidx.annotation.WorkerThread
import androidx.lifecycle.LiveData
import kotlinx.coroutines.flow.Flow

class PointRepository(private val pointDao: PointDao) {
    val allPoints: Flow<List<Point>> = pointDao.getAll()

    @WorkerThread
    suspend fun insert(point: Point) {
        pointDao.insert(point)
    }

    @WorkerThread
     fun getPlayerCount(name: String): Int {
        return pointDao.getPlayerCount(name)
    }
}