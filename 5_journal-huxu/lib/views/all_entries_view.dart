import 'package:flutter/material.dart';
import 'package:journal/providers/journal_provider.dart';
import 'package:journal/views/entry_view.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AllEntriesView extends StatelessWidget {
  const AllEntriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Semantics(
          label: 'WorkOutNow',
          child: const Text('WorkOutNow', style: TextStyle(color: Colors.black, fontSize: 30.0))
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Create a new JournalEntry
              JournalEntry newEntry = JournalEntry.withTimestamps(
                workoutType: 'New Workout',
                exerciseOne: '',
                exerciseTwo: '',
                exerciseThree: '',
                duration: const Duration(minutes: 30),
                notes: ''
              );
    
              // Add the new entry to the journal
              Provider.of<JournalProvider>(context, listen: false).upsertJournalEntry(newEntry);
    
              // Navigate to the EntryView for the new entry
              _navigateToEntry(context, newEntry);
            },
            tooltip: 'Add New Entry',
          ),
        ],
      ),
      body: Consumer<JournalProvider>(
        builder: (context, journalProvider, child) {
          final journal = journalProvider.journal;
          return ListView.builder(
            itemCount: journal.entries.length,
            itemBuilder: (context, index) {
              return _createListElementForEntry(context, journal.entries[index]);
            },
          );
        },
      ),
    );
  }

  Widget _createListElementForEntry(BuildContext context, JournalEntry entry) {
    return Semantics( // Wrap the list tile with Semantics
      label: entry.workoutType,
      child: Semantics(
        label: _formatDateTime(entry.createdAt),
        child: ListTile(
          title: Text(entry.workoutType),
          subtitle: Text(_formatDateTime(entry.createdAt)),
          onTap: () => _navigateToEntry(context, entry),
        ))
    );
  }

  Future<void> _navigateToEntry(BuildContext context, JournalEntry entry) async {
    final newEntry = await Navigator.push(context, MaterialPageRoute(builder: (context) => EntryView(entry: entry)));

    if (!context.mounted) return; // code after this line is only executed if the widget is still mounted

    final journalProvider = Provider.of<JournalProvider>(context, listen: false); // Get non-listening reference to JournalProvider
    if (newEntry != null) {
      journalProvider.upsertJournalEntry(newEntry); // Upsert new entry via provider if it's not null
    }

  }

  _formatDateTime(DateTime when){
    return DateFormat.yMd().add_jm().format(when);
  }

}