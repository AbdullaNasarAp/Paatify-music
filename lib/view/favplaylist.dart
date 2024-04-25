import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:paatify/controller/constant/const.dart';
import 'package:paatify/view/favourite/favorites.dart';
import 'package:paatify/view/playlist/playlist.dart';

class FavPlayList extends StatelessWidget {
  const FavPlayList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("151515"),
      body: const SafeArea(
          child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Center(child: Grid()),
      )),
    );
  }
}

class Grid extends StatelessWidget {
  const Grid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 154 / 124),
      itemBuilder: (BuildContext context, index) {
        return GridTile(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(gridImage[index]),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(20),
              color: Colors.white24,
            ),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => gridIndex[index],
                    ));
              },
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(gridIcons[index]),
                    const SizedBox(
                      width: 10,
                    ),
                    text(
                        text: gridText[index],
                        color: Colors.white,
                        fontSize: 13,
                        ftWeight: FontWeight.bold),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      itemCount: 2,
    );
  }
}

List gridIndex = [
  const Favorites(),
  PlayListSc(),
];
final List gridImage = [
  imag1,
  imag2,
];
final List<String> gridIcons = [
  "assets/image/favicon.svg",
  "assets/image/playlist.svg",
];
final List gridText = [
  "Favorites",
  "PlayList",
];
