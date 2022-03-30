// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'urls.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UrlsAdapter extends TypeAdapter<Urls> {
  @override
  final int typeId = 10;

  @override
  Urls read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Urls(
      regular: fields[10] as String,
      small: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Urls obj) {
    writer
      ..writeByte(2)
      ..writeByte(10)
      ..write(obj.regular)
      ..writeByte(11)
      ..write(obj.small);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UrlsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
