package com.example.pong.data

import android.os.Parcelable
import androidx.room.Entity
import androidx.room.PrimaryKey
import kotlinx.android.parcel.Parcelize
import java.time.LocalDate

@Parcelize
@Entity(tableName = "point_table")
data class Point(
    val player: String,
    val date: LocalDate,
    @PrimaryKey(autoGenerate = true) val id: Long = 0,
) : Parcelable