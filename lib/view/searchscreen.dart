// import 'package:flutter/material.dart';

// import 'package:lottie/lottie.dart';

// import 'package:on_audio_query/on_audio_query.dart';
// import 'package:paatify/controller/getsongs.dart';
// import 'package:paatify/controller/provider/searchprovider.dart';
// import 'package:paatify/view/nowplaying.dart';
// import 'package:provider/provider.dart';

// class SearchScreen extends StatelessWidget {
//   SearchScreen({
//     Key? key,
//   }) : super(key: key);

//   late List<SongModel> allSong;

//   List<SongModel> song = [];

//   final audioQuery = OnAudioQuery();

//   @override
//   Widget build(BuildContext context) {
//     Provider.of<SearchProvider>(context, listen: false).allSongLoad();

//     return Scaffold(
//       backgroundColor: Colors.black87,
//       appBar: AppBar(
//         backgroundColor: Colors.black87,
//         toolbarHeight: 70,
//         title: Consumer<SearchProvider>(
//           builder: (context, value, child) {
//             return TextFormField(
//               onChanged: (song) => value.search(song),
//               style: const TextStyle(
//                 fontWeight: FontWeight.normal,
//               ),
//               decoration: InputDecoration(
//                 contentPadding: const EdgeInsets.fromLTRB(
//                   30.0,
//                   10.0,
//                   20.0,
//                   10.0,
//                 ),
//                 prefixIcon: const Icon(
//                   Icons.search,
//                 ),
//                 labelText: 'Search Now...',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(
//                     30,
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//       body: SingleChildScrollView(
//         physics: const ScrollPhysics(),
//         child: SafeArea(
//           child: Consumer<SearchProvider>(
//             builder: (context, value, child) {
//               return Column(
//                 children: [
//                   value.song.isNotEmpty
//                       ? ListView.builder(
//                           physics: const ScrollPhysics(),
//                           shrinkWrap: true,
//                           itemCount: song.length,
//                           itemBuilder: ((context, index) {
//                             return ListTile(
//                               title: Text(
//                                 value.song[index].displayNameWOExt,
//                                 maxLines: 1,
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               subtitle: Text(
//                                 '${value.song[index].artist}' == "<unknown>"
//                                     ? "Unknown Artist"
//                                     : '${song[index].artist}',
//                                 maxLines: 1,
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               leading: QueryArtworkWidget(
//                                 artworkBorder: BorderRadius.circular(
//                                   10,
//                                 ),
//                                 id: value.song[index].id,
//                                 type: ArtworkType.AUDIO,
//                                 nullArtworkWidget: Container(
//                                   width: 50,
//                                   height: 50,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(
//                                       10,
//                                     ),
//                                     color: Colors.amber,
//                                   ),
//                                   child: const Icon(Icons.music_note),
//                                 ),
//                               ),
//                               onTap: () {
//                                 GetSongs.player.setAudioSource(
//                                   GetSongs.createSongList(
//                                     value.song,
//                                   ),
//                                   initialIndex: index,
//                                 );
//                                 GetSongs.player.play();
//                                 Navigator.of(context).push(
//                                   MaterialPageRoute(
//                                     builder: ((context) {
//                                       return NowPlaying(
//                                         playerSong: value.song,
//                                       );
//                                     }),
//                                   ),
//                                 );
//                               },
//                             );
//                           }),
//                         )
//                       : Center(
//                           heightFactor: 1.5,
//                           child: LottieBuilder.asset(
//                             height: 300,
//                             'assets/lottie/73061-search-not-found.json',
//                           ),
//                         ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
              suffixIcon: Icon(Icons.cancel),
              prefixIcon: Icon(
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
                                nullArtworkWidget: const CircleAvatar(
                                  radius: 24,
                                  backgroundImage: AssetImage(
                                      'assets/images/music-1085655_960_720.png'),
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
                      : const Center(
                          heightFactor: 2.5,
                          child: Image(
                            image: AssetImage(
                              'assets/images/212-2129001_mobile-app-development-services-business-login-illustration-png.png',
                            ),
                            height: 220,
                            width: 220,
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
