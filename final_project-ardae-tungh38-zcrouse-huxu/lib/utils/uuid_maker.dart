import 'package:uuid/uuid.dart';

typedef UUIDString = String;

/// Generates uuids for Journal Entry
class UUIDMaker{
  static const uuid = Uuid();

  /// Returns new uuid using darts uuid class.
  static UUIDString generateUUID(){
    return uuid.v4();
  }
}