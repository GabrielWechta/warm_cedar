package com.example.pong.data

import android.app.Application
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.SupervisorJob

class PointsApplication : Application() {

    val applicationScope = CoroutineScope(SupervisorJob())

    val database by lazy { PointDatabase.getDatabase(this, applicationScope) }
    val repository by lazy { PointRepository(database.getPointDao()) }
}