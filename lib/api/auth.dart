import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:http/http.dart' as http;
import 'package:jellyfiner/types/server_config.dart';
import 'package:jellyfiner/utils/configs_manager.dart';
import 'package:jellyfiner/utils/constant.dart';
import 'package:uuid/uuid.dart';

class AuthApi {
  static Future<String> login(
    String username,
    String password,
    String serverUrl,
    String serverName,
    bool isDefault,
  ) async {
    await Future.delayed(const Duration(seconds: 2));
    if (serverUrl.endsWith("/")) {
      serverUrl = serverUrl.substring(0, serverUrl.length - 1);
    }

    try {
      String uuid = const Uuid().v1();
      final device = (await DeviceInfoPlugin().deviceInfo).data["product"];
      http.Response response = await http.post(
        Uri.parse("$serverUrl/Users/authenticatebyname"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':
              'MediaBrowser Client="${Constants.appName}", Version=${Constants.version}, DeviceId="$uuid", Device="$device"',
        },
        body: jsonEncode(
          <String, String>{
            "Username": username,
            "Pw": password,
          },
        ),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        final String token = data["AccessToken"];
        final String serverId = data["User"]["ServerId"];
        final String userId = data["User"]["Id"];
        final ServerConfig serverConfig = ServerConfig(
          configName: serverName,
          serverUrl: serverUrl,
          token: token,
          username: username,
          isDefault: isDefault,
          deviceId: uuid,
          userId: userId,
          serverId: serverId,
        );
        if (isDefault) {
          ConfigsManager.resetDefaultConfig();
        }
        ConfigsManager.addConfig(serverConfig);
        return "";
      } else {
        return response.body;
      }
    } catch (e) {
      return e.toString();
    }
  }
}
