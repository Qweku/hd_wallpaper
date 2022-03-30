// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallpaper.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WallpaperAdapter extends TypeAdapter<Wallpaper> {
  @override
  final int typeId = 0;

  @override
  Wallpaper read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Wallpaper(
      description: fields[0] as String,
      altDescription: fields[1] as String,
      urls: fields[2] as Urls,
    );
  }

  @override
  void write(BinaryWriter writer, Wallpaper obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.description)
      ..writeByte(1)
      ..write(obj.altDescription)
      ..writeByte(2)
      ..write(obj.urls);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WallpaperAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
