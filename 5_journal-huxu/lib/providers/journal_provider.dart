import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:journal/models/journal.dart';
import 'package:journal/models/journal_entry.dart';

class JournalProvider extends ChangeNotifier {
  final Journal _journal;

  JournalProvider(Box<JournalEntry> storage) : _journal = Journal(storage);

  // Getter to return a clone of the journal
  Journal get journal => _journal.clone();

  // Method to proxy upsertJournalEntry calls
  void upsertJournalEntry(JournalEntry entry) {
    _journal.upsertEntry(entry);
    notifyListeners();
  }
}