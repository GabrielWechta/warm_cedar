package com.example.pong

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.Window
import android.view.WindowManager
import androidx.activity.viewModels
import com.example.pong.data.PointViewModel
import com.example.pong.data.PointViewModelFactory
import com.example.pong.data.PointsApplication

class GameActivity : AppCompatActivity() {

    private val model: PointViewModel by viewModels {
        PointViewModelFactory((application as PointsApplication).repository)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        requestWindowFeature(Window.FEATURE_NO_TITLE)
        getWindow().setFlags(
            WindowManager.LayoutParams.FLAG_FULLSCREEN,
            WindowManager.LayoutParams.FLAG_FULLSCREEN)
        val gameView = GameView(this, attributeSet = null, model);
        setContentView(gameView)
    }
}