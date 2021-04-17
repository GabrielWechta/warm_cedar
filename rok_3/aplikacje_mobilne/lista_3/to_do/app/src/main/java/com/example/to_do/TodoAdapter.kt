package com.example.to_do

import android.graphics.Color
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import java.time.LocalDate
import java.time.temporal.ChronoUnit
import java.util.*

class TodoAdapter(
    var todos: MutableList<Todo>
) : RecyclerView.Adapter<TodoAdapter.TodoViewHolder>() {


    class TodoViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        val tvTodoTitle: TextView = itemView.findViewById(R.id.tvTodoTitle)
        val tvIcon: TextView = itemView.findViewById(R.id.tvIcon)
        val tvDate: TextView = itemView.findViewById(R.id.tvDate)
        val tvImportance: TextView = itemView.findViewById(R.id.tvImportance)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): TodoViewHolder {
        return TodoViewHolder(
            LayoutInflater.from(parent.context).inflate(
                R.layout.item_todo,
                parent,
                false
            )
        )
    }

    fun addTodo(todo: Todo) {
        todos.add(todo)
        notifyDataSetChanged()
    }

    fun deleteItem(pos: Int) {
        todos.removeAt(pos)
        notifyDataSetChanged()
    }

    override fun onBindViewHolder(holder: TodoViewHolder, position: Int) {
        val curTodo = todos[position]
        holder.tvTodoTitle.text = curTodo.title
        holder.tvIcon.text = curTodo.icon
        if (curTodo.date != null) {
            holder.tvDate.text = curTodo.date.toString()

            val calendar = Calendar.getInstance()
            val now = LocalDate.of(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH)+1, calendar.get(Calendar.DAY_OF_MONTH))

            val diff = ChronoUnit.DAYS.between(now, curTodo.date)

            val proportion = if (diff in 0L..10L) 150 - 15 * diff else 10
            val viewColor = Color.argb(proportion.toInt(), 255,0,0)
            holder.itemView.setBackgroundColor(viewColor)

        } else {
            holder.tvDate.text = ""
            holder.itemView.setBackgroundColor(Color.parseColor("#FFFFFF"))
        }

        holder.tvImportance.text = when (curTodo.importance) {
            1 -> "!"
            2 -> "!!"
            3 -> "!!!"
            else -> " "
        }
    }

    override fun getItemCount(): Int {
        return todos.size
    }
}