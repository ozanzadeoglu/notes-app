// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QueueModelAdapter extends TypeAdapter<QueueModel> {
  @override
  final typeId = 2;

  @override
  QueueModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QueueModel(
      note: fields[0] as NoteModel,
      operationType: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, QueueModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.note)
      ..writeByte(1)
      ..write(obj.operationType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QueueModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
