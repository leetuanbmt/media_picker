import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PersistedChangeNotifier extends ChangeNotifier {
  final SharedPreferences localStorage;
  PersistedChangeNotifier({required this.localStorage}) {
    _initialized();
  }

  void _initialized() async {
    final persistedMap = (await toMap())
        .entries
        .toList()
        .fold<Map<String, dynamic>>({}, (acc, entry) {
      if (entry.value != null) {
        if (entry.value is bool) {
          acc[entry.key] = localStorage.getBool(entry.key);
        } else if (entry.value is int) {
          acc[entry.key] = localStorage.getInt(entry.key);
        } else if (entry.value is double) {
          acc[entry.key] = localStorage.getDouble(entry.key);
        } else if (entry.value is String) {
          acc[entry.key] = localStorage.getString(entry.key);
        }
      } else {
        acc[entry.key] = localStorage.get(entry.key);
      }
      return acc;
    });
    await loadFromLocal(persistedMap);
    notifyListeners();
  }

  FutureOr<void> loadFromLocal(Map<String, dynamic> map);

  FutureOr<Map<String, dynamic>> toMap();

  Future<void> updatePersistence({bool clearNullEntries = false}) async {
    for (final entry in (await toMap()).entries) {
      if (entry.value is bool) {
        await localStorage.setBool(entry.key, entry.value);
      } else if (entry.value is int) {
        await localStorage.setInt(entry.key, entry.value);
      } else if (entry.value is double) {
        await localStorage.setDouble(entry.key, entry.value);
      } else if (entry.value is String) {
        await localStorage.setString(entry.key, entry.value);
      } else if (entry.value == null && clearNullEntries) {
        localStorage.remove(entry.key);
      }
    }
  }
}
