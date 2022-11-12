import 'package:flutter/widgets.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:paatify/view/home/homescreen.dart';

class SearchProvider extends ChangeNotifier {
  List<SongModel> temp = [];
  searchFilter(value) {
    if (value != null && value.isNotEmpty) {
      temp.clear();
      for (SongModel item in HomeScreen.plYsong) {
        if (item.title.toLowerCase().contains(value.toLowerCase())) {
          temp.add(item);
        }
      }
    }
    notifyListeners();
  }
}
