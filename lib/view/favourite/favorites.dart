import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:paatify/controller/getsongs.dart';
import 'package:paatify/database.dart/favouritedb.dart';
import 'package:paatify/screens/nowplaying.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    return ValueListenableBuilder(
      valueListenable: FavoriteDB.favoriteSongs,
      builder: (BuildContext ctx, List<SongModel> favorData, Widget? child) {
        return Scaffold(
          backgroundColor: Colors.black87,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.black87,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset("assets/99403-love.json", height: 35, width: 35),
                const Text(
                  "Favorites",
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),
          ),
          body: SafeArea(
            child: FavoriteDB.favoriteSongs.value.isEmpty
                ? Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset("assets/repRmRA5JM.json",
                          height: 265, width: 365),
                      const Text(
                        'No Favorites songs',
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ))
                : ListView(
                    children: [
                      ValueListenableBuilder(
                        valueListenable: FavoriteDB.favoriteSongs,
                        builder: (BuildContext ctx, List<SongModel> favordata,
                            Widget? child) {
                          return ListView.separated(
                            itemCount: favorData.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (
                              ctx,
                              index,
                            ) {
                              return ListTile(
                                onTap: () {
                                  List<SongModel> favList = [...favorData];
                                  setState(() {});
                                  GetSongs.player.stop();
                                  GetSongs.player.setAudioSource(
                                      GetSongs.createSongList(favList),
                                      initialIndex: index);
                                  GetSongs.player.play();
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (ctx) => NowPlaying(
                                        playerSong: favList,
                                      ),
                                    ),
                                  );
                                },
                                leading: QueryArtworkWidget(
                                  id: favorData[index].id,
                                  type: ArtworkType.AUDIO,
                                  artworkBorder: BorderRadius.circular(0),
                                  nullArtworkWidget: CircleAvatar(
                                    child: Lottie.asset('assets/listnull.json'),
                                  ),
                                ),
                                title: Text(
                                  favorData[index].displayNameWOExt,
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                ),
                                subtitle: Text(
                                  favorData[index].artist.toString(),
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    FavoriteDB.favoriteSongs.notifyListeners();
                                    FavoriteDB.delete(favorData[index].id);
                                    setState(() {});
                                    const snackbar = SnackBar(
                                      backgroundColor: Colors.black,
                                      content: Text(
                                        'Song deleted from favorite',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      duration: Duration(
                                        microseconds: 34000,
                                      ),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackbar);
                                  },
                                  icon: const Icon(FontAwesomeIcons.trash),
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const Divider();
                            },
                          );
                        },
                      )
                    ],
                  ),
          ),
        );
      },
    );
  }
}
