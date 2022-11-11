import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:paatify/constant/const.dart';
import 'package:paatify/controller/getsongs.dart';
import 'package:paatify/database.dart/favouritedb.dart';
import 'package:paatify/screens/allsongs.dart';
import 'package:paatify/screens/nowplaying.dart';
import 'package:paatify/screens/favourite/favoritebut.dart';
import 'package:paatify/screens/home/home.dart';
import 'package:paatify/screens/playlist/playlist.dart';
import 'package:paatify/screens/settings/settings.dart';
import 'package:paatify/screens/splash/splash.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);
  static List<SongModel> plYsong = [];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _audioQuery = OnAudioQuery();
  @override
  void initState() {
    requestPermission();

    super.initState();
  }

  void requestPermission() async {
    if (!kIsWeb) {
      bool permissionStatus = await _audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await _audioQuery.permissionsRequest();
      }
      setState(() {});
    }
    Permission.storage.request;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
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
                      ),
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const CustomTextWidget(title: "What's New "),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SettingsDrawer(),
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
                        CarouselSlider.builder(
                          itemBuilder: (
                            BuildContext context,
                            int itemIndex,
                            int pageViewIndex,
                          ) =>
                              GestureDetector(
                            onTap: () {
                              GetSongs.player.setAudioSource(
                                  GetSongs.createSongList(item.data!),
                                  initialIndex: itemIndex);
                              GetSongs.player.play();
                              setState(() {});

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NowPlaying(
                                    playerSong: item.data!,
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                QueryArtworkWidget(
                                  keepOldArtwork: true,
                                  quality: 100,
                                  id: item.data![itemIndex].id,
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
                                  artworkBorder: const BorderRadius.all(
                                    Radius.circular(
                                      10,
                                    ),
                                  ),
                                  artworkWidth:
                                      MediaQuery.of(context).size.width * 0.3,
                                  artworkHeight: 65,
                                ),
                                Text(
                                  item.data![itemIndex].displayNameWOExt,
                                  style: const TextStyle(
                                    fontFamily: family,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                ),
                                Text(
                                  "${item.data![itemIndex].artist}",
                                  style: const TextStyle(
                                      fontSize: 13, fontFamily: 'Segoe UI'),
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                ),
                              ],
                            ),
                          ),
                          options: CarouselOptions(
                            aspectRatio: 16 / 90,
                            height: 155,
                            viewportFraction: 0.4,
                            autoPlay: true,
                            autoPlayCurve: Curves.easeInQuint,
                            enlargeCenterPage: true,
                          ),
                          itemCount: 10,
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
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
                  return ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => ListTile(
                      horizontalTitleGap: 20,
                      leading: QueryArtworkWidget(
                        keepOldArtwork: true,
                        id: item.data![index].id,
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
                        artworkWidth: 50,
                        artworkHeight: 50,
                        artworkBorder: BorderRadius.circular(0),
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
                      title: TExt(teXt: item.data![index].displayNameWOExt),
                      subtitle: Sub(sub: "${item.data![index].artist}"),
                      trailing: PopupMenuButton(
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              value: 1,
                              child: Row(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      FavoriteBut(
                                        song: HomeScreen.plYsong[index],
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        FavoriteBut(
                                          song: HomeScreen.plYsong[index],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: 1,
                              child: Row(
                                children: [
                                  TextButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const PlayListSc(),
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
                                ],
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
          ],
        ),
      ),
    );
  }
}
