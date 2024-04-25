import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:paatify/controller/provider/favoritepro/favbutprovider.dart';
import 'package:provider/provider.dart';

class FavoriteBut extends StatelessWidget {
  const FavoriteBut({
    Key? key,
    required this.song,
  }) : super(key: key);
  final SongModel song;

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteButProvider>(
      builder: (context, provider, child) {
        return TextButton.icon(
          label: const Text(
            "Add To Favorite",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            provider.toggleFavorite(song);

            final snackBar = SnackBar(
              backgroundColor: const Color.fromARGB(255, 17, 17, 17),
              content: Text(
                provider.isFavorite(song)
                    ? 'Song Added to Favorite'
                    : 'Removed From Favorite',
                style: const TextStyle(color: Colors.white),
              ),
              duration: const Duration(milliseconds: 500),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          icon: Icon(
            provider.isFavorite(song) ? Icons.favorite : Icons.favorite_border,
            color: provider.isFavorite(song)
                ? Colors.red[900]
                : const Color.fromARGB(255, 255, 255, 255),
          ),
        );
      },
    );
  }
}
