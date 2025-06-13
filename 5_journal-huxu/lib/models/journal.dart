import 'package:hive_flutter/hive_flutter.dart';
import 'package:journal/models/journal_entry.dart';

class Journal {

  final Box<JournalEntry> _storage;

  Journal(Box<JournalEntry> storage) // Modify the constructor
      : _storage = storage,
        _entries = List.from(storage.values); // Initialize _entries from storage

  // Constructor to initialize a new Journal with an empty list of entries
  final List<JournalEntry> _entries;

  // Getter to return a copy of the list of journal entries
  List<JournalEntry> get entries => List.from(_entries);

  // Method to add or update a journal entry
  void upsertEntry(JournalEntry entry) {
    final existingEntryIndex = entries.indexWhere((e) => e.uuid == entry.uuid);
    if (existingEntryIndex == -1) {
      // If entry not found, add it to the list
      _entries.add(entry);
    } else {
      // If entry found, replace it with the new entry
      _entries[existingEntryIndex] = entry;
    }
    _storage.put(entry.uuid, entry);
  }

  // class Journal {

  // final Box<JournalEntry> _storage;

  // Journal(Box<JournalEntry> storage) : _storage = storage;

  // List<JournalEntry> get entries => _storage.values.toList();

  // // Method to add or update a journal entry
  // void upsertEntry(JournalEntry entry) {
  //   _storage.put(entry.uuid, entry);
  // }

  // Method to clone the journal
  Journal clone() {
    // Create a new Journal instance of storage
    return Journal(_storage);
  }
}
