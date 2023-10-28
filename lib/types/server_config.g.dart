// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_config.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ServerConfigAdapter extends TypeAdapter<ServerConfig> {
  @override
  final int typeId = 1;

  @override
  ServerConfig read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ServerConfig(
      username: fields[0] as String,
      token: fields[1] as String,
      serverUrl: fields[2] as String,
      configName: fields[3] as String,
      isDefault: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ServerConfig obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.username)
      ..writeByte(1)
      ..write(obj.token)
      ..writeByte(2)
      ..write(obj.serverUrl)
      ..writeByte(3)
      ..write(obj.configName)
      ..writeByte(4)
      ..write(obj.isDefault);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServerConfigAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
