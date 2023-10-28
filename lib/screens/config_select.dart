import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jellyfiner/screens/edit_config.dart';
import 'package:jellyfiner/screens/server_input.dart';
import 'package:jellyfiner/screens/splash_screen.dart';
import 'package:jellyfiner/types/server_config.dart';
import 'package:jellyfiner/utils/custom_colors.dart';

class ConfigSelect extends StatefulWidget {
  final List<ServerConfig> configs;

  const ConfigSelect({Key? key, required this.configs}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ConfigSelectState();
}

class _ConfigSelectState extends State<ConfigSelect> {
  late List<ServerConfig> configs;

  @override
  void initState() {
    configs = widget.configs;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a config'),
        elevation: 0,
        backgroundColor: CustomColors.darkPrimary,
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.add),
            onPressed: () {
              Navigator.of(context)
                  .push(
                MaterialPageRoute(
                  builder: (context) => const ServerInput(
                    pullConfigsAtPop: true,
                  ),
                ),
              )
                  .then(
                (newConfigs) {
                  if (newConfigs.isEmpty) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => const SplashScreen()),
                    );
                  } else {
                    setState(() {
                      configs = newConfigs;
                    });
                  }
                },
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: configs.length,
        itemBuilder: (context, index) {
          ServerConfig config = configs[index];
          return ListTile(
            title: Text(config.configName),
            subtitle: Text(config.serverUrl),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const SplashScreen(),
                ),
              );
            },
            trailing: IconButton(
              icon: const Icon(CupertinoIcons.pen),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (context) => EditConfig(config: config)))
                    .then(
                  (newConfigs) {
                    if (newConfigs.isEmpty) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const SplashScreen(),
                        ),
                      );
                    } else {
                      setState(() {
                        configs = newConfigs;
                      });
                    }
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
