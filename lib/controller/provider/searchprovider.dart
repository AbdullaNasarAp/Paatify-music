import 'package:flutter/widgets.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchProvider extends ChangeNotifier {
  late List<SongModel> allSong;

  List<SongModel> song = [];

  final audioQuery = OnAudioQuery();
  void allSongLoad() async {
    allSong = await audioQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
    notifyListeners();

    song = allSong;
  }

  void search(String keybord) {
    List<SongModel> results = [];
    if (keybord.isEmpty) {
      results = allSong;
    } else {
      results = allSong
          .where(
            (element) => element.displayNameWOExt.toLowerCase().contains(
                  keybord.toLowerCase(),
                ),
          )
          .toList();
    }

    song = results;
    notifyListeners();
  }
}
