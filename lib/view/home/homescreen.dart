import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:paatify/controller/provider/favoritepro/favoriteprovider.dart';
import 'package:paatify/controller/provider/homeprovider.dart';
import 'package:paatify/controller/provider/splash_controller.dart';
import 'package:paatify/model/database.dart/favouriteDb.dart';
import 'package:paatify/controller/constant/const.dart';
import 'package:paatify/controller/getsongs.dart';
import 'package:paatify/view/allsongs.dart';
import 'package:paatify/view/favplaylist.dart';
import 'package:paatify/view/nowplaying.dart';
import 'package:paatify/view/favourite/favoritebut.dart';
import 'package:paatify/view/home/home.dart';
import 'package:paatify/view/playlist/playlist.dart';
import 'package:paatify/view/settings/settings.dart';
import 'package:paatify/view/splash/splash.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    Key? key,
  }) : super(key: key);
  static List<SongModel> plYsong = [];

  final _audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<HomeProvider>(context, listen: false).requestPermission();
    });
    return Consumer3<HomeProvider, SplashController, FavoritesProvider>(
      builder: (context, value, splashController, favProvider, child) {
        final favoritesProvider = Provider.of<FavoritesProvider>(context);
        return Scaffold(
          backgroundColor: HexColor("151515"),
          appBar: AppBar(
            backgroundColor: HexColor("151515"),
            title: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextWidget(
                    title:
                        "Hi ${splashController.extractFirstName(splashController.userNames)} ",
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsDrawer(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.settings,
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                  child: favoritesProvider.favoriteSongs.isEmpty
                      ? const FavPlayList()
                      : Container(
                          color: Colors.greenAccent,
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height,
                          child: const Center(
                            child: Text(
                              'We have favorite songs',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 10),
                //   child: FutureBuilder<List<SongModel>>(
                //     future: _audioQuery.querySongs(
                //         sortType: null,
                //         orderType: OrderType.ASC_OR_SMALLER,
                //         uriType: UriType.EXTERNAL,
                //         ignoreCase: true),
                //     builder: (context, item) {
                //       if (item.data == null) {
                //         return const Center(
                //           child: CircularProgressIndicator(),
                //         );
                //       } else if (item.data!.isEmpty) {
                //         return Center(
                //           child: text(
                //             text: 'No Songs Found',
                //             fontSize: 13,
                //           ),
                //         );
                //       } else {
                //         return Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             CarouselSlider.builder(
                //               itemBuilder: (
                //                 BuildContext context,
                //                 int itemIndex,
                //                 int pageViewIndex,
                //               ) =>
                //                   GestureDetector(
                //                 onTap: () {
                //                   GetSongs.player.setAudioSource(
                //                       GetSongs.createSongList(item.data!),
                //                       initialIndex: itemIndex);
                //                   GetSongs.player.play();
                //                   Provider.of<HomeProvider>(context)
                //                       .notifyListeners();
                //                   Navigator.push(
                //                     context,
                //                     MaterialPageRoute(
                //                       builder: (context) => NowPlaying(
                //                         playerSong: item.data!,
                //                       ),
                //                     ),
                //                   );
                //                 },
                //                 child: Column(
                //                   mainAxisAlignment: MainAxisAlignment.end,
                //                   children: [
                //                     QueryArtworkWidget(
                //                       keepOldArtwork: true,
                //                       quality: 100,
                //                       id: item.data![itemIndex].id,
                //                       type: ArtworkType.AUDIO,
                //                       nullArtworkWidget: CircleAvatar(
                //                         backgroundColor: Colors.white24,
                //                         radius: 30,
                //                         child: Lottie.asset(
                //                           'assets/listnull.json',
                //                           height: 200,
                //                           width: 200,
                //                         ),
                //                       ),
                //                       artworkBorder: const BorderRadius.all(
                //                         Radius.circular(
                //                           10,
                //                         ),
                //                       ),
                //                       artworkWidth:
                //                           MediaQuery.of(context).size.width *
                //                               0.3,
                //                       artworkHeight: 65,
                //                     ),
                //                     text(
                //                         text: item
                //                             .data![itemIndex].displayNameWOExt,
                //                         fontSize: 11),
                //                     Text(
                //                       "${item.data![itemIndex].artist}",
                //                       style: const TextStyle(
                //                           fontSize: 13, fontFamily: 'Segoe UI'),
                //                       maxLines: 1,
                //                       overflow: TextOverflow.fade,
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //               options: CarouselOptions(
                //                 aspectRatio: 16 / 90,
                //                 height: 155,
                //                 viewportFraction: 0.4,
                //                 autoPlay: true,
                //                 autoPlayCurve: Curves.easeInQuint,
                //                 enlargeCenterPage: true,
                //               ),
                //               itemCount: item.data!.length,
                //             ),
                //           ],
                //         );
                //       }
                //     },
                //   ),
                // ),

                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: FutureBuilder<List<SongModel>>(
                    future: _audioQuery.querySongs(
                        sortType: null,
                        orderType: OrderType.ASC_OR_SMALLER,
                        uriType: UriType.EXTERNAL,
                        ignoreCase: true),
                    builder: (context, item) {
                      if (item.data == null) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (item.data!.isEmpty) {
                        return const Center(
                            child: Text(
                          'No Songs Found',
                        ));
                      }
                      AllSongs.plaYsong = item.data!;
                      if (!FavoriteDB.isIntialized) {
                        FavoriteDB.intialize(item.data!);
                      }

                      GetSongs.songscopy = item.data!;
                      return ListView.separated(
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(9),
                                color: HexColor("78B68D").withOpacity(0.53),
                              ),
                              width: 372,
                              height: 82,
                              child: ListTile(
                                horizontalTitleGap: 20,
                                leading: Container(
                                  width: 64,
                                  height: 61,
                                  decoration: BoxDecoration(
                                      color: HexColor("151515"),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: QueryArtworkWidget(
                                    keepOldArtwork: true,
                                    id: item.data![index].id,
                                    type: ArtworkType.AUDIO,
                                    nullArtworkWidget: Container(
                                        width: 64,
                                        height: 61,
                                        decoration: BoxDecoration(
                                            color: HexColor("151515"),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Image.asset(
                                            "assets/image/basic.png")),
                                    artworkWidth: 50,
                                    artworkHeight: 50,
                                    artworkBorder: BorderRadius.circular(0),
                                  ),
                                ),
                                onTap: () {
                                  GetSongs.player.setAudioSource(
                                      GetSongs.createSongList(item.data!),
                                      initialIndex: index);
                                  GetSongs.player.play();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NowPlaying(
                                        playerSong: item.data!,
                                      ),
                                    ),
                                  );

                                  FavoriteDB.favoriteSongs.notifyListeners();
                                },
                                title: text(
                                    text: item.data![index].displayNameWOExt,
                                    fontSize: 11),
                                subtitle: text(
                                    text: "${item.data![index].artist}",
                                    fontSize: 9),
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
                                                builder: (context) =>
                                                    PlayListSc(),
                                              ),
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.playlist_add,
                                            color: Colors.white,
                                          ),
                                          label: const Text(
                                            "Add To PLayList",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ];
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: item.data!.length,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
