package com.example.pong

import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.widget.Button
import android.widget.TextView
import androidx.activity.viewModels
import androidx.appcompat.app.AppCompatActivity
import com.example.pong.data.PointViewModel
import com.example.pong.data.PointViewModelFactory
import com.example.pong.data.PointsApplication
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch

class MainActivity : AppCompatActivity() {
    var scoreN = 0
    var scoreS = 0

    private val model: PointViewModel by viewModels()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val playButton: Button = findViewById(R.id.play_button)
        playButton.setOnClickListener {
            val intent = Intent(this, GameActivity::class.java)
            startActivity(intent)
        }

        val resultTextView: TextView = findViewById(R.id.result_text_view)
        resultTextView.text = ""
//        resultTextView.text = "N: ${scoreN} / S: ${scoreS}"

    }
}