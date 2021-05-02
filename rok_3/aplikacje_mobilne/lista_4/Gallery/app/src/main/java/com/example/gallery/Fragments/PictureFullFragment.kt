package com.example.gallery.fragments

import android.app.Activity
import android.content.Intent
import android.content.res.Configuration
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.*
import androidx.core.os.bundleOf
import androidx.fragment.app.setFragmentResult
import com.bumptech.glide.Glide
import com.bumptech.glide.request.RequestOptions
import com.example.gallery.R

class PictureFullFragment : Fragment() {
    private lateinit var ratingBar: RatingBar
    private lateinit var rateButton: Button
    private var ratingValue = -1.0F
    private var pictureName: String? = null
    private var picturePath: String? = null

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val view = inflater.inflate(R.layout.fragment_picture_full, container, false)
        return view
    }

    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)
        if (activity?.intent != null) {

            picturePath = requireActivity().intent.getStringExtra("path")
            pictureName = requireActivity().intent.getStringExtra("name")
            if (resources.configuration.orientation == Configuration.ORIENTATION_PORTRAIT) {
                ratingValue = requireActivity().intent.getStringExtra("rating")?.toFloat()!!
                requireView().findViewById<TextView>(R.id.textView).text = pictureName
                requireView().findViewById<TextView>(R.id.textView2).text = picturePath
            } else {
                ratingValue = 0.0F
            }
            Glide.with(this).load(picturePath).apply(RequestOptions().centerCrop())
                .into(requireView().findViewById(R.id.picture_view))

            ratingBar = requireView().findViewById(R.id.rating_bar)
            ratingBar.rating = ratingValue

            ratingBar.setOnRatingBarChangeListener { _, p1, _ ->
                ratingValue = p1
            }

            rateButton = requireView().findViewById(R.id.rate_button)
            rateButton.setOnClickListener {
                rate()
            }
        }
    }

    private fun rate() {
        val resultIntent = Intent()

        if (ratingValue != -1.0F) {
            if (resources.configuration.orientation == Configuration.ORIENTATION_PORTRAIT) {
                resultIntent.putExtra("rating", ratingValue.toString())
                resultIntent.putExtra("name", pictureName.toString())
                activity?.setResult(Activity.RESULT_OK, resultIntent)
                activity?.finish()
            } else {
                setFragmentResult(
                    "requestKey",
                    bundleOf("nameKey" to pictureName, "ratingKey" to ratingValue)
                )
            }
        }
    }

    fun display(name: String, path: String, rating: Float) {
        pictureName = name
        ratingValue = rating

        Glide.with(this).load(path)
            .into(requireActivity().findViewById(R.id.picture_view))

        ratingBar = requireView().findViewById(R.id.rating_bar)
        ratingBar.rating = rating
    }
}