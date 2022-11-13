import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:paatify/controller/getsongs.dart';
import 'package:paatify/model/database.dart/favouriteDb.dart';
import 'package:paatify/view/nowplaying.dart';
import 'package:paatify/view/favourite/favoritebut.dart';
import 'package:paatify/view/home/home.dart';
import 'package:paatify/view/playlist/playlist.dart';

class AllSongs extends StatelessWidget {
  AllSongs({
    Key? key,
  }) : super(key: key);
  static List<SongModel> plaYsong = [];

  final _audioQuery = OnAudioQuery();

  // int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.black87,
        title: const Text(
          "All Songs",
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder<List<SongModel>>(
          future: _audioQuery.querySongs(
              sortType: null,
              orderType: OrderType.ASC_OR_SMALLER,
              uriType: UriType.EXTERNAL,
              ignoreCase: true),
          builder: (context, item) {
            if (item.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (item.data!.isEmpty) {
              return const Center(
                child: Text(
                  'No Songs Found',
                ),
              );
            } else {
              AllSongs.plaYsong = item.data!;
            }
            if (!FavoriteDB.isIntialized) {
              FavoriteDB.intialize(item.data!);
            }

            return ListView.builder(
              itemBuilder: (context, index) => ListTile(
                leading: QueryArtworkWidget(
                  keepOldArtwork: true,
                  quality: 100,
                  id: item.data![index].id,
                  type: ArtworkType.AUDIO,
                  artworkBorder: BorderRadius.circular(0),
                  nullArtworkWidget: CircleAvatar(
                    backgroundColor: Colors.white24,
                    child: Lottie.asset(
                      'assets/listnull.json',
                      height: 100,
                      width: 100,
                    ),
                  ),
                ),
                onTap: () {
                  GetSongs.player.setAudioSource(
                      GetSongs.createSongList(
                        item.data!,
                      ),
                      initialIndex: index);
                  // GetSongs.player.pause();
                  GetSongs.player.play();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NowPlaying(
                        playerSong: item.data!,
                      ),
                    ),
                  );
                },
                title: TExt(
                  teXt: item.data![index].displayNameWOExt,
                ),
                subtitle: Sub(
                  sub: "${item.data![index].artist}",
                ),
                trailing: PopupMenuButton(
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        value: 1,
                        child: TextButton(
                          onPressed: () {
                            FavoriteBut(
                              song: AllSongs.plaYsong[index],
                            );
                          },
                          child: FavoriteBut(
                            song: AllSongs.plaYsong[index],
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        value: 1,
                        child: TextButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlayListSc(),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.playlist_add,
                            color: Colors.white,
                          ),
                          label: const Text(
                            "Add To PLayList",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ];
                  },
                ),
              ),
              itemCount: item.data!.length,
            );
          },
        ),
      ),
    );
  }
}
