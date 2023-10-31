import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gmo_media_picker/media_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: const Color(0xff47C3BE),
          colorScheme: const ColorScheme.light(
            primary: Color(0xff47C3BE),
            surface: Color(0xffF5F8FA),
          ),
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.white,
          dividerColor: const Color(0x1F000000),
          appBarTheme: const AppBarTheme(
            scrolledUnderElevation: 0,
            backgroundColor: Color(0xff47C3BE),
            centerTitle: true,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.dark,
            ),
            iconTheme: IconThemeData(color: Colors.white),
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.white,
            ),
          )),
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
    AssetPicker.pickAssets(context);
  }
}
