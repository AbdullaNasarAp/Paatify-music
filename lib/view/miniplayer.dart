import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:paatify/controller/getsongs.dart';
import 'package:paatify/controller/provider/miniplayerprovider.dart';
import 'package:paatify/view/nowplaying.dart';
import 'package:provider/provider.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<MiniPlayerProvider>(context, listen: false).mountedfun();
    });
    return Consumer<MiniPlayerProvider>(
      builder: (context, value, child) {
        return ListTile(
          tileColor: Colors.black87,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => NowPlaying(
                  playerSong: GetSongs.playingSongs,
                ),
              ),
            );
          },
          textColor: const Color.fromARGB(255, 255, 255, 255),
          leading: CircleAvatar(
            radius: 30,
            child: QueryArtworkWidget(
              artworkQuality: FilterQuality.high,
              artworkFit: BoxFit.fill,
              artworkBorder: BorderRadius.circular(0),
              nullArtworkWidget: Lottie.asset('assets/nullartwork.json'),
              id: GetSongs.playingSongs[GetSongs.player.currentIndex!].id,
              type: ArtworkType.AUDIO,
            ),
          ),
          title: Text(
            GetSongs
                .playingSongs[GetSongs.player.currentIndex!].displayNameWOExt,
            maxLines: 1,
            overflow: TextOverflow.fade,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          subtitle: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              "${GetSongs.playingSongs[GetSongs.player.currentIndex!].artist}",
              maxLines: 1,
              overflow: TextOverflow.fade,
              style: const TextStyle(
                  fontSize: 11, overflow: TextOverflow.ellipsis),
            ),
          ),
          trailing: FittedBox(
            fit: BoxFit.fill,
            child: Row(
              children: [
                IconButton(
                    onPressed: () async {
                      if (GetSongs.player.hasPrevious) {
                        await GetSongs.player.seekToPrevious();
                        await GetSongs.player.play();
                      } else {
                        await GetSongs.player.play();
                      }
                    },
                    icon: const Icon(
                      Icons.skip_previous_sharp,
                      color: Colors.white,
                      size: 35,
                    )),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    shape: const CircleBorder(),
                  ),
                  onPressed: () async {
                    if (GetSongs.player.playing) {
                      await GetSongs.player.pause();
                      Provider.of<MiniPlayerProvider>(context, listen: false)
                          .notifyListeners();
                    } else {
                      await GetSongs.player.play();
                      Provider.of<MiniPlayerProvider>(context, listen: false)
                          .notifyListeners();
                    }
                  },
                  child: StreamBuilder<bool>(
                    stream: GetSongs.player.playingStream,
                    builder: (context, snapshot) {
                      bool? playingStage = snapshot.data;
                      if (playingStage != null && playingStage) {
                        return const Icon(
                          Icons.pause,
                          color: Colors.white,
                          size: 35,
                        );
                      } else {
                        return const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 35,
                        );
                      }
                    },
                  ),
                ),
                IconButton(
                    onPressed: (() async {
                      if (GetSongs.player.hasNext) {
                        await GetSongs.player.seekToNext();
                        await GetSongs.player.play();
                      } else {
                        await GetSongs.player.play();
                      }
                    }),
                    icon: const Icon(
                      Icons.skip_next_sharp,
                      color: Colors.white,
                      size: 35,
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}
