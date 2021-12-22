# gmo_media_picker

Flutter plugin to get pictures, videos and audios.
It allows you to select one or more images from gallery or camera, without needing to switch provider.
It also allows you to select both images, videos and audios if you wish

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
  gmo_media_picker: 0.0.1
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
      mulCallback: (List<AssetEntity> assets){
        //return selected items
      }
  );
```

| Parameter      | Type                 | Description                                                      | Default                             |
| -------------- | -------------------- | ---------------------------------------------------------------- | ----------------------------------- |
| isMulti        | `bool`               | Multiple select mode                                             | `true`                              |
| type           | `RequestType`        | Request type for picker                                          | `RequestType.common`                |
| limit          | `int`                | Maximum asset that the picker can pick                           | `10`                                |
| isReview       | `bool`               | Review before select                                             | `true`                              |
| filterOptions  | `FilterOptionGroup?` | Allow users to customize assets filter options                   | `null`                              |
| leadingBuilder | `WidgetBuilder?`     | The widget builder for the special item                          | `null`                              |
| routeDuration  | `Duration`           | The duration which the picker use to build page route transition | `const Duration(milliseconds: 300)` |
| mulCallback    | `MulCallback?`       | Return list item in select                                       | `null`                              |
| singleCallback | `SingleCallback?`    | Return item in select                                            | `null`                              |

### Example

```dart

import 'package:gmo_media_picker/media_picker.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isReview = false;
  bool isMulti = false;
  AssetEntity? _assetEntity;
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title:const  Text('Media picker example'),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (_assetEntity != null)
                Image(
                  image: AssetEntityImageProvider(_assetEntity!),
                  width: 100,
                ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Review"),
                  Switch(
                    value: isReview,
                    onChanged: (newValue) {
                      setState(() => isReview = newValue);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Multi Mode"),
                  Switch(
                    value: isMulti,
                    onChanged: (newValue) {
                      setState(() => isMulti = newValue);
                    },
                  ),
                ],
              ),
              MaterialButton(
                color: themeData.primaryColor,
                child: const Text(
                  'All',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  picker(RequestType.all);
                },
              ),
              MaterialButton(
                color: themeData.primaryColor,
                child: const Text(
                  'Images and videos',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  picker(RequestType.common);
                },
              ),
              MaterialButton(
                color: themeData.primaryColor,
                child: const Text(
                  'Image picker',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  picker(RequestType.image);
                },
              ),
              MaterialButton(
                color: themeData.primaryColor,
                child: const Text(
                  'Video picker',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  picker(RequestType.video);
                },
              ),
              MaterialButton(
                color: themeData.primaryColor,
                child: const Text(
                  'Audio picker',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  picker(RequestType.audio);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void picker(RequestType type) {
    MediaPicker.picker(
      context,
      isMulti: isMulti,
      type: type,
      isReview: isReview,
      mulCallback: (List<AssetEntity> assets) {
        //return list if isMulti true
      },
      singleCallback: (AssetEntity asset) {
        //return single item if  isMulti false
      },
    );
  }
}

```
