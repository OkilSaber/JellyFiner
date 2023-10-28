import 'package:hive/hive.dart';

part 'server_config.g.dart';

@HiveType(typeId: 1)
class ServerConfig extends HiveObject {
  @HiveField(0)
  String username;

  @HiveField(1)
  String token;

  @HiveField(2)
  String serverUrl;

  @HiveField(3)
  String configName;

  @HiveField(4)
  bool isDefault;

  ServerConfig({
    required this.username,
    required this.token,
    required this.serverUrl,
    required this.configName,
    required this.isDefault,
  });

  @override
  String toString() {
    return 'ServerConfig{username: $username, token: $token, serverUrl: $serverUrl, configName: $configName, isDefault: $isDefault}';
  }
}
