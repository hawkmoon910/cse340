import 'package:finance_tracker/models/account.dart';
import 'package:finance_tracker/models/transaction_entry.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

/// Provider for a account with methods to notify listens on any modifcation 
/// of the account. Also keeps track of current balance of account.
class AccountProvider extends ChangeNotifier {
  AccountProvider(Box<TransactionEntry> entryStorage, Box<double> balanceStorage) : _account = Account(entryStorage, balanceStorage);

  final Account _account;

  double? _cachedBalance;

  /// Getter method for account, returns a clone
  Account get account => _account.clone();

  /// Getter method for account balance.
  double get balance {
    if (_cachedBalance == null) {
      _createCachedBalance();
    }
    return _cachedBalance!;
  }

  /// Updates the starting balance of the account. Notifies Listeners.
  /// Parameters:
  ///  startingBal - The new startingBal to set the account startingBal to
  updateStartingBal(double startingBal) {
    _account.startingBal = startingBal;
    _invalidateAndNotify();
  }

  /// Generates balance using the starting balance of the account and the list
  /// of transactionEntries to calculate the current balance.
  _createCachedBalance() {
    double startingBal = _account.startingBalance;
    List<TransactionEntry> entries = _account.entries;
    
    double bal = entries.fold(
      startingBal, 
      (double bal, TransactionEntry entry) => (entry.isExpense) ? bal - entry.amount : bal + entry.amount
    );
    _cachedBalance = bal;
  }

  /// Invalidates the cached balance and notifies listeners.
  _invalidateAndNotify() {
    _cachedBalance = null;
    notifyListeners();
  }

  /// Updates a given entry in the account else it will add the entry to the end
  /// of the account. Uses the entry's uuid to determine if two are equal.
  /// Notifies Listeners
  /// Parameters:
  ///   entry - The TransactionEntry to update or add
  void upsertEntry(TransactionEntry entry) {
    _account.upsertEntry(entry);
    _invalidateAndNotify();
  }


  /// Deletes a given entry from the account if that entry exists. 
  /// Notifies Listeners
  /// Parameters:
  ///   entry - The TransactionEntry to delete
  void deleteEntry(TransactionEntry entry) {
    _account.deleteEntry(entry);
    _invalidateAndNotify();
  }

}