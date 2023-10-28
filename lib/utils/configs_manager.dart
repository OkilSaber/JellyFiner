import 'package:hive_flutter/hive_flutter.dart';
import 'package:jellyfiner/types/server_config.dart';

class ConfigsManager {
  static const String _boxName = 'serverConfig';

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ServerConfigAdapter());
    await Hive.openBox(_boxName);
  }

  static Box get box => Hive.box(_boxName);

  static Future<ServerConfig> getConfig(String key) async {
    return ConfigsManager.box.get(key);
  }

  static Future<List<Future<ServerConfig>>> getAllConfigs() async {
    final List<Future<ServerConfig>> configs = [];
    for (String key in ConfigsManager.box.keys) {
      configs.add(ConfigsManager.getConfig(key));
    }
    return configs;
  }

  static Future<void> addConfig(ServerConfig config) async {
    await ConfigsManager.box.put(config.configName, config);
  }

  static Future<void> deleteConfig(String key) async {
    await ConfigsManager.box.delete(key);
  }
}
