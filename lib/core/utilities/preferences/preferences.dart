library preferences;

import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config.dart';
import '../primitive_utils.dart';

part 'persisted_change_notifier.dart';
part 'persisted_state_notifier.dart';

const secureStorage = FlutterSecureStorage(
  aOptions: AndroidOptions(encryptedSharedPreferences: true),
  iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
);

const keyAppName = 'gotip';

const kKeyBoxName = '${keyAppName}_box_name';

String getBoxKey(String boxName) => '${keyAppName}_box_$boxName';
