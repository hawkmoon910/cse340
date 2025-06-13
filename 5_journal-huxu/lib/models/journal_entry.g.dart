// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JournalEntryAdapter extends TypeAdapter<JournalEntry> {
  @override
  final int typeId = 0;

  @override
  JournalEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return JournalEntry(
      uuid: fields[0] as String,
      updatedAt: fields[1] as DateTime,
      createdAt: fields[2] as DateTime,
      workoutType: fields[3] as String,
      exerciseOne: fields[4] as String,
      exerciseTwo: fields[5] as String,
      exerciseThree: fields[6] as String,
      duration: fields[7] as Duration,
      notes: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, JournalEntry obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.uuid)
      ..writeByte(1)
      ..write(obj.updatedAt)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.workoutType)
      ..writeByte(4)
      ..write(obj.exerciseOne)
      ..writeByte(5)
      ..write(obj.exerciseTwo)
      ..writeByte(6)
      ..write(obj.exerciseThree)
      ..writeByte(7)
      ..write(obj.duration)
      ..writeByte(8)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JournalEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
