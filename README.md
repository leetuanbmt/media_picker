## Requirements

### iOS

- Minimum iOS Deployment Target: 10.0

### Android

- minSdkVersion: 21
- targetSdkVersion: 29

## install

### Add to pubspec

```yaml
dependencies:
  media_picker: 0.0.1
```

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

## Screenshots


| ![1](https://github.com/TuanMinhVan/media_picker/blob/main/ima/screen.jpg?raw=true)   | ![2](https://github.com/TuanMinhVan/media_picker/blob/main/ima/path_list.jpg?raw=true)   | 
