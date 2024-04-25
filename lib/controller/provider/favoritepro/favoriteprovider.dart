// import 'package:flutter/material.dart';
// import 'package:on_audio_query/on_audio_query.dart';
// import 'package:paatify/model/database.dart/favouriteDb.dart';

// class FavoritesProvider extends ChangeNotifier {
//   List<SongModel> _favoriteSongs = [];

//   List<SongModel> get favoriteSongs => _favoriteSongs;

//   FavoritesProvider() {
//     _initializeFavoriteSongs();
//   }

//   void _initializeFavoriteSongs() {
//     _favoriteSongs = FavoriteDB.favoriteSongs.value;
//     notifyListeners();
//   }

//   void addFavorite(SongModel song) {
//     FavoriteDB.add(song);
//     _favoriteSongs.add(song);
//     notifyListeners();
//   }

//   void deleteFavorite(int id) {
//     FavoriteDB.delete(id);
//     _favoriteSongs.removeWhere((song) => song.id == id);
//     notifyListeners();
//   }

//   void clearFavorites() {
//     FavoriteDB.clear();
//     _favoriteSongs.clear();
//     notifyListeners();
//   }
// }
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:paatify/model/database.dart/favouriteDb.dart';

class FavoritesProvider extends ChangeNotifier {
  List<SongModel> _favoriteSongs = [];

  List<SongModel> get favoriteSongs => _favoriteSongs;

  FavoritesProvider() {
    _initializeFavoriteSongs();
  }

  void _initializeFavoriteSongs() {
    _favoriteSongs = FavoriteDB.favoriteSongs.value;
    notifyListeners();
  }

  void addFavorite(SongModel song) {
    FavoriteDB.add(song);
    _favoriteSongs.add(song);
    notifyListeners();
  }

  void deleteFavorite(int id) {
    FavoriteDB.delete(id);
    _favoriteSongs.removeWhere((song) => song.id == id);
    notifyListeners();
  }

  void clearFavorites() {
    FavoriteDB.clear();
    _favoriteSongs.clear();
    notifyListeners();
  }
}
