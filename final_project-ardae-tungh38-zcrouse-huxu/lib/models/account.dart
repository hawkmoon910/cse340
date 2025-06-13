import 'package:hive/hive.dart';
import 'package:finance_tracker/models/transaction_entry.dart';

class Account {
  factory Account(Box<TransactionEntry> entryStorage, Box<double> balanceStorage) {
    List<TransactionEntry> entries = entryStorage.values.toList();
    double startBal = balanceStorage.get('start_bal') ?? 0.0;
    return Account._all(entries, startBal, entryStorage, balanceStorage);
  }

  Account._all(this._entries, this._startingBalance, this._entryStorage, this._balanceStorage);

  final List<TransactionEntry> _entries;

  final Box<TransactionEntry> _entryStorage;

  final Box<double> _balanceStorage;

  double _startingBalance;

  /// Getter method for entries, returns a copy of _entries
  List<TransactionEntry> get entries => List.of(_entries);

  double get startingBalance => _startingBalance;

  set startingBal(double startingBal) => _startingBalance = startingBal;

  /// Updates a given entry in the account else it will add the entry to the end
  /// of the account. Uses the entry's uuid to determine if two are equal.
  /// Parameters:
  ///   entry - The TransactionEntry to update or add
  void upsertEntry(TransactionEntry entry) {
    int index = _entries.indexWhere((listEntry) => listEntry.uuid == entry.uuid);
    if (index == -1) {
      _entries.add(entry);
    } else {
      _entries[index] = entry;
    }
    _entryStorage.put(entry.uuid, entry);
  }

  /// Deletes a given entry in the account if it exists in the account. 
  /// Parameters:
  ///   entry - The TransactionEntry to be deletedx
  void deleteEntry(TransactionEntry entry) {
    int index = _entries.indexWhere((listEntry) => listEntry.uuid == entry.uuid);
    if (index != -1) {
      _entries.removeAt(index);
      _entryStorage.delete(entry.uuid);
    }
  }

  /// Returns a clone of this journal.
  Account clone() {
    return Account._all(entries, _startingBalance, _entryStorage, _balanceStorage);
  }

}