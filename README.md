# GoTip APP

#### Run flutter version generate class

```
flutter pub run build_runner build --delete-conflicting-outputs
```

### Generate Locates

```
flutter pub run easy_localization:generate --source-dir ./assets/locales -f keys -o locale_keys.g.dart
```

### Add flutter_localizations

```
flutter pub add flutter_localizations --sdk=flutter

flutter gen-l10
```
