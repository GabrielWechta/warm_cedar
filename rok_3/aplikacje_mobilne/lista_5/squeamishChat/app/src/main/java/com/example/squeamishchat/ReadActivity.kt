package com.example.squeamishchat

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.widget.Button
import android.widget.TextView
import android.widget.Toast
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.FirebaseUser
import com.google.firebase.database.ChildEventListener
import com.google.firebase.database.DataSnapshot
import com.google.firebase.database.DatabaseError
import com.google.firebase.database.DatabaseReference
import com.google.firebase.database.ktx.database
import com.google.firebase.database.ktx.getValue
import com.google.firebase.ktx.Firebase
import kotlin.experimental.xor

class ReadActivity : AppCompatActivity() {
    private lateinit var messagesRef: DatabaseReference
    private var messageList = mutableListOf<Message>()
    private lateinit var currentUser: FirebaseUser
    private var messageIndex = 0
    private lateinit var messageTextView: TextView
    private var squeamish = ""

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_read)

        squeamish = intent.getStringExtra("squeamish").toString()

        messagesRef = Firebase.database.getReference("messages")
        currentUser = FirebaseAuth.getInstance().currentUser!!

        val prevButton = findViewById<Button>(R.id.prevButton)
        prevButton.setOnClickListener {
            if (messageIndex > 0) messageIndex -= 1 else messageIndex = 0
            showMessage()
        }

        val nextButton = findViewById<Button>(R.id.nextButton)
        nextButton.setOnClickListener {
            if (messageIndex < messageList.size - 1) {
                messageIndex += 1
            }
            showMessage()
        }

        messageTextView = findViewById(R.id.messageTextView)

        val childEventListener = object : ChildEventListener {
            override fun onChildAdded(dataSnapshot: DataSnapshot, previousChildName: String?) {
                val message = dataSnapshot.getValue<Message>()
                if (message != null) {
                    messageList.add(message)
                    if (!currentUser.let { message.whoRead.containsKey(it.uid) }) {
                        messageList.add(message)
                    }
                }
                showMessage()
            }

            override fun onChildChanged(dataSnapshot: DataSnapshot, previousChildName: String?) {
                Log.d(TAG, "onChildChanged: ${dataSnapshot.key}")
                val newComment = dataSnapshot.getValue<Any>()
                Log.d(TAG, "onChildChanged: $newComment")
            }

            override fun onChildRemoved(dataSnapshot: DataSnapshot) {
                Log.d(TAG, "onChildRemoved:" + dataSnapshot.key!!)
            }

            override fun onChildMoved(dataSnapshot: DataSnapshot, previousChildName: String?) {
                Log.d(TAG, "onChildMoved:" + dataSnapshot.key!!)
            }

            override fun onCancelled(error: DatabaseError) {
                Toast.makeText(
                    this@ReadActivity, "Failed to load comments.",
                    Toast.LENGTH_SHORT
                ).show()
            }
        }

        messagesRef.addChildEventListener(childEventListener)

    }

    private fun showMessage() {
        messageTextView.text = decrypt(messageList[messageIndex].matter, squeamish)
    }

    private fun decrypt(cipher: String, squeamish: String): String {
        if (squeamish == "") {
            return cipher
        }
        val matterInBytes = cipher.toByteArray()
        val squeamishInBytes = squeamish.toByteArray()
        var matterInString = ""
        var s = 0
        for (byte in matterInBytes) {
            matterInString += byte.xor(squeamishInBytes[s]).toInt().toChar()
            s += 1
            if (s >= squeamishInBytes.size) {
                s = 0
            }
        }
        return matterInString
    }

}