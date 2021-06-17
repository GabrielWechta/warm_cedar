package com.example.newton

import android.os.Bundle
import android.util.Log
import android.view.View
import android.widget.Button
import android.widget.EditText
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import retrofit2.Retrofit
import retrofit2.converter.moshi.MoshiConverterFactory

class MainActivity : AppCompatActivity() {
    private var operation = "simplify"
    private var expression = "x^2"
    lateinit var editText: EditText
    lateinit var responseTextView: TextView
    lateinit var newton: NewtonAPI

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val retrofit = Retrofit.Builder()
            .baseUrl("https://newton.vercel.app/api/v2/")
            .addConverterFactory(MoshiConverterFactory.create())
            .build()

        newton = retrofit.create(NewtonAPI::class.java)

        editText = findViewById(R.id.editText)
        responseTextView = findViewById(R.id.resultTextView)
    }

    fun onClick(view: View) {
        operation = (view as Button).text as String
        expression = editText.text.toString()
        if (expression == ""){
            responseTextView.text = "Sir, no input."
        }

        val call = newton.calculate(operation, expression)

        call.enqueue(object : Callback<NewtonDTO> {
            override fun onResponse(call: Call<NewtonDTO>, response: Response<NewtonDTO>) {
                val body = response.body()
                if (body != null) {
                    responseTextView.text = body.result
                } else {
                    responseTextView.text = "Something broke bad."
                }
            }

            override fun onFailure(call: Call<NewtonDTO>, t: Throwable) {
                responseTextView.text = "Something went really bad."
            }
        })
    }
}