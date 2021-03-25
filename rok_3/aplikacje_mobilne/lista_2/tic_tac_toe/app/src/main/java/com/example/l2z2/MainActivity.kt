package com.example.l2z2

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.EditText
import android.widget.TextView
import android.widget.Toast
import org.w3c.dom.Text

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if ((requestCode == 2404 || requestCode == 2505) && resultCode == RESULT_OK) {
            val whoWonTextView = findViewById<TextView>(R.id.editTextWhoWon)
            if (data != null) {
                whoWonTextView.text = "Last won was comitted by: " + data.getStringExtra("param")
            }
        }
    }

    fun open3by3(view: View) {
        val intent = Intent(this, ThreeByThreeActivity::class.java)
        startActivityForResult(intent, 2404)
    }

    fun open5by5(view: View) {
        val intent = Intent(this, FiveByFiveActivity::class.java)
        startActivityForResult(intent, 2505)
    }
}