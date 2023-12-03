import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jellyfiner/utils/configs_manager.dart';

class SettingsTab extends StatefulWidget {
  final Function onClear;
  const SettingsTab({super.key, required this.onClear});

  @override
  State<StatefulWidget> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            ConfigsManager.deleteAllConfigs().then(
              (value) => {
                widget.onClear(),
              },
            );
          },
          child: const Text("Clear"),
        ),
      ),
    );
  }
}
