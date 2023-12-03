import 'package:device_info_plus/device_info_plus.dart';
import 'package:http/http.dart' as http;
import 'package:jellyfiner/types/server_config.dart';
import 'package:jellyfiner/utils/constant.dart';

class ItemApi {
  static Future<void> getItems(ServerConfig config) async {
    try {
      final device = (await DeviceInfoPlugin().deviceInfo).data["product"];
      http.Response response = await http.get(
        Uri.parse(
            "${config.serverUrl}/Items?userId=${config.userId}&enableTotalRecordCount=true&enableImages=true"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':
              // 'MediaBrowser Client="${Constants.appName}", Version=${Constants.version}, Device="$device", Token="${config.token}, DeviceId="${config.deviceId}""',
              'MediaBrowser Token="${config.token}", Client="${Constants.appName}", Version"=${Constants.version}", Device="$device", DeviceId="${config.deviceId}"',
        },
      );
      print(response.request?.headers.toString());
      print(response.statusCode);
      print(response.body);
      // if (response.statusCode == 200) {
      //   Map<String, dynamic> data = jsonDecode(response.body);
      //   final String token = data["AccessToken"];
      //   final ServerConfig serverConfig = ServerConfig(
      //     configName: serverName,
      //     serverUrl: serverUrl,
      //     token: token,
      //     username: username,
      //     isDefault: isDefault,
      //   );
      //   if (isDefault) {
      //     ConfigsManager.resetDefaultConfig();
      //   }
      //   ConfigsManager.addConfig(serverConfig);
      //   return "";
      // } else {
      //   return response.body;
      // }
    } catch (e) {
      return;
      // return e.toString();
    }
  }
}
