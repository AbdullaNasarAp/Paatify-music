import 'package:hive_flutter/adapters.dart';
part 'paatify_model.g.dart';

@HiveType(typeId: 1)
class PaatifyMusic extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  List<int> songId;

  PaatifyMusic({
    required this.name,
    required this.songId,
  });
  add(int id) async {
    songId.add(id);
    save();
  }

  deleteData(int id) {
    songId.remove(id);
    save();
  }

  bool inValueIn(int id) {
    return songId.contains(id);
  }
}
