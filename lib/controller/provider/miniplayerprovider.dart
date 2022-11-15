import 'package:flutter/cupertino.dart';
import 'package:paatify/controller/getsongs.dart';

class MiniPlayerProvider extends ChangeNotifier {
  void mountedfun() async {
    GetSongs.player.currentIndexStream.listen((index) {
      if (index != null) {
        notifyListeners();
      }
    });
  }
}
