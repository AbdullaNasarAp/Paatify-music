import 'package:flutter/material.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:paatify/controller/getsongs.dart';
import 'package:paatify/model/database.dart/favouriteDb.dart';
import 'package:paatify/view/allsongs.dart';
import 'package:paatify/view/favplaylist.dart';
import 'package:paatify/view/miniplayer.dart';
import 'package:paatify/view/searchscreen.dart';

import '../home/homescreen.dart';

class BottomScreens extends StatefulWidget {
  const BottomScreens({Key? key}) : super(key: key);

  @override
  State<BottomScreens> createState() => _BottomScreensState();
}

class _BottomScreensState extends State<BottomScreens> {
  int Index = 0;
  final screens = [
    const HomeScreen(),
    const AllSongs(),
    const SearchBar(),
    const FavPlayList(),
  ];
  @override
  Widget build(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    return Scaffold(
      body: IndexedStack(index: Index, children: screens),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: FavoriteDB.favoriteSongs,
        builder: (BuildContext context, List<SongModel> music, Widget? child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (GetSongs.player.currentIndex != null)
                Column(
                  children: const [
                    MiniPlayer(),
                  ],
                )
              else
                const SizedBox(),
              NavigationBar(
                elevation: 0,
                height: 75,
                labelBehavior:
                    NavigationDestinationLabelBehavior.onlyShowSelected,
                selectedIndex: Index,
                animationDuration: const Duration(seconds: 2),
                onDestinationSelected: (index) =>
                    setState(() => this.Index = index),
                destinations: const [
                  NavigationDestination(
                    icon: Icon(
                      Icons.home_outlined,
                    ),
                    selectedIcon: Icon(
                      Icons.home,
                      color: Color.fromARGB(255, 221, 221, 221),
                    ),
                    label: 'Home',
                  ),
                  NavigationDestination(
                    icon: Icon(
                      Icons.album_outlined,
                    ),
                    selectedIcon: Icon(
                      Icons.album,
                      color: Color.fromARGB(255, 221, 221, 221),
                    ),
                    label: 'All Songs',
                  ),
                  NavigationDestination(
                    icon: Icon(
                      Icons.search_outlined,
                    ),
                    selectedIcon: Icon(
                      Icons.search,
                      color: Color.fromARGB(255, 221, 221, 221),
                    ),
                    label: 'Search',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.library_music_outlined),
                    selectedIcon: Icon(
                      Icons.library_music,
                      color: Color.fromARGB(255, 221, 221, 221),
                    ),
                    label: 'Settings',
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
