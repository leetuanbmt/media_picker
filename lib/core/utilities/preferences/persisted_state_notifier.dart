part of 'preferences.dart';

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

  static late SharedPreferences localStorage;

  static Future<String?> read(String key) async {
    try {
      return await secureStorage.read(key: key);
    } catch (e) {
      return localStorage.getString(key);
    }
  }

  static Future<void> write(String key, String value) async {
    try {
      await secureStorage.write(key: key, value: value);
    } catch (e) {
      await localStorage.setString(key, value);
    }
  }

  static Future<void> initializeBoxes({required String? path}) async {
    // initialize shared preferences
    localStorage = await SharedPreferences.getInstance();

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
