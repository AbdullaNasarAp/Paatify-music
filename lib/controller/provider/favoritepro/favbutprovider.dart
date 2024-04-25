import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:paatify/model/database.dart/favouriteDb.dart';

class FavoriteButProvider extends ChangeNotifier {
  bool isFavorite(SongModel song) {
    return FavoriteDB.isFavor(song);
  }

  void toggleFavorite(SongModel song) {
    if (isFavorite(song)) {
      FavoriteDB.delete(song.id);
    } else {
      FavoriteDB.add(song);
    }
    notifyListeners();
  }
}
