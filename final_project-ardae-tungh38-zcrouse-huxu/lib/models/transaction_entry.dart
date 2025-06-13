import 'package:hive/hive.dart';
import 'package:finance_tracker/utils/uuid_maker.dart';
import 'package:finance_tracker/category.dart';
part 'transaction_entry.g.dart';

/// Represents a transaction Entry
/// Stores text, uuid, last date updated, date created and rating.
/// Rating is stored out of 10, each point marks half a stare.
@HiveType(typeId: 0)
class TransactionEntry {
  @HiveField(0)
  final UUIDString uuid;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final double taxAmount; 

  @HiveField(3)
  final DateTime createdAt;

  @HiveField(4)
  final Category category;

  @HiveField(5)
  final double amount;

  @HiveField(6)
  final String name;

  @HiveField(7)
  final bool isExpense;

  /// Creates a new transaction Entry with the given values
  TransactionEntry({
    required this.name, 
    required this.description, 
    required this.category, 
    required this.amount, 
    required this.taxAmount, 
    required this.createdAt, 
    required this.uuid,
    required this.isExpense,
  });

  /// Creates a new transaction Entry given some text and rating. 
  /// Automaticly sets uuid and timestamps.
  factory TransactionEntry.now({name='', description='', amount=0.0, tax=0.0, category=Category.none, isExpense=false}) {
    final when = DateTime.now();
    return TransactionEntry(
      name: name,
      description: description, 
      category: category,
      amount: amount,
      taxAmount: amount*1/(1+tax)*tax, 
      uuid: UUIDMaker.generateUUID(), 
      createdAt: when,
      isExpense: isExpense,
    );
  }

  /// Creates a new transaction Entry based on the infomation from a previous 
  /// transaction entry and new title, text, platform and rating to update the transaction entry to.
  TransactionEntry.withUpdatedFields(TransactionEntry entry, String newName, String newDescription, Category newCategory, double newTax, double newAmount, bool newIsExpense) : 
    name= newName,
    description= newDescription, 
    category= newCategory,
    uuid= entry.uuid, 
    createdAt= entry.createdAt, 
    amount= newAmount, 
    taxAmount= newTax,
    isExpense= newIsExpense;

  @override
  String toString() {
    return 'Transaction Entry: \nName: $name \nDescription: $description \nCategory: $category \nUUID: $uuid \nAmount: $amount \nTax Amount: $taxAmount \nisExpense: $isExpense';
  }
}