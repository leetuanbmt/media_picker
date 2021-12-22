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


| ![1](https://github.com/TuanMinhVan/media_picker/blob/main/ima/screen.jpg?raw=true)   | ![2](https://github.com/TuanMinhVan/media_picker/blob/main/ima/path_list.jpg?raw=true)   | ![3](https://pic.alexv525.com/2021-07-05-picker_3.jpg)   |
| -------------------------------------------------------- | -------------------------------------------------------- | -------------------------------------------------------- |
| ![4](https://pic.alexv525.com/2021-07-05-picker_4.jpg)   | ![5](https://pic.alexv525.com/2021-07-05-picker_5.jpg)   | ![6](https://pic.alexv525.com/2021-07-05-picker_6.jpg)   |
| ![7](https://pic.alexv525.com/2021-07-06-picker_7.jpg)   | ![8](https://pic.alexv525.com/2021-07-05-picker_8.jpg)   | ![9](https://pic.alexv525.com/2021-07-05-picker_9-1.jpg) |
| ![10](https://pic.alexv525.com/2021-07-05-picker_10.png) | ![10](https://pic.alexv525.com/2021-07-05-picker_11.png) | ![12](https://pic.alexv525.com/2021-07-05-picker_12.png) |
