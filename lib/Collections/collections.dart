import 'package:isar/isar.dart';

// Idee ist obergeschoss: [alle Räume]
// Bad: [alle Devices zum Beispiel Deckenlampe, Spiegellampe]

@Collection()
class TestSideMap {
  @Name("id")
  Id? id;
  late List<String> floors;
  late List<String> rooms;
  late List<String> devices;
}
