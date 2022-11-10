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

@Collection()
class TestRoom {
  Id? id;
  late String name;
  late String roomIcon;
  late List<String> devices;
  late String floor;
  late List<String> item;
  late List<String> label;
  late List<String> icon;
  late List<String> step;
}
