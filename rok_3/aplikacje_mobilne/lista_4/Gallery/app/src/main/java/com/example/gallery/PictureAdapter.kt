package com.example.gallery

import android.content.Context
import android.content.Intent
import android.content.res.Configuration
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import androidx.fragment.app.FragmentManager
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.bumptech.glide.request.RequestOptions
import com.example.gallery.Activities.PictureFullActivity
import com.example.gallery.Fragments.MainFragment
import com.example.gallery.Fragments.PictureFullFragment

class PictureAdapter(
    private var context: Context,
    private var picturesList: ArrayList<Picture>,
    private var fragment: MainFragment,
    private var manager: FragmentManager
) :
    RecyclerView.Adapter<PictureAdapter.PictureViewHolder>() {

    private val fullPictureRequestCode = 1

    class PictureViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        var picture: ImageView? = null

        init {
            picture = itemView.findViewById(R.id.row_image)
        }
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): PictureViewHolder {
        val inflater = LayoutInflater.from(parent.context)
        val view = inflater.inflate(R.layout.row_custom_recycler_item, parent, false)
        return PictureViewHolder(view)
    }

    override fun onBindViewHolder(holder: PictureViewHolder, position: Int) {
        val currentPicture = picturesList[position]
        Glide.with(context).load(currentPicture.path).apply(RequestOptions().centerCrop())
            .into(holder.picture!!)

        holder.picture?.setOnClickListener {
            if (context.resources.configuration.orientation == Configuration.ORIENTATION_PORTRAIT) {
                val intent = Intent(context, PictureFullActivity::class.java)
                intent.putExtra("path", currentPicture.path)
                intent.putExtra("name", currentPicture.name)
                intent.putExtra("rating", currentPicture.rating.toString())

                fragment.startActivityForResult(intent, fullPictureRequestCode)
            } else {
                val frag = manager.findFragmentById(R.id.picture_full_fragment) as PictureFullFragment
                frag.display(currentPicture.name!!, currentPicture.path!!, currentPicture.rating!!)
            }
        }
    }

    override fun getItemCount(): Int {
        return picturesList.size
    }
}