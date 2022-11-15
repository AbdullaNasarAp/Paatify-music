import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:paatify/controller/getsongs.dart';
import 'package:paatify/controller/provider/searchprovider.dart';
import 'package:paatify/view/nowplaying.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Provider.of<SearchProvider>(context, listen: false).allSongLoad();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        title: Consumer<SearchProvider>(
          builder: (context, value, child) {
            return CupertinoSearchTextField(
              suffixIcon: const Icon(
                Icons.cancel,
                size: 20,
                color: Colors.white,
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.white,
                size: 30,
              ),
              backgroundColor: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
              itemColor: Colors.black,
              controller: searchController,
              onChanged: (song) {
                value.search(song);
              },
            );
          },
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: SafeArea(
          child: Consumer<SearchProvider>(
            builder: (context, value, child) {
              return Column(
                children: [
                  value.song.isNotEmpty
                      ? ListView.builder(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                value.song[index].displayNameWOExt,
                                maxLines: 1,
                                style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Text(
                                " ${value.song[index].artist}",
                                maxLines: 1,
                                style: GoogleFonts.montserrat(
                                  fontSize: 13,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              leading: QueryArtworkWidget(
                                id: value.song[index].id,
                                type: ArtworkType.AUDIO,
                                nullArtworkWidget: CircleAvatar(
                                  backgroundColor: Colors.white24,
                                  radius: 30,
                                  child: Lottie.asset(
                                    'assets/listnull.json',
                                    height: 200,
                                    width: 200,
                                  ),
                                ),
                              ),
                              onTap: () {
                                GetSongs.player.setAudioSource(
                                  GetSongs.createSongList(value.song),
                                  initialIndex: index,
                                );
                                GetSongs.player.play();
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: ((context) {
                                      return NowPlaying(
                                        playerSong: value.song,
                                        //index: index,
                                      );
                                    }),
                                  ),
                                );
                              },
                            );
                          },
                          itemCount: value.song.length,
                        )
                      : Center(
                          heightFactor: 2.5,
                          child: Column(
                            children: [
                              Lottie.asset(
                                "assets/repRmRA5JM.json",
                                height: 265,
                                width: 365,
                              ),
                              Text(
                                "No Songs Found",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
