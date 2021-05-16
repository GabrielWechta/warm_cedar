package com.example.pong.data

import androidx.lifecycle.LiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import androidx.lifecycle.*
import kotlinx.coroutines.launch
import java.lang.IllegalArgumentException

class PointViewModel(private val repository: PointRepository) : ViewModel() {
    val allPoints : LiveData<List<Point>> = repository.allPoints.asLiveData()

    fun insert(point: Point) = viewModelScope.launch {
        repository.insert(point)
    }

    fun getPlayerCount(name: String): Int {
        var ret = 0
        viewModelScope.launch {
            ret = repository.getPlayerCount(name)
        }
        return ret
    }
}

class PointViewModelFactory(private val repository: PointRepository) : ViewModelProvider.Factory {
    override fun <T : ViewModel?> create(modelClass: Class<T>): T {
        if (modelClass.isAssignableFrom(PointViewModel::class.java)) {
            @Suppress("UNCHECKED_CAST")
            return PointViewModel(repository) as T
        }
        throw IllegalArgumentException("Unknown ViewModel class")
    }
}