package com.example.wisielec

import android.annotation.SuppressLint
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.view.View
import android.widget.Button
import android.widget.ImageView
import android.widget.TextView
import android.widget.Toast
import kotlin.random.Random

class MainActivity : AppCompatActivity() {
    private var word: String = ""
    private var encryptedWord: String = ""
    private var theGameIsOn = true
    private var deadmanCounter = 1

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        newGame()
//        Toast.makeText(this, array.size.toString(), Toast.LENGTH_LONG).show()
    }

    private fun newGame() {
        val wordsArray = resources.getStringArray(R.array.words_for_game)
        var index = Random.nextInt().rem(wordsArray.size)
        if (index < 0) {
            index += wordsArray.size
        }

        word = wordsArray[index]
        encryptedWord = encrypt(word)

        val editText = findViewById<TextView>(R.id.wordView)
        editText.text = encryptedWord
        Log.e("dup", word)
    }

    private fun encrypt(word: String): String {
        var encrypt_word = ""
        for (element in word) {
            if (element != '-') {
                encrypt_word += "?"
            } else {
                encrypt_word += "-"
            }
        }
        return encrypt_word
    }

    @SuppressLint("UseCompatLoadingForDrawables")
    fun onClick(view: View) {
        if (theGameIsOn == true) {
            val selectedButton = view as Button
            val letter = selectedButton.text
            var guessed = false


            selectedButton.isEnabled = false
            selectedButton.text = ""

            /* Handling letter guessing */
            for (i in word.indices) {
                if (word[i].toString() == letter) {
                    encryptedWord =
                        encryptedWord.substring(0, i) + letter + encryptedWord.substring(i + 1)
                    guessed = true
                }
            }

            if (guessed == true) {
                val editText = findViewById<TextView>(R.id.wordView)
                editText.text = encryptedWord

                if (encryptedWord == word) {
                    Toast.makeText(this, "Well done!", Toast.LENGTH_LONG).show()
                    theGameIsOn = false
                }
            }
            else{
                deadmanCounter +=1
                val imageView = findViewById<ImageView>(R.id.imageView)
                when(deadmanCounter){
                    2 -> imageView.setImageDrawable(resources.getDrawable(R.drawable.deadman2, applicationContext.theme))
                    3 -> imageView.setImageDrawable(resources.getDrawable(R.drawable.deadman3, applicationContext.theme))
                    4 -> imageView.setImageDrawable(resources.getDrawable(R.drawable.deadman4, applicationContext.theme))
                    5 -> imageView.setImageDrawable(resources.getDrawable(R.drawable.deadman5, applicationContext.theme))
                    6 -> imageView.setImageDrawable(resources.getDrawable(R.drawable.deadman6, applicationContext.theme))
                    7 -> {
                        imageView.setImageDrawable(resources.getDrawable(R.drawable.deadman7, applicationContext.theme))
                        Toast.makeText(this, "You didn't save Babish, pitty.", Toast.LENGTH_LONG).show()
                        theGameIsOn = false
                    }
                }
            }

        } else {
            Toast.makeText(
                this,
                "Please don't touch the buttons.",
                Toast.LENGTH_SHORT
            ).show()
        }
    }

}