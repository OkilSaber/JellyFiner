// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:jellyfiner/screens/config_select.dart';
import 'package:jellyfiner/screens/main_screen.dart';
import 'package:jellyfiner/screens/server_input.dart';
import 'package:jellyfiner/types/server_config.dart';
import 'package:jellyfiner/utils/configs_manager.dart';
import 'package:jellyfiner/utils/custom_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void loadConfigs() async {
    final List<ServerConfig> configs =
        await Future.wait(await ConfigsManager.getAllConfigs());
    if (configs.isEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ServerInput()),
      );
    } else {
      for (final config in configs) {
        print(config.isDefault);
        if (config.isDefault) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainScreen(
                config: config,
              ),
            ),
          );
          return;
        }
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ConfigSelect(
            configs: configs,
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    loadConfigs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: CustomColors.darkAccent,
        ),
      ),
    );
  }
}
