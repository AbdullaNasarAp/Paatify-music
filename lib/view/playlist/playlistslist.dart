import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lottie/lottie.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:paatify/controller/getsongs.dart';
import 'package:paatify/controller/provider/playlistprovider/playlistlistprovider.dart';
import 'package:paatify/model/database.dart/playlistdb.dart';
import 'package:paatify/model/paatify_model.dart';
import 'package:paatify/view/nowplaying.dart';
import 'package:paatify/view/playlist/allsongslist.dart';
import 'package:provider/provider.dart';

class PlaylistData extends StatelessWidget {
  PlaylistData({
    Key? key,
    required this.playlist,
    required this.folderindex,
  }) : super(key: key);
  final PaatifyMusic playlist;
  final int folderindex;

  late List<SongModel> playlistsong;
  @override
  Widget build(BuildContext context) {
    PlayListDB().getAllPlaylist();
    return Consumer<PlayListListProvider>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: Colors.black87,
          appBar: AppBar(
            backgroundColor: Colors.black87,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
              ),
            ),
            automaticallyImplyLeading: false,
            title: Text(
              playlist.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              ValueListenableBuilder(
                valueListenable: Hive.box<PaatifyMusic>(
                  'playlistDB',
                ).listenable(),
                builder: (
                  BuildContext context,
                  Box<PaatifyMusic> value,
                  Widget? child,
                ) {
                  playlistsong = listPlaylist(
                    value.values.toList()[folderindex].songId,
                  );

                  return playlistsong.isEmpty
                      ? Column(
                          children: [
                            Lottie.asset(
                              "assets/repRmRA5JM.json",
                              height: 265,
                              width: 365,
                            ),
                            const Text(
                              'No songs in this playlist',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        )
                      : ListView.separated(
                          reverse: true,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (ctx, index) {
                            return ListTile(
                              onTap: () {
                                List<SongModel> newlist = [
                                  ...playlistsong,
                                ];

                                GetSongs.player.stop();
                                GetSongs.player.setAudioSource(
                                    GetSongs.createSongList(
                                      newlist,
                                    ),
                                    initialIndex: index);
                                GetSongs.player.play();
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctx) => NowPlaying(
                                      playerSong: playlistsong,
                                    ),
                                  ),
                                );
                              },
                              leading: QueryArtworkWidget(
                                id: playlistsong[index].id,
                                type: ArtworkType.AUDIO,
                                artworkBorder: BorderRadius.circular(
                                  0,
                                ),
                                nullArtworkWidget: CircleAvatar(
                                  radius:
                                      MediaQuery.of(context).size.width * 0.075,
                                  backgroundColor: const Color.fromARGB(
                                    255,
                                    43,
                                    42,
                                    42,
                                  ),
                                  child: const Icon(
                                    Icons.music_note,
                                    color: Colors.white,
                                  ),
                                ),
                                errorBuilder: (
                                  context,
                                  excepion,
                                  gdb,
                                ) {
                                  Provider.of<PlayListListProvider>(context)
                                      .notifyListeners();
                                  return Image.asset('');
                                },
                              ),
                              title: Text(
                                playlistsong[index].title,
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: Text(
                                playlistsong[index].artist!,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                maxLines: 1,
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  playlist.deleteData(
                                    playlistsong[index].id,
                                  );
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (
                            ctx,
                            index,
                          ) {
                            return const Divider();
                          },
                          itemCount: playlistsong.length,
                        );
                },
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => SongListPage(
                    playlist: playlist,
                  ),
                ),
              );
            },
            label: const Text(
              'Add song',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            icon: const Icon(
              Icons.add,
            ),
            backgroundColor: Colors.white,
          ),
        );
      },
    );
  }

  List<SongModel> listPlaylist(
    List<int> data,
  ) {
    List<SongModel> plsongs = [];
    for (int i = 0; i < GetSongs.songscopy.length; i++) {
      for (int j = 0; j < data.length; j++) {
        if (GetSongs.songscopy[i].id == data[j]) {
          plsongs.add(GetSongs.songscopy[i]);
        }
      }
    }
    return plsongs;
  }
}
