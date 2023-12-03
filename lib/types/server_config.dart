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

  @HiveField(5)
  String deviceId;

  @HiveField(6)
  String userId;

  @HiveField(7)
  String serverId;

  ServerConfig({
    required this.username,
    required this.token,
    required this.serverUrl,
    required this.configName,
    required this.isDefault,
    required this.deviceId,
    required this.userId,
    required this.serverId,
  });

  @override
  String toString() {
    return 'ServerConfig{username: $username, token: $token, serverUrl: $serverUrl, configName: $configName, isDefault: $isDefault}, deviceID: $deviceId, userId: $userId, serverId: $serverId';
  }
}
