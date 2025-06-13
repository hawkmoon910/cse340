import 'package:flutter/material.dart';
import 'package:journal/models/journal_entry.dart';

class EntryView extends StatefulWidget {
  final JournalEntry entry;

  const EntryView({super.key, required this.entry});

  @override
  State<EntryView> createState() => _EntryViewState();
}

class _EntryViewState extends State<EntryView>{

  late String currentNotes;
  late String currentWorkoutType;
  late String currentExerciseOne;
  late String currentExerciseTwo;
  late String currentExerciseThree;
  late Duration currentDuration;

  @override
  void initState() {
    super.initState();
    currentWorkoutType = widget.entry.workoutType;
    currentExerciseOne = widget.entry.exerciseOne;
    currentExerciseTwo = widget.entry.exerciseTwo;
    currentExerciseThree = widget.entry.exerciseThree;
    currentDuration = widget.entry.duration;
    currentNotes = widget.entry.notes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Semantics(
          label: 'Workout Entry',
          child: const Text('Workout Entry', style: TextStyle(color: Colors.black, fontSize: 30.0))
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              _popBack(context);
            },
            tooltip: 'Save',
          ),
        ],
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (!didPop) {
            _popBack(context);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Semantics(
                label: 'Workout Type $currentWorkoutType',
                child: TextFormField(
                  initialValue: currentWorkoutType,
                  style: const TextStyle(fontSize: 18.0),
                  decoration: const InputDecoration(
                    labelText: 'Workout Type', labelStyle: TextStyle(color: Colors.brown, fontSize: 16),
                    border: UnderlineInputBorder(borderSide: BorderSide(width: 2))
                  ),
                  onChanged: (value) {
                    setState(() {
                      currentWorkoutType = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 16),
              Semantics(
                label: 'Duration in minutes ${currentDuration.toString()}',
                child: TextFormField(
                  initialValue: currentDuration.toString(),
                  style: const TextStyle(fontSize: 18.0),
                  decoration: const InputDecoration(
                    labelText: 'Duration (minutes)', labelStyle: TextStyle(color: Colors.brown, fontSize: 16),
                    border: UnderlineInputBorder(borderSide: BorderSide(width: 2))
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      currentDuration = Duration(minutes: int.tryParse(value) ?? 0);
                    });
                  },
                ),
              ),
              const SizedBox(height: 16),
              Semantics(
                label: 'Exercise 1 $currentExerciseOne',
                child: TextFormField(
                  initialValue: currentExerciseOne,
                  style: const TextStyle(fontSize: 18.0),
                  decoration: const InputDecoration(
                    labelText: 'Exercise 1', labelStyle: TextStyle(color: Colors.brown),
                    border: UnderlineInputBorder(borderSide: BorderSide(width: 2))
                  ),
                  onChanged: (value) {
                    setState(() {
                      currentExerciseOne = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 16),
              Semantics(
                label: 'Exercise 2 $currentExerciseTwo',
                child: TextFormField(
                  initialValue: currentExerciseTwo,
                  style: const TextStyle(fontSize: 18.0),
                  decoration: const InputDecoration(
                    labelText: 'Exercise 2', labelStyle: TextStyle(color: Colors.brown),
                    border: UnderlineInputBorder(borderSide: BorderSide(width: 2))
                  ),
                  onChanged: (value) {
                    setState(() {
                      currentExerciseTwo = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 16),
              Semantics(
                label: 'Exercise 3 $currentExerciseThree',
                child: TextFormField(
                  initialValue: currentExerciseThree,
                  style: const TextStyle(fontSize: 18.0),
                  decoration: const InputDecoration(
                    labelText: 'Exercise 3', labelStyle: TextStyle(color: Colors.brown),
                    border: UnderlineInputBorder(borderSide: BorderSide(width: 2))
                  ),
                  onChanged: (value) {
                    setState(() {
                      currentExerciseThree = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 16),
              Semantics(
                label: 'Notes $currentNotes',
                child: TextFormField(
                  initialValue: currentNotes,
                  style: const TextStyle(fontSize: 18.0),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  onChanged: (value) {
                    setState(() {
                      currentNotes = value;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Notes',
                    labelStyle: TextStyle(color: Colors.brown),
                    border: OutlineInputBorder(borderSide: BorderSide(width: 2))
                  ),
                ),
              ),
              Semantics(
                label: 'Created At ${widget.entry.createdAt}',
                child: Text('Created At: ${widget.entry.createdAt}', style: const TextStyle(fontSize: 16))
              ),
              const SizedBox(height: 8),
              Semantics(
                label: 'Updated At ${widget.entry.updatedAt}',
                child: Text('Updated At: ${widget.entry.updatedAt}', style: const TextStyle(fontSize: 16))
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      )
    );
  }

  _popBack(BuildContext context){
    // Updates the JournalEntry with updated information
    if (widget.entry.workoutType != currentWorkoutType || widget.entry.exerciseOne != currentExerciseOne
      || widget.entry.exerciseTwo != currentExerciseTwo || widget.entry.exerciseThree != currentExerciseThree
      || widget.entry.duration != currentDuration || widget.entry.notes != currentNotes){
      JournalEntry updatedEntry = JournalEntry.withUpdatedEntry(
        widget.entry, workoutType: currentWorkoutType, exerciseOne: currentExerciseOne,
        exerciseTwo: currentExerciseTwo, exerciseThree: currentExerciseThree,
        duration: currentDuration, notes: currentNotes
      );
      Navigator.pop(context, updatedEntry);
    } else {
      Navigator.pop(context, widget.entry);
    }
  }
}

