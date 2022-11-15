import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:paatify/controller/getsongs.dart';

class NowPlayingProvider with ChangeNotifier {
  bool isShuffle = true;
  bool isFav = false;
  final List<SongModel> songModel = GetSongs.playingSongs;
  Duration position = const Duration();

  Duration musicLength = const Duration();
  int currentIndex = 0;
  mountedfun() {
    GetSongs.player.currentIndexStream.listen((index) {
      if (index != null) {
        notifyListeners();
        currentIndex = index;
        GetSongs.currentIndes = index;
      }

      notifyListeners();
    });

    GetSongs.player.durationStream.listen((Duration? d) {
      try {
        if (d == null) {
          return;
        }
        musicLength = d;
        notifyListeners();
      } catch (e) {
        log(e.toString());
      }
    });

    GetSongs.player.positionStream.listen((p) {
      position = p;
      notifyListeners();
    });
  }
}
