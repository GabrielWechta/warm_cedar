package com.example.gallery.fragments

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.provider.MediaStore
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ProgressBar
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentManager
import androidx.fragment.app.setFragmentResultListener
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.gallery.Picture
import com.example.gallery.PictureAdapter
import com.example.gallery.R

private const val fullPictureRequestCode = 1

class MainFragment : Fragment() {
    private lateinit var pictureRecycler: RecyclerView
    private lateinit var progressBar: ProgressBar
    private lateinit var allPictures: ArrayList<Picture>
    private lateinit var pictureAdapter: PictureAdapter

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val view = inflater.inflate(R.layout.fragment_main, container, false)

        pictureRecycler = view.findViewById(R.id.image_recycler)
        progressBar = view.findViewById(R.id.recycler_progress)

        pictureRecycler.layoutManager = GridLayoutManager(activity, 3)
        pictureRecycler.setHasFixedSize(true)

        allPictures = ArrayList()

        if (allPictures.isEmpty()) {
            progressBar.visibility = View.VISIBLE

            allPictures = getAllPictures()
            val manager: FragmentManager = parentFragmentManager
            pictureAdapter = PictureAdapter(activity as Context, allPictures, this, manager)
            pictureRecycler.adapter = pictureAdapter

            progressBar.visibility = View.GONE
        }

        setFragmentResultListener("requestKey") { requestKey, bundle ->
            val pictureRating = bundle.getFloat("ratingKey")
            val pictureName = bundle.getString("nameKey")
            getPictureByName(allPictures, pictureName)?.rating = pictureRating
            allPictures.sortWith { lhs, rhs ->
                if (lhs.rating!! > rhs.rating!!) -1 else 0
            }

            pictureRecycler.adapter?.notifyDataSetChanged()
        }

        return view
    }

    private fun getAllPictures(): ArrayList<Picture> {
        val allPictures = ArrayList<Picture>()
        val allPicturesUri = MediaStore.Images.Media.EXTERNAL_CONTENT_URI
        val projection =
            arrayOf(MediaStore.Images.ImageColumns.DATA, MediaStore.Images.Media.DISPLAY_NAME)
        val cursor =
            activity?.contentResolver?.query(allPicturesUri, projection, null, null, null)

        try {
            cursor!!.moveToFirst()
            do {
                val imagePath =
                    cursor.getString(cursor.getColumnIndexOrThrow(MediaStore.Images.Media.DATA))
                val imageName =
                    cursor.getString(cursor.getColumnIndexOrThrow(MediaStore.Images.Media.DISPLAY_NAME))

                val picture = Picture(imagePath, imageName)
                allPictures.add(picture)

            } while (cursor.moveToNext())

            cursor.close()

        } catch (e: Exception) {
            e.printStackTrace()
        }
        return allPictures
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, intentData: Intent?) {
        if (requestCode == fullPictureRequestCode && resultCode == Activity.RESULT_OK) {
            intentData?.let { data ->
                val rating = data.getStringExtra("rating")
                val name = data.getStringExtra("name")

                getPictureByName(allPictures, name)?.rating = rating?.toFloat()
                Toast.makeText(
                    activity,
                    getPictureByName(allPictures, name)?.rating.toString(),
                    Toast.LENGTH_SHORT
                ).show()
                allPictures.sortWith { lhs, rhs ->
                    if (lhs.rating!! > rhs.rating!!) -1 else 0
                }

                pictureRecycler.adapter?.notifyDataSetChanged()
            }
        }
    }

    private fun getPictureByName(allPictures: ArrayList<Picture>, pictureName: String?): Picture? {
        for (picture in allPictures) {
            if (picture.name == pictureName) {
                return picture
            }
        }
        return null
    }

    override fun onSaveInstanceState(outState: Bundle) {
        super.onSaveInstanceState(outState)
        outState.run {
            putParcelableArrayList("allPictures", java.util.ArrayList(allPictures))
        }
    }

    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)

        val restoredAllPictures = savedInstanceState?.getParcelableArrayList<Picture>("allPictures")
        if (restoredAllPictures != null) {
            allPictures = restoredAllPictures
            pictureAdapter.picturesList = restoredAllPictures
        }
    }
}