// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paatify_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PaatifyMusicAdapter extends TypeAdapter<PaatifyMusic> {
  @override
  final int typeId = 1;

  @override
  PaatifyMusic read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PaatifyMusic(
      name: fields[0] as String,
      songId: (fields[1] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, PaatifyMusic obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.songId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaatifyMusicAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
