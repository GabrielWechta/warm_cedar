package com.example.squeamishchat

import com.google.firebase.database.Exclude
import com.google.firebase.database.IgnoreExtraProperties

@IgnoreExtraProperties
data class Message(
    val matter: String = "",
    val whoRead: MutableMap<String, Boolean> = HashMap()
) {
    @Exclude
    fun toMap(): Map<String, Any?> {
        return mapOf(
            "matter" to matter,
            "whoRead" to whoRead
        )
    }
}