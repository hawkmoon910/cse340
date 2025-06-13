// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionEntryAdapter extends TypeAdapter<TransactionEntry> {
  @override
  final int typeId = 0;

  @override
  TransactionEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionEntry(
      name: fields[6] as String,
      description: fields[1] as String,
      category: fields[4] as Category,
      amount: fields[5] as double,
      taxAmount: fields[2] as double,
      createdAt: fields[3] as DateTime,
      uuid: fields[0] as String,
      isExpense: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TransactionEntry obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.uuid)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.taxAmount)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.amount)
      ..writeByte(6)
      ..write(obj.name)
      ..writeByte(7)
      ..write(obj.isExpense);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
