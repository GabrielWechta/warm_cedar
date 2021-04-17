package com.example.to_do

import android.app.Activity
import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.view.Menu
import android.view.MenuItem
import android.widget.Button
import android.widget.EditText
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.res.ResourcesCompat
import androidx.recyclerview.widget.ItemTouchHelper
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.google.android.material.floatingactionbutton.FloatingActionButton
import www.sanju.motiontoast.MotionToast
import java.time.LocalDate

class MainActivity : AppCompatActivity() {

    private lateinit var todoAdapter: TodoAdapter
    private val newTodoActivityRequestCode = 1
    private var savedTodos = mutableListOf<Todo>();

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        setupRecyclerView(mutableListOf())

        createNotificationChannel()

        val btnAddTodo: Button = findViewById(R.id.btnAddTodo)
        val etTodoTitle: EditText = findViewById(R.id.etTodoTitle)

        btnAddTodo.setOnClickListener {
            val todoTitle = etTodoTitle.text.toString()
            if (todoTitle.isNotEmpty()) {
                val todo = Todo(todoTitle)
                todoAdapter.addTodo(todo)
                etTodoTitle.text.clear()
            }
        }

        val fabOpenAddActivity: FloatingActionButton = findViewById(R.id.fabOpenAddActivity)
        fabOpenAddActivity.setOnClickListener {
            val intent = Intent(this, AddTodoActivity::class.java)
            startActivityForResult(intent, newTodoActivityRequestCode)
        }
    }

    private fun createNotificationChannel() {
        val name = getString(R.string.channel_name)
        val descriptionText = getString(R.string.channel_description)
        val importance = NotificationManager.IMPORTANCE_DEFAULT
        val channel = NotificationChannel("upcoming", name, importance).apply {
            description = descriptionText
        }
        val notificationManager: NotificationManager =
            getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        notificationManager.createNotificationChannel(channel)
    }


    private fun setupRecyclerView(todos: MutableList<Todo>) {
        todoAdapter =
            TodoAdapter(todos)

        val itemTouchHelper = ItemTouchHelper(SwipeToDelete(todoAdapter))

        val rvTodoItems: RecyclerView = findViewById(R.id.rvTodoItems)
        rvTodoItems.adapter = todoAdapter
        rvTodoItems.layoutManager = LinearLayoutManager(this)

        itemTouchHelper.attachToRecyclerView(rvTodoItems)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, intentData: Intent?) {
        super.onActivityResult(requestCode, resultCode, intentData)

        /* Inserts a to'do into viewModel. */
        if (requestCode == newTodoActivityRequestCode && resultCode == Activity.RESULT_OK) {
            intentData?.let { data ->
                val title = data.getStringExtra(TODO_TITLE)
                val date = LocalDate.parse(data.getStringExtra(TODO_DATE))
                val importance = data.getStringExtra(TODO_IMPORTANCE)?.toInt()
                val icon = data.getStringExtra(TODO_ICON)

                if (title != null && date != null && importance != null && icon != null) {
                    MotionToast.createToast(
                        this,
                        "Congrats, man!",
                        "You have added $title to todo!",
                        MotionToast.TOAST_INFO,
                        MotionToast.GRAVITY_BOTTOM,
                        MotionToast.SHORT_DURATION,
                        ResourcesCompat.getFont(this, R.font.helvetica_regular)
                    )
                    val todo = Todo(title, date, icon, importance)
                    todoAdapter.addTodo(todo)
                }
            }
        }
    }

    override fun onCreateOptionsMenu(menu: Menu?): Boolean {
        val inflater = menuInflater
        inflater.inflate(R.menu.todo_menu, menu)
        return super.onCreateOptionsMenu(menu)
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        when (item.itemId) {
            R.id.miSortByDate -> {
                todoAdapter.todos.sortBy { it.date }
                todoAdapter.notifyDataSetChanged()

                return true
            }
            R.id.miGroupByIcon -> {
                todoAdapter.todos.sortBy { it.icon }
                todoAdapter.notifyDataSetChanged()

                return true
            }
        }
        return super.onOptionsItemSelected(item)
    }

    override fun onSaveInstanceState(outState: Bundle) {
        super.onSaveInstanceState(outState)
        
        savedTodos = todoAdapter.todos
        outState.putParcelableArrayList("savedTodos", java.util.ArrayList(savedTodos))
    }

    override fun onRestoreInstanceState(savedInstanceState: Bundle) {
        super.onRestoreInstanceState(savedInstanceState)

        val restoredTodos = savedInstanceState.getParcelableArrayList<Todo>("savedTodos")
        if (restoredTodos != null) {
            todoAdapter.todos = restoredTodos
        }
    }
}