package com.example.to_do

import android.app.Activity
import android.app.PendingIntent
import android.content.Intent
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.View
import android.view.View.OnFocusChangeListener
import android.view.inputmethod.InputMethodManager
import android.widget.*
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import com.google.android.material.textfield.TextInputEditText
import java.time.LocalDate
import java.util.*


const val TODO_TITLE = "name"
const val TODO_DATE = "date"
const val TODO_ICON = "image"
const val TODO_IMPORTANCE = "importance"

class AddTodoActivity : AppCompatActivity() {
    private lateinit var calendar: Calendar
    private lateinit var spinner: Spinner

    private lateinit var tietTitle: TextInputEditText
    private lateinit var dpDate: DatePicker

    private var todoTitle: String = ""
    private var todoDate: LocalDate? = null
    private var todoImportance: Int? = null
    private var todoIcon: String? = null


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.add_todo_layout)

        val emojis = resources.getStringArray(R.array.emojis)

        /** Title picker */

        tietTitle = findViewById(R.id.tietTitle)
        tietTitle.onFocusChangeListener = OnFocusChangeListener { v, hasFocus ->
            if (!hasFocus) {
                hideKeyboard(v)
            }
        }
        tietTitle.addTextChangedListener(object : TextWatcher {
            override fun afterTextChanged(s: Editable?) {
            }

            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {
            }

            override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
                todoTitle = s.toString()
            }
        })

        /** Date picker */

        calendar = Calendar.getInstance()
        val thisYear = calendar.get(Calendar.YEAR)
        val month = calendar.get(Calendar.MONTH)
        val day = calendar.get(Calendar.DAY_OF_MONTH)

        dpDate = findViewById(R.id.dpDate)
        dpDate.init(
            thisYear,
            month,
            day
        ) { _, year, monthOfYear, dayOfMonth ->
            todoDate = LocalDate.of(year, monthOfYear + 1, dayOfMonth)
        }

        /** Icon picker */

        spinner = findViewById(R.id.spinner)
        ArrayAdapter.createFromResource(
            this,
            R.array.emojis,
            android.R.layout.simple_spinner_item
        ).also { adapter ->
            adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item)
            spinner.adapter = adapter
        }

        spinner.onItemSelectedListener = object :
            AdapterView.OnItemSelectedListener {
            override fun onItemSelected(
                parent: AdapterView<*>,
                view: View, position: Int, id: Long
            ) {
                todoIcon = emojis[position].toString()
            }

            override fun onNothingSelected(parent: AdapterView<*>) {
            }
        }

        /** Done button */

        findViewById<Button>(R.id.bDone).setOnClickListener {
            finishAdding()
        }
    }

    private fun finishAdding() {
        startNotification(todoTitle, todoDate, todoImportance, todoIcon)

        val resultIntent = Intent()

        if (todoTitle.isEmpty() || todoDate == null || todoImportance == null || todoIcon == null) {
            setResult(Activity.RESULT_CANCELED, resultIntent)
        } else {
            resultIntent.putExtra(TODO_TITLE, todoTitle)
            resultIntent.putExtra(TODO_DATE, todoDate.toString())
            resultIntent.putExtra(TODO_IMPORTANCE, todoImportance.toString())
            resultIntent.putExtra(TODO_ICON, todoIcon)
            setResult(Activity.RESULT_OK, resultIntent)
            finish()
        }
    }

    private fun startNotification(
        todoTitle: String,
        todoDate: LocalDate?,
        todoImportance: Int?,
        todoIcon: String?
    ) {
        val builder = NotificationCompat.Builder(this, "upcoming")
            .setSmallIcon(R.drawable.ic_baseline_gps_not_fixed_24)
            .setContentTitle(todoTitle.toUpperCase(Locale.ROOT))
            .setContentText("$todoTitle is scheduled for ${todoDate.toString()}. It's $todoImportance important and you have chosen $todoIcon as it's type.")
            .setPriority(NotificationCompat.PRIORITY_DEFAULT)

//        val contentIntent = PendingIntent.getActivity(
//            this, 0,
//            Intent(this, MainActivity::class.java), PendingIntent.FLAG_UPDATE_CURRENT
//        )

//        builder.setContentIntent(contentIntent)

        NotificationManagerCompat.from(this).notify(todoDate.hashCode(), builder.build())
    }

    fun onRadioButtonClicked(view: View) {
        if (view is RadioButton) {
            when (view.getId()) {
                R.id.rbOne ->
                    todoImportance = 1
                R.id.rbTwo ->
                    todoImportance = 2
                R.id.rbThree ->
                    todoImportance = 3
            }
        }
    }

    private fun hideKeyboard(view: View) {
        val inputMethodManager: InputMethodManager =
            getSystemService(INPUT_METHOD_SERVICE) as InputMethodManager
        inputMethodManager.hideSoftInputFromWindow(view.windowToken, 0)
    }
}
