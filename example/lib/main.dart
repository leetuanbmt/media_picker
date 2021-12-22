import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gmo_camera_picker/gmo_camera_picker.dart';
import 'package:media_picker/media_picker.dart';

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isReview = false;
  bool isMulti = false;
  File? _file;
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (_file != null) Image.file(_file!, height: 50),
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
              MaterialButton(
                color: themeData.primaryColor,
                child: const Text(
                  'Camera picker',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  GmoCameraPicker.pickFromCamera(context).then((value) {
                    if (value != null) {
                      setState(() => _file = value);
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void picker(RequestType type) {
    MediaPicker.picker(context,
        isMulti: isMulti,
        type: type,
        isReview: isReview,
        mulCallback: (List<AssetEntity> assets) {});
  }
}
