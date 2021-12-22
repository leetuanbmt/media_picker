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

| ![1](https://pic.alexv525.com/2021-07-05-picker_1.jpg) | ![2](https://pic.alexv525.com/2021-07-05-picker_2.jpg)
