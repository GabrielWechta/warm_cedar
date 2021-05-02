package com.example.gallery

import android.os.Parcel
import android.os.Parcelable

class Picture(imagePath: String?, imageName: String?) : Parcelable {
    var path: String? = imagePath
    var name: String? = imageName
    var rating: Float? = -1.0F

    constructor(parcel: Parcel) : this(
        TODO("imagePath"),
        TODO("imageName")
    ) {
        path = parcel.readString()
        name = parcel.readString()
        rating = parcel.readValue(Float::class.java.classLoader) as? Float
    }

    override fun writeToParcel(parcel: Parcel, flags: Int) {
        parcel.writeString(path)
        parcel.writeString(name)
        parcel.writeValue(rating)
    }

    override fun describeContents(): Int {
        return 0
    }

    companion object CREATOR : Parcelable.Creator<Picture> {
        override fun createFromParcel(parcel: Parcel): Picture {
            return Picture(parcel)
        }

        override fun newArray(size: Int): Array<Picture?> {
            return arrayOfNulls(size)
        }
    }
}