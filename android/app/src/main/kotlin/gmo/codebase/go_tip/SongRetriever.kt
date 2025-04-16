
package gmo.codebase.go_tip

import android.content.ContentResolver
import android.content.Context
import android.database.Cursor
import android.provider.MediaStore

class SongRetriever(private val context: Context) {
    fun getSongs(): List<Map<String, String>> {
        val contentResolver: ContentResolver = context.contentResolver
        val songs: MutableList<Map<String, String>> = mutableListOf()

        val selection = MediaStore.Audio.Media.IS_MUSIC + "!= 0"
        val projection = arrayOf(
            MediaStore.Audio.Media._ID,
            MediaStore.Audio.Media.TITLE,
            MediaStore.Audio.Media.ARTIST,
            MediaStore.Audio.Media.ALBUM
        )
        val sortOrder = MediaStore.Audio.Media.TITLE + " ASC"

        val cursor: Cursor? = contentResolver.query(
            MediaStore.Audio.Media.EXTERNAL_CONTENT_URI,
            projection,
            selection,
            null,
            sortOrder
        )

        cursor?.use {
            val idColumn = it.getColumnIndexOrThrow(MediaStore.Audio.Media._ID)
            val titleColumn = it.getColumnIndexOrThrow(MediaStore.Audio.Media.TITLE)
            val artistColumn = it.getColumnIndexOrThrow(MediaStore.Audio.Media.ARTIST)
            val albumColumn = it.getColumnIndexOrThrow(MediaStore.Audio.Media.ALBUM)

            while (it.moveToNext()) {
                val songId = it.getLong(idColumn)
                val title = it.getString(titleColumn)
                val artist = it.getString(artistColumn)
                val album = it.getString(albumColumn)

                val songMap: MutableMap<String, String> = mutableMapOf()
                songMap["id"] = songId.toString()
                songMap["title"] = title
                songMap["artist"] = artist
                songMap["album"] = album

                songs.add(songMap)
            }
        }

        return songs
    }
}