## Requirements

### Android

Required permissions: `INTERNET`, `READ_EXTERNAL_STORAGE`, `WRITE_EXTERNAL_STORAGE`, `ACCESS_MEDIA_LOCATION`.
If you don't need the `ACCESS_MEDIA_LOCATION` permission,

```xml
<uses-permission
  android:name="android.permission.ACCESS_MEDIA_LOCATION"
  tools:node="remove"
  />
```

### iOS

1. Platform version has to be at least _10.0_. Modify `ios/Podfile` and update accordingly.

```ruby
platform :ios, '10.0'
```

2. Add the following content to `info.plist`.

```
<key>NSAppTransportSecurity</key>
<dict>
	<key>NSAllowsArbitraryLoads</key>
	<true/>
</dict>
<key>NSPhotoLibraryUsageDescription</key>
<string>Replace with your permission description.</string>
```

## install

### Add to pubspec

```yaml
dependencies:
  media_picker: 0.0.1
```

## Screenshots

| ![1](https://github.com/TuanMinhVan/media_picker/blob/main/ima/screen.jpg?raw=true) | ![2](https://github.com/TuanMinhVan/media_picker/blob/main/ima/path_list.jpg?raw=true) | ![3](https://github.com/TuanMinhVan/media_picker/blob/main/ima/review.jpg?raw=true) |
| ----------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- |

## Usage

```dart
import 'package:media_picker/media_picker.dart';
```

```dart
 MediaPicker.assetPicker(
      context,
      isMulti: true,
      type: RequestType.all,
      isReview: true,

  );
```

| Parameter          | Type                 | Description                                                      | Default                           |
| ------------------ | -------------------- | ---------------------------------------------------------------- | --------------------------------- |
| **isMulti**        | `bool`               | Multiple select mode                                             | true                              |
| **type**           | `RequestType`        | Request type for picker                                          | RequestType.common                |
| **limit**          | `int`                | Maximum asset that the picker can pick                           | 10                                |
| **isReview**       | `bool`               | Review after select                                              | true                              |
| **filterOptions**  | `FilterOptionGroup?` | Allow users to customize assets filter options                   | null                              |
| **leadingBuilder** | `WidgetBuilder?`     | The widget builder for the special item                          | null                              |
| **routeDuration**  | `Duration`           | The duration which the picker use to build page route transition | const Duration(milliseconds: 300) |
| **mulCallback**    | `MulCallback?`       | Return list item in select                                       | null                              |
| **singleCallback** | `SingleCallback?`    | Return item in select                                            | null                              |
