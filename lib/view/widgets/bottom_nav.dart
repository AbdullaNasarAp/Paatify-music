import 'package:flutter/material.dart';
import 'package:paatify/controller/constant/const.dart';
import 'package:paatify/controller/getsongs.dart';

import 'package:paatify/controller/provider/bottumnavigationprovider.dart';
import 'package:paatify/view/allsongs.dart';
import 'package:paatify/view/favplaylist.dart';
import 'package:paatify/view/home/homescreen.dart';
import 'package:paatify/view/miniplayer.dart';
import 'package:paatify/view/searchscreen.dart';

import 'package:provider/provider.dart';

// ignore: must_be_immutable
class BottomScreens extends StatelessWidget {
  BottomScreens({Key? key}) : super(key: key);

  int currentIndex = 0;
  final screens = [
    HomeScreen(),
    AllSongs(),
    SearchScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BottumNavigationBarProvider>(context);
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(color: HexColor("151515")),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: IndexedStack(index: currentIndex, children: screens),
        bottomNavigationBar: Consumer<BottumNavigationBarProvider>(
          builder: (context, value, child) {
            return SingleChildScrollView(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (GetSongs.player.currentIndex != null)
                  const Column(
                    children: [
                      MiniPlayer(),
                      SizedBox(height: 10),
                    ],
                  )
                else
                  const SizedBox(),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  child: BottomNavigationBar(
                    elevation: 0,
                    backgroundColor: Colors.white24,
                    selectedItemColor: Colors.white,
                    selectedFontSize: 15,
                    unselectedItemColor: Colors.white,
                    selectedIconTheme: const IconThemeData(color: Colors.white),
                    showUnselectedLabels: false,
                    type: BottomNavigationBarType.fixed,
                    currentIndex: currentIndex,
                    onTap: (index) {
                      currentIndex = index;
                      provider.currentIndex = index;
                    },
                    items: const [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.music_note), label: 'Home'),
                      BottomNavigationBarItem(
                          icon: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Icon(Icons.list),
                          ),
                          label: 'All Songs'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.search), label: 'Search'),
                    ],
                  ),
                ),
              ],
            ));
          },
        ),
      ),
    );
  }
}
