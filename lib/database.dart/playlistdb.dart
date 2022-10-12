import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:paatify/database.dart/favouritedb.dart';
import 'package:paatify/model/paatify_model.dart';
import 'package:paatify/screens/splash/splashscreen.dart';

class PlayListDB {
  ValueNotifier<List<PaatifyMusic>> playlistnotifier = ValueNotifier([]);

  Future<void> playlistAdd(PaatifyMusic value) async {
    final playListDb = Hive.box<PaatifyMusic>('playlistDB');
    await playListDb.add(value);

    playlistnotifier.value.add(value);
  }

  Future<void> getAllPlaylist() async {
    final playListDb = Hive.box<PaatifyMusic>('playlistDB');
    playlistnotifier.value.clear();
    playlistnotifier.value.addAll(playListDb.values);

    playlistnotifier.notifyListeners();
  }

  Future<void> playlistDelete(int index) async {
    final playListDb = Hive.box<PaatifyMusic>('playlistDB');

    await playListDb.deleteAt(index);
    getAllPlaylist();
  }

  static Future<void> resetAPP(context) async {
    final playListDb = Hive.box<PaatifyMusic>('playlistDB');
    final musicDb = Hive.box<int>('FavouriteDB');
    await musicDb.clear();
    await playListDb.clear();
    FavoriteDB.favoriteSongs.value.clear();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        ),
        (route) => false);
  }
}
