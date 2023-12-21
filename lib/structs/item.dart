class Item {
  final String name;
  final String id;
  final bool isFolder;
  final String type;
  final int playbackPositionTicks;
  final bool isPlayed;
  final bool isFavorite;

  Item({
    required this.name,
    required this.id,
    required this.isFolder,
    required this.type,
    required this.playbackPositionTicks,
    required this.isPlayed,
    required this.isFavorite,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['Name'],
      id: json['Id'],
      isFolder: json['IsFolder'],
      type: json['Type'],
      playbackPositionTicks: json["UserData"]['PlaybackPositionTicks'],
      isPlayed: json["UserData"]['Played'],
      isFavorite: json["UserData"]['IsFavorite'],
    );
  }
}
