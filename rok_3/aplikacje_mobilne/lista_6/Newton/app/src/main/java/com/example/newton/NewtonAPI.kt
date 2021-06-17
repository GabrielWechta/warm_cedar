package com.example.newton

import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Path

interface NewtonAPI {
    @GET("{operation}/{expression}")
    fun calculate(
        @Path("operation") operation: String,
        @Path("expression") expression: String
    ): Call<NewtonDTO>
}