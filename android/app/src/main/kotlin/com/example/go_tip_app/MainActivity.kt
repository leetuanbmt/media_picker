package com.example.go_tip_app

import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.android.FlutterActivity


class MainActivity: FlutterFragmentActivity() {
    private val songRetrieverChannel = "song_retriever_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, songRetrieverChannel)
            .setMethodCallHandler { call, result ->
                if (call.method == "getSongs") {
                    val songRetriever = SongRetriever(this)
                    val songs = songRetriever.getSongs()
                    result.success(songs)
                } else {
                    result.notImplemented()
                }
            }
    }

}
