import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavoriteDB {
  static bool isIntialized = false;
  static final musicDB = Hive.box<int>('FavouriteDB');
  static ValueNotifier<List<SongModel>> favoriteSongs = ValueNotifier([]);

  static intialize(List<SongModel> songs) {
    for (SongModel song in songs) {
      if (isFavor(song)) {
        favoriteSongs.value.add(song);
      }
    }
    isIntialized = true;
  }

  static isFavor(SongModel song) {
    if (musicDB.values.contains(song.id)) {
      return true;
    }
    return false;
  }

  static add(SongModel song) async {
    musicDB.add(song.id);
    favoriteSongs.value.add(song);
    FavoriteDB.favoriteSongs.notifyListeners();
  }

  static delete(int id) async {
    int deletekey = 0;
    if (!musicDB.values.contains(id)) {
      return;
    }
    final Map<dynamic, int> favorMap = musicDB.toMap();
    favorMap.forEach((key, value) {
      if (value == id) {
        deletekey = key;
      }
    });
    musicDB.delete(deletekey);
    favoriteSongs.value.removeWhere((song) => song.id == id);
  }

  static clear() async {
    FavoriteDB.favoriteSongs.value.clear();
  }
}
