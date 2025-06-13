import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:journal/providers/journal_provider.dart';
import 'package:journal/views/all_entries_view.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(JournalEntryAdapter());
  final secureStorage = FlutterSecureStorage(); // Initialize flutter_secure_storage

  // Check if encryption key is stored in secure storage
  final encryptionKeyString = await secureStorage.read(key: 'encryptionKey');

  // Generate encryption key if not exists
  if (encryptionKeyString == null) {
    final encryptionKey = Hive.generateSecureKey();
    await secureStorage.write(
      key: 'encryptionKey',
      value: base64UrlEncode(encryptionKey),
    );
  }

  // Retrieve encryption key from secure storage
  final key = await secureStorage.read(key: 'encryptionKey');
  final encryptionKeyUint8List = base64Url.decode(key!);

  // Open encrypted box with encryption key
  final storage = await Hive.openBox<JournalEntry>(
    'journal_entries_encrypted',
    encryptionCipher: HiveAesCipher(encryptionKeyUint8List),
  );

  // Initialize JournalProvider with encrypted storage
  final journalProvider = JournalProvider(storage);


  runApp(
    ChangeNotifierProvider(
      create: (context) => journalProvider,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Journal App',
      debugShowCheckedModeBanner: false, // to not block the + buttong
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 26, 165, 84)),
        useMaterial3: true,
      ),
      home: const AllEntriesView(),
    );
  }
}
