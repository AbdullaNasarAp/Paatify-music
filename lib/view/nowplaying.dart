import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:paatify/controller/getsongs.dart';
import 'package:lottie/lottie.dart';
import 'package:paatify/screens/favourite/favorbut.dart';

class NowPlaying extends StatefulWidget {
  const NowPlaying({
    super.key,
    required this.playerSong,
  });
  final List<SongModel> playerSong;

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  Duration _duration = const Duration();
  Duration _position = const Duration();
  bool shuffle = false;
  bool _isPlaying = true;
  int currentIndex = 0;

  @override
  void initState() {
    GetSongs.player.currentIndexStream.listen((index) {
      if (index != null && mounted) {
        setState(() {
          currentIndex = index;
        });
        GetSongs.currentIndes = index;
      }
    });
    super.initState();
    playSong();
  }

  void playSong() {
    GetSongs.player.durationStream.listen((d) {
      setState(() {
        _duration = d!;
      });
    });
    GetSongs.player.positionStream.listen((p) {
      setState(() {
        _position = p;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FavoritBut(song: widget.playerSong[currentIndex]),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * .75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: QueryArtworkWidget(
                  keepOldArtwork: true,
                  quality: 100,
                  artworkWidth: MediaQuery.of(context).size.width,
                  artworkHeight: MediaQuery.of(context).size.height,
                  artworkBorder: BorderRadius.circular(100),
                  id: widget.playerSong[currentIndex].id,
                  type: ArtworkType.AUDIO,
                  nullArtworkWidget: Lottie.asset("assets/nullartwork.json"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text(
                widget.playerSong[currentIndex].displayNameWOExt,
                textAlign: TextAlign.center,
                maxLines: 1,
                style: const TextStyle(
                  fontFamily: 'Segoe UI',
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
                overflow: TextOverflow.fade,
              ),
            ),
            Text(
              textAlign: TextAlign.center,
              maxLines: 1,
              // "${widget.songModel.artist}",

              widget.playerSong[currentIndex].artist.toString() == "<unknown>"
                  ? "Unknown Artist"
                  : widget.playerSong[currentIndex].artist.toString(),
              style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 20.0,
                  fontFamily: 'Segoe UI'),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    _position.toString().split(".")[0],
                    style: const TextStyle(),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .1,
                ),
                Expanded(
                  child: Slider(
                    min: const Duration(microseconds: 0).inSeconds.toDouble(),
                    value: _position.inSeconds.toDouble(),
                    max: _duration.inSeconds.toDouble(),
                    onChanged: (value) {
                      setState(() {
                        changeToSeconds(value.toInt());
                        value = value;
                      });
                    },
                    thumbColor: Colors.blue,
                    activeColor: Colors.blue,
                    inactiveColor: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(_duration.toString().split(".")[0],
                      style: const TextStyle(color: Colors.white)),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    GetSongs.player.loopMode == LoopMode.one
                        ? GetSongs.player.setLoopMode(LoopMode.all)
                        : GetSongs.player.setLoopMode(LoopMode.one);
                  },
                  icon: const Icon(Icons.repeat),
                ),
                RawMaterialButton(
                  onPressed: () async {
                    if (GetSongs.player.hasPrevious) {
                      await GetSongs.player.seekToPrevious();
                      await GetSongs.player.play();
                    } else {
                      await GetSongs.player.play();
                    }
                  },
                  elevation: 5.0,
                  fillColor: Colors.blue,
                  padding: const EdgeInsets.all(10.0),
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.skip_previous_sharp,
                    size: 30.0,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      primary: Colors.black,
                      onPrimary: Colors.blue),
                  onPressed: () async {
                    if (GetSongs.player.playing) {
                      await GetSongs.player.pause();
                      setState(() {});
                    } else {
                      await GetSongs.player.play();
                      setState(() {});
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
                          size: 50,
                        );
                      } else {
                        return const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 50,
                        );
                      }
                    },
                  ),
                ),
                RawMaterialButton(
                  onPressed: () async {
                    if (GetSongs.player.hasPrevious) {
                      await GetSongs.player.seekToNext();
                      await GetSongs.player.play();
                    } else {
                      await GetSongs.player.play();
                    }
                  },
                  elevation: 2.0,
                  fillColor: Colors.blue,
                  padding: const EdgeInsets.all(10.0),
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.skip_next,
                    size: 30,
                  ),
                ),

                // RawMaterialButton(
                //   onPressed: () {
                //     shuffle == false
                //         ? GetSongs.player.setShuffleModeEnabled(true)
                //         : GetSongs.player.setShuffleModeEnabled(false);

                //     const ScaffoldMessenger(
                //         child: SnackBar(content: Text('Shuffle Enabled')));
                //   },
                //   child: StreamBuilder<bool>(
                //       stream: GetSongs.player.shuffleModeEnabledStream,
                //       builder: (context, AsyncSnapshot snapshot) {
                //         shuffle = snapshot.data;
                //         if (shuffle) {
                //           return const Icon(
                //             Icons.shuffle,
                //             color: Colors.blue,
                //           );
                //         } else {
                //           return const Icon(
                //             Icons.shuffle,
                //             color: Colors.white,
                //           );
                //         }
                //       }),
                // ),
                IconButton(
                  onPressed: () {
                    shuffle == false
                        ? GetSongs.player.setShuffleModeEnabled(true)
                        : GetSongs.player.setShuffleModeEnabled(false);
                  },
                  icon: const Icon(
                    Icons.shuffle,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .03,
            ),
          ],
        ),
      ),
    );
  }

  void changeToSeconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    GetSongs.player.seek(duration);
  }
}
