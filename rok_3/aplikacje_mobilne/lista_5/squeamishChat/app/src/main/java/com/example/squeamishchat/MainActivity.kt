package com.example.squeamishchat

import android.app.Activity
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.widget.Button
import android.widget.EditText
import android.widget.Toast
import com.firebase.ui.auth.AuthUI
import com.firebase.ui.auth.IdpResponse
import com.google.android.material.floatingactionbutton.FloatingActionButton
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.FirebaseUser
import com.google.firebase.database.*
import com.google.firebase.database.ktx.database
import com.google.firebase.ktx.Firebase
import kotlin.experimental.xor

const val TAG = "dup"
const val RC_SIGN_IN = 1505

class MainActivity : AppCompatActivity() {
    private lateinit var databaseReference: DatabaseReference
    private lateinit var currentUser: FirebaseUser
    private lateinit var messageFab: FloatingActionButton

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        signIn()
    }

    private fun initializeGUI() {
        val button = findViewById<Button>(R.id.postButton)
        button.setOnClickListener {
            writeNewMessage(
                findViewById<EditText>(R.id.messageEditText).text.toString(),
                currentUser.uid
            )
        }
        databaseReference = Firebase.database.reference

        messageFab = findViewById(R.id.messageFloatingActionButton)
        messageFab.setOnClickListener {
            val intent = Intent(this, ReadActivity::class.java)
            intent.putExtra(
                "squeamish",
                findViewById<EditText>(R.id.squeamishEditText).text.toString()
            )
            startActivity(intent)
        }
    }

    private fun signIn() {
        val providers = arrayListOf(
            AuthUI.IdpConfig.EmailBuilder().build(),
        )

        startActivityForResult(
            AuthUI.getInstance()
                .createSignInIntentBuilder()
                .setAvailableProviders(providers)
                .build(),
            RC_SIGN_IN
        )

    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if (requestCode == RC_SIGN_IN) {
            val response = IdpResponse.fromResultIntent(data)

            if (resultCode == Activity.RESULT_OK) {
                currentUser = FirebaseAuth.getInstance().currentUser!!
                initializeGUI()
            } else {
                Toast.makeText(this, "mistakes have been made during signing", Toast.LENGTH_SHORT)
                    .show()
            }
        }
    }

    private fun writeNewMessage(matter: String, whoSend: String) {
        val squeamish = findViewById<EditText>(R.id.squeamishEditText).text.toString()
        val encryptedMatter = encrypt(matter, squeamish)
        val key = databaseReference.child("messages").push().key
        if (key == null) {
            Log.w(TAG, "Couldn't get push key for message")
            return
        }

        val map = mutableMapOf<String, Boolean>()
        map[whoSend] = true

        val message = Message(encryptedMatter, map)
        val messageValue = message.toMap()
        val childUpdates = hashMapOf<String, Any>(
            "messages/$key" to messageValue,
        )

        databaseReference.updateChildren(childUpdates)
    }

    private fun encrypt(matter: String, squeamish: String): String {
        if (squeamish == "") {
            return matter
        }
        val matterInBytes = matter.toByteArray()
        val squeamishInBytes = squeamish.toByteArray()
        var cipherInString = ""
        var s = 0
        for (byte in matterInBytes) {
            cipherInString += byte.xor(squeamishInBytes[s]).toInt().toChar()
            s += 1
            if (s >= squeamishInBytes.size) {
                s = 0
            }
        }

        return cipherInString
    }
}