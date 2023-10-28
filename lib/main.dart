import 'package:flutter/material.dart';
import 'package:jellyfiner/screens/splash_screen.dart';
import 'package:jellyfiner/utils/configs_manager.dart';

void main() async {
  await ConfigsManager.init();
  runApp(const Jellyfiner());
}

class Jellyfiner extends StatelessWidget {
  const Jellyfiner({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JellyFiner',
      theme: MediaQuery.of(context).platformBrightness == Brightness.dark
          ? ThemeData.dark()
          : ThemeData.light(),
      home: const SplashScreen(),
    );
  }
}
