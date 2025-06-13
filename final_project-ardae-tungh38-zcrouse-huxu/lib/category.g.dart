// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryAdapter extends TypeAdapter<Category> {
  @override
  final int typeId = 1;

  @override
  Category read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Category.miscellaneousExpense;
      case 1:
        return Category.foodExpense;
      case 2:
        return Category.entertainmentExpense;
      case 3:
        return Category.taxExpense;
      case 4:
        return Category.housingExpense;
      case 5:
        return Category.insuranceExpense;
      case 6:
        return Category.transportationExpense;
      case 7:
        return Category.miscellaneousIncome;
      case 8:
        return Category.housingIncome;
      case 9:
        return Category.businessIncome;
      case 10:
        return Category.wageIncome;
      case 11:
        return Category.none;
      default:
        return Category.miscellaneousExpense;
    }
  }

  @override
  void write(BinaryWriter writer, Category obj) {
    switch (obj) {
      case Category.miscellaneousExpense:
        writer.writeByte(0);
        break;
      case Category.foodExpense:
        writer.writeByte(1);
        break;
      case Category.entertainmentExpense:
        writer.writeByte(2);
        break;
      case Category.taxExpense:
        writer.writeByte(3);
        break;
      case Category.housingExpense:
        writer.writeByte(4);
        break;
      case Category.insuranceExpense:
        writer.writeByte(5);
        break;
      case Category.transportationExpense:
        writer.writeByte(6);
        break;
      case Category.miscellaneousIncome:
        writer.writeByte(7);
        break;
      case Category.housingIncome:
        writer.writeByte(8);
        break;
      case Category.businessIncome:
        writer.writeByte(9);
        break;
      case Category.wageIncome:
        writer.writeByte(10);
        break;
      case Category.none:
        writer.writeByte(11);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
