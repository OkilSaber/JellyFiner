import 'package:hive/hive.dart';

part 'server_config.g.dart';

@HiveType(typeId: 1)
class ServerConfig extends HiveObject {
  @HiveField(0)
  final String username;

  @HiveField(1)
  final String token;

  @HiveField(2)
  final String serverUrl;

  @HiveField(3)
  final String configName;

  @HiveField(4)
  final String isDefault;

  ServerConfig({
    required this.username,
    required this.token,
    required this.serverUrl,
    required this.configName,
    required this.isDefault,
  });
}
