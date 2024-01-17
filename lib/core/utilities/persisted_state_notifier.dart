import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'primitive_utils.dart';

const secureStorage = FlutterSecureStorage(
  aOptions: AndroidOptions(encryptedSharedPreferences: true),
  iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
);

const keyAppName = 'gotip';

const kKeyBoxName = '${keyAppName}_box_name';

const kNoEncryptionWarningShownKey = 'showedNoEncryptionWarning';

const kIsUsingEncryption = 'isUsingEncryption';

String getBoxKey(String boxName) => '${keyAppName}_box_$boxName';

abstract class PersistedStateNotifier<T> extends StateNotifier<T> {
  PersistedStateNotifier(
    super.state,
    this.cacheKey, {
    this.encrypted = false,
  }) {
    _load().then((_) => onInit());
  }

  // cache key for this state
  final String cacheKey;

// whether to use encrypted storage or not
  final bool encrypted;

  FutureOr<void> onInit() {}

  static late LazyBox _box;
  static late LazyBox _encryptedBox;

  static Future<String?> read(String key) async {
    final localStorage = await SharedPreferences.getInstance();

    try {
      await localStorage.setBool(kIsUsingEncryption, true);
      return await secureStorage.read(key: key);
    } catch (e) {
      await localStorage.setBool(kIsUsingEncryption, false);
      return localStorage.getString(key);
    }
  }

  static Future<void> write(String key, String value) async {
    final localStorage = await SharedPreferences.getInstance();

    try {
      await localStorage.setBool(kIsUsingEncryption, true);
      await secureStorage.write(key: key, value: value);
    } catch (e) {
      await localStorage.setBool(kIsUsingEncryption, false);
      await localStorage.setString(key, value);
    }
  }

  static Future<void> initializeBoxes({required String? path}) async {
    String? boxName = await read(kKeyBoxName);

    if (boxName == null) {
      boxName = '$keyAppName-${PrimitiveUtils.uuid.v4()}';
      await write(kKeyBoxName, boxName);
    }

    String? encryptionKey = await read(getBoxKey(boxName));

    if (encryptionKey == null) {
      encryptionKey = base64Url.encode(Hive.generateSecureKey());
      await write(getBoxKey(boxName), encryptionKey);
    }

    _encryptedBox = await Hive.openLazyBox(
      boxName,
      encryptionCipher: HiveAesCipher(base64Url.decode(encryptionKey)),
    );

    _box = await Hive.openLazyBox(
      '${keyAppName}_cache',
      path: path,
    );
  }

  LazyBox get box => encrypted ? _encryptedBox : _box;

  Future<void> _load() async {
    final json = await box.get(cacheKey);

    if (json != null) {
      state = await fromJson(castNestedJson(json));
    }
  }

  Map<String, dynamic> castNestedJson(Map map) {
    return Map.castFrom<dynamic, dynamic, String, dynamic>(
      map.map((key, value) {
        if (value is Map) {
          return MapEntry(
            key,
            castNestedJson(value),
          );
        } else if (value is Iterable) {
          return MapEntry(
            key,
            value.map((e) {
              if (e is Map) return castNestedJson(e);
              return e;
            }).toList(),
          );
        }
        return MapEntry(key, value);
      }),
    );
  }

  void save() async {
    await box.put(cacheKey, toJson());
  }

  FutureOr<T> fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson();

  @override
  set state(T value) {
    if (state == value) return;
    super.state = value;
    save();
  }
}

Future<bool> showPromptDialog({
  required BuildContext context,
  required String title,
  required String message,
  String okText = 'Ok',
  String? cancelText = 'Cancel',
}) async {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          if (cancelText != null)
            OutlinedButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(cancelText),
            ),
          FilledButton(
            child: Text(okText),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}
