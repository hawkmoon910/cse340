import 'package:uuid/uuid.dart';

typedef UUIDString = String; // Typedef for UUIDString which is a String

class UUIDMaker{
  static const uuid = Uuid(); // Static instance of the Uuid class from the uuid package

  // Generates a UUID string
  static UUIDString generateUUID(){
    return uuid.v4();
  }
}