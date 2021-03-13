package com.example.gabi_game_kotlin

import android.os.Bundle
import android.view.View
import android.widget.Button
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.example.gabi_game_kotlin.databinding.ActivityMainBinding
import kotlin.random.Random

class MainActivity : AppCompatActivity() {
    private lateinit var binding: ActivityMainBinding
    private var product = 0
    private var startTime: Long = 0

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        val view = binding.root
        setContentView(view)
        setOperationAndButtons()
    }

    fun setOperationAndButtons() {
        val rand = Random
        val multiplicand = rand.nextInt(10)
        val multiplier = rand.nextInt(10)
        product = multiplicand * multiplier

        binding.operation.text = multiplicand.toString() + "\t\u22C5\t" + multiplier.toString()
        binding.button.text = rand.nextInt(100).toString()
        binding.button2.text = rand.nextInt(100).toString()
        binding.button3.text = rand.nextInt(100).toString()
        binding.button4.text = rand.nextInt(100).toString()

        binding.button.setOnClickListener(View.OnClickListener { v: View? -> onClick(v!!) })
        binding.button2.setOnClickListener(View.OnClickListener { v: View? -> onClick(v!!) })
        binding.button3.setOnClickListener(View.OnClickListener { v: View? -> onClick(v!!) })
        binding.button4.setOnClickListener(View.OnClickListener { v: View? -> onClick(v!!) })

        when (rand.nextInt(4)) {
            0 -> {
                binding.button.text = product.toString()
            }
            1 -> {
                binding.button2.text = product.toString()

            }
            2 -> {
                binding.button3.text = product.toString()

            }
            3 -> {
                binding.button4.text = product.toString()
            }
        }

        startTime = System.currentTimeMillis()
    }

    fun onClick(view: View) {
        val difference = System.currentTimeMillis() - startTime

        val button = view as Button
        if (button.text.toString().toInt() == product) {
            Toast.makeText(this, difference.toString() + " ms", Toast.LENGTH_SHORT).show()
        } else {
            Toast.makeText(this, "No, Mister", Toast.LENGTH_SHORT).show()
        }
        setOperationAndButtons()
    }
}