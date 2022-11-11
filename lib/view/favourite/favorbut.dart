import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:paatify/model/database.dart/favouriteDb.dart';

class FavoritBut extends StatefulWidget {
  const FavoritBut({Key? key, required this.song}) : super(key: key);
  final SongModel song;

  @override
  State<FavoritBut> createState() => _FavoritButState();
}

class _FavoritButState extends State<FavoritBut> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: FavoriteDB.favoriteSongs,
      builder: (BuildContext ctx, List<SongModel> favorData, Widget? child) {
        return IconButton(
          onPressed: () {
            if (FavoriteDB.isFavor(widget.song)) {
              FavoriteDB.delete(widget.song.id);
              const snackBar = SnackBar(
                backgroundColor: Color.fromARGB(255, 17, 17, 17),
                content: Text(
                  'Removed From Favorite',
                  style: TextStyle(color: Color.fromARGB(255, 247, 247, 247)),
                ),
                duration: Duration(milliseconds: 500),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              FavoriteDB.add(widget.song);

              const snackbar = SnackBar(
                backgroundColor: Color.fromARGB(255, 17, 17, 17),
                content: Text(
                  'Song Added to Favorite',
                  style: TextStyle(color: Colors.white),
                ),
                duration: Duration(milliseconds: 500),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            }

            FavoriteDB.favoriteSongs.notifyListeners();
          },
          icon: FavoriteDB.isFavor(widget.song)
              ? Icon(
                  Icons.favorite,
                  color: Colors.red[900],
                )
              : const Icon(
                  Icons.favorite_border,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
        );
      },
    );
  }
}
