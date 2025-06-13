import 'dart:convert';
import 'package:finance_tracker/category.dart';
import 'package:finance_tracker/models/transaction_entry.dart';
import 'package:finance_tracker/providers/account_provider.dart';
import 'package:finance_tracker/providers/position_provider.dart';
import 'package:finance_tracker/providers/tax_provider.dart';
import 'package:finance_tracker/views/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // Initialize hive and register adapters
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionEntryAdapter());
  Hive.registerAdapter(CategoryAdapter());

  // Get encryption key or generate one if none are found
  const secureStorage = FlutterSecureStorage();
  // if key not exists return null
  final encryptionKeyString = await secureStorage.read(key: 'key');
  if (encryptionKeyString == null) {
    final key = Hive.generateSecureKey();
    await secureStorage.write(
      key: 'key',
      value: base64UrlEncode(key),
    );
  }
  final key = await secureStorage.read(key: 'key');
  final encryptionKeyUint8List = base64Url.decode(key!);
  print('Encryption key Uint8List: $encryptionKeyUint8List');

  // Get hive storage and decrypt it using the key from above
  final entryBox = await Hive.openBox<TransactionEntry>('entryBox', encryptionCipher: HiveAesCipher(encryptionKeyUint8List));
  final balanceBox = await Hive.openBox<double>('balanceVault', encryptionCipher: HiveAesCipher(encryptionKeyUint8List));
  
  // Start MyApp with the storage from the encrypted box
  runApp(MyApp(entryStorage: entryBox, balanceStorage: balanceBox,)); 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.entryStorage, required this.balanceStorage});

  final Box<TransactionEntry> entryStorage;
  final Box<double> balanceStorage;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finance Tracker',
      showSemanticsDebugger: false,
      debugShowCheckedModeBanner: false, // to not block the + buttong
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider( create: (context) => AccountProvider(entryStorage, balanceStorage)),
          ChangeNotifierProvider( create: (context) => PositionProvider()),
          ChangeNotifierProvider( create: (context) => TaxProvider())
        ],
        child: const DashboardView()
      )
    );
  }
}
