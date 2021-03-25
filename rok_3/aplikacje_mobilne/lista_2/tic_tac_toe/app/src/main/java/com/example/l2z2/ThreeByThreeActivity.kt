package com.example.l2z2

import android.content.Intent
import android.graphics.Color
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.Button
import android.widget.Toast

class Player(symbol: String) {
    val symbol: String = symbol
    var rowsContainer = arrayOf(0, 0, 0)
    var columnsContainer = arrayOf(0, 0, 0)
    var diagonalContainer = arrayOf(0, 0, 0)
    var oppositeDiagonalContainer = arrayOf(0, 0, 0)
}

class ThreeByThreeActivity : AppCompatActivity() {
    val SIZEOFTHEBOARD = 3
    var theGameIsOn = true
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_three_by_three)
    }

    fun tileClick(view: View) {
        val selectedButton = view as Button
        var tileId = Pair(0, 0)
        if (theGameIsOn == true) {
            when (selectedButton.id) {
                R.id.button00 -> tileId = Pair(0, 0)
                R.id.button01 -> tileId = Pair(0, 1)
                R.id.button02 -> tileId = Pair(0, 2)

                R.id.button10 -> tileId = Pair(1, 0)
                R.id.button11 -> tileId = Pair(1, 1)
                R.id.button12 -> tileId = Pair(1, 2)

                R.id.button20 -> tileId = Pair(2, 0)
                R.id.button21 -> tileId = Pair(2, 1)
                R.id.button22 -> tileId = Pair(2, 2)
            }
            ownButton(tileId, selectedButton)
        } else {
            Toast.makeText(this, "Please don't touch the buttons.", Toast.LENGTH_SHORT).show()
        }
    }

    private var playerO = Player("O")
    private var playerX = Player("X")

    private var activePlayer = playerO

    private fun ownButton(tileId: Pair<Int, Int>, selectedButton: Button) {
        val row = tileId.first
        val column = tileId.second

        selectedButton.text = activePlayer.symbol
        selectedButton.isEnabled = false

        if (activePlayer == playerO) {
            selectedButton.setBackgroundColor(Color.parseColor("#bbf2db"))
        } else {
            selectedButton.setBackgroundColor(Color.parseColor("#ea90b6"))
        }

        /*Pattern recognition part*/

        activePlayer.rowsContainer[row] += 1
        activePlayer.columnsContainer[column] += 1

        if (row == column) {
            activePlayer.diagonalContainer[row] += 1
        }
        if (row + column + 1 == SIZEOFTHEBOARD) {
            activePlayer.oppositeDiagonalContainer[row] += 1
        }

        /*Win recognition part*/
        if (activePlayer.rowsContainer[row] == SIZEOFTHEBOARD) {
            makeWin(activePlayer)
        }
        if (activePlayer.columnsContainer[column] == SIZEOFTHEBOARD) {
            makeWin(activePlayer)
        }

        var sumHolder = 0
        for (element in activePlayer.diagonalContainer) {
            sumHolder += element
        }
        if (sumHolder == SIZEOFTHEBOARD) {
            makeWin(activePlayer)
        }

        sumHolder = 0
        for (element in activePlayer.oppositeDiagonalContainer) {
            sumHolder += element
        }
        if (sumHolder == SIZEOFTHEBOARD) {
            makeWin(activePlayer)
        }

        if (activePlayer == playerO) {
            activePlayer = playerX
        } else {
            activePlayer = playerO
        }
    }

    private fun makeWin(activePlayer: Player) {
        Toast.makeText(this, activePlayer.symbol + " won!", Toast.LENGTH_SHORT).show()
        theGameIsOn = false

        intent = Intent()
        intent.putExtra("param", activePlayer.symbol )
        setResult(RESULT_OK, intent)
    }
}