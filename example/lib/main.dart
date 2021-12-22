import 'package:flutter/material.dart';
import 'package:gmo_media_picker/media_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

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
        title: const Text('Media picker example'),
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
        if (type == RequestType.common) {
          setState(() => _assetEntity = assets.first);
        }
      },
      singleCallback: (AssetEntity asset) {
        if (type == RequestType.common) {
          setState(() => _assetEntity = asset);
        }
      },
    );
  }
}
