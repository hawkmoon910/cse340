import 'package:journal/utils/uuid_maker.dart';
import 'package:hive/hive.dart';

part 'journal_entry.g.dart';

@HiveType(typeId: 0)
class JournalEntry {
  @HiveField(0)
  final UUIDString uuid; // Unique identifier for the journal entry
  @HiveField(1)
  final DateTime updatedAt; // Timestamp for when the journal entry was last updated
  @HiveField(2)
  final DateTime createdAt; // Timestamp for when the journal entry was created
  @HiveField(3)
  final String workoutType; // The type of workout performed
  @HiveField(4)
  final String exerciseOne; // Name of exercise 1
  @HiveField(5)
  final String exerciseTwo; // Name of exercise 2
  @HiveField(6)
  final String exerciseThree; // Name of exercise 3
  @HiveField(7)
  final Duration duration; // Tracks the total duration of the workout session
  @HiveField(8)
  final String notes; // Additional comments, observations, or reflections on the workout

  // Default contructor
  JournalEntry({
    required this.uuid,
    required this.updatedAt,
    required this.createdAt,
    required this.workoutType,
    required this.exerciseOne,
    required this.exerciseTwo,
    required this.exerciseThree,
    required this.duration,
    required this.notes
  });

  // New constructor to mimic the old default behavior
  JournalEntry.withTimestamps({
    required this.workoutType,
    required this.duration,
    required this.exerciseOne,
    required this.exerciseTwo,
    required this.exerciseThree,
    required this.notes
  }) : uuid = UUIDMaker.generateUUID(),
       updatedAt = DateTime.now(),
       createdAt = DateTime.now();

  // Constructor method 2: Regular constructor with parameters
  JournalEntry.withTextUUIDUpdatedAtCreatedAt({required this.workoutType, required this.exerciseOne, required this.exerciseTwo,
    required this.exerciseThree, required this.duration, required this.notes, required this.uuid, required this.updatedAt, required this.createdAt});
  
   // Constructor method 3: Named constructor to update the the enrty
  JournalEntry.withUpdatedEntry(JournalEntry entry, {required this.workoutType, required this.exerciseOne, required this.exerciseTwo,
    required this.exerciseThree, required this.duration, required this.notes
  }) : uuid = entry.uuid, updatedAt = DateTime.now(), createdAt = entry.createdAt;

  // Method to clone a journal entry
  JournalEntry clone() {
    // Return a new JournalEntry instance with the same properties
    return JournalEntry(
      uuid: uuid, workoutType: workoutType, exerciseOne: exerciseOne, exerciseTwo: exerciseTwo,
      exerciseThree: exerciseThree, duration: duration, notes: notes, updatedAt: updatedAt, createdAt: createdAt
    );
  }
}