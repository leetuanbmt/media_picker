import 'package:flutter/material.dart';
import 'package:media_picker/media_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Media picker example',
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      themeMode: ThemeMode.system,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isReview = false;
  bool isMulti = false;
  @override
  Widget build(BuildContext context) {
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
              ElevatedButton(
                child: const Text('All'),
                onPressed: () {
                  pickAssets(RequestType.all);
                },
              ),
              ElevatedButton(
                child: const Text('Images and videos'),
                onPressed: () {
                  pickAssets(RequestType.common);
                },
              ),
              ElevatedButton(
                child: const Text('Image picker'),
                onPressed: () {
                  pickAssets(RequestType.image);
                },
              ),
              ElevatedButton(
                child: const Text('Video picker'),
                onPressed: () {
                  pickAssets(RequestType.video);
                },
              ),
              ElevatedButton(
                child: const Text('Audio picker'),
                onPressed: () {
                  pickAssets(RequestType.audio);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void pickAssets(RequestType type) {
    AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        requestType: type,
        maxAssets: isMulti ? 10 : 1,
        specialPickerType:
            isReview ? SpecialPickerType.review : SpecialPickerType.none,
      ),
    );
  }
}
