import "package:jellyfiner/types/server_config.dart";

class Item {
  final String name;
  final String id;
  final String seriesName;
  final double playbackPourcentage;
  final bool isFolder;
  final String type;
  final bool isPlayed;
  final bool isFavorite;

  Item({
    required this.name,
    required this.seriesName,
    required this.playbackPourcentage,
    required this.id,
    required this.isFolder,
    required this.type,
    required this.isPlayed,
    required this.isFavorite,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['Name'],
      seriesName: json['SeriesName'] ?? "",
      playbackPourcentage: json["UserData"]['PlayedPercentage'] ?? 0.0,
      id: json['Id'],
      isFolder: json['IsFolder'],
      type: json['Type'],
      isPlayed: json["UserData"]['Played'],
      isFavorite: json["UserData"]['IsFavorite'],
    );
  }

  Map<String, dynamic> toJson() => {
        'Name': name,
        'SeriesName': seriesName,
        'Id': id,
        'IsFolder': isFolder,
        'Type': type,
        'UserData': {
          'PlayedPercentage': playbackPourcentage,
          'Played': isPlayed,
          'IsFavorite': isFavorite,
        },
      };

  @override
  String toString() {
    return 'Item{name: $name, SeriesName: $seriesName id: $id, isFolder: $isFolder, type: $type, playbackPositionTicks: $playbackPourcentage, isPlayed: $isPlayed, isFavorite: $isFavorite}';
  }

  //getters
  String get getName => name;
  String get getSeriesName => seriesName;
  String get getId => id;
  bool get getIsFolder => isFolder;
  String get getType => type;
  double get getPlaybackPourcentage => playbackPourcentage;
  bool get getIsPlayed => isPlayed;
  bool get getIsFavorite => isFavorite;
  String getImageUrl(ServerConfig config) {
    return "${config.getServerUrl}/Items/$id/Images/Primary";
  }
}
