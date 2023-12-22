import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:http/http.dart' as http;
import 'package:jellyfiner/types/server_config.dart';
import 'package:jellyfiner/utils/constant.dart';
import 'package:jellyfiner/structs/item.dart';

class ItemApi {
  static Future<List<Item>> getItems(ServerConfig config) async {
    try {
      final device = (await DeviceInfoPlugin().deviceInfo).data["product"];
      http.Response response = await http.get(
        Uri.parse("${config.serverUrl}/Users/${config.userId}/Items"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':
              'MediaBrowser Token="${config.token}", Client="${Constants.appName}", Version"=${Constants.version}", Device="$device", DeviceId="${config.deviceId}"',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        final List<Item> items = [];
        for (var item in data["Items"]) {
          items.add(Item.fromJson(item));
        }
        return items;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  static Future<List<Item>> getResumeItems(ServerConfig config) async {
    try {
      final device = (await DeviceInfoPlugin().deviceInfo).data["product"];
      http.Response response = await http.get(
        Uri.parse("${config.serverUrl}/Users/${config.userId}/Items/Resume"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':
              'MediaBrowser Token="${config.token}", Client="${Constants.appName}", Version"=${Constants.version}", Device="$device", DeviceId="${config.deviceId}"',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        final List<Item> items = [];
        for (var item in data["Items"]) {
          items.add(Item.fromJson(item));
        }
        return items;
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> getCollectionItems(
      ServerConfig config, Item collection) async {
    try {
      final device = (await DeviceInfoPlugin().deviceInfo).data["product"];
      http.Response response = await http.get(
        Uri.parse(
            "${config.serverUrl}/Users/${config.userId}/Items/${collection.id}"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':
              'MediaBrowser Token="${config.token}", Client="${Constants.appName}", Version"=${Constants.version}", Device="$device", DeviceId="${config.deviceId}"',
        },
      );
    } catch (e) {
      return;
    }
  }
}
