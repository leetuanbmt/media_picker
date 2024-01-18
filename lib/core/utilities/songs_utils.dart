import 'package:flutter/services.dart';

import 'utilities.dart';

class SongRetriever {
  static const MethodChannel _channel = MethodChannel('song_retriever_channel');

  static Future<List<Map<String, String>>> getSongs() async {
    try {
      final List<dynamic> songs = await _channel.invokeMethod('getSongs');
      return songs
          .map((dynamic song) => Map<String, String>.from(song))
          .toList();
    } catch (e) {
      Logger.log('Error retrieving songs: $e');
      return [];
    }
  }
}
