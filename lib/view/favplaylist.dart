import 'package:flutter/material.dart';

import 'package:paatify/view/constant/const.dart';
import 'package:paatify/view/favourite/favorites.dart';
import 'package:paatify/view/playlist/playlist.dart';

class FavPlayList extends StatelessWidget {
  const FavPlayList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
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
          childAspectRatio: 2.10 / 2.10,
          maxCrossAxisExtent: 200,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
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
            height: 100,
            width: 100,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => gridIndex[index],
                    ));
              },
              child: Center(
                  child: Text(
                gridText[index],
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                    fontFamily: 'Segoe UI',
                    fontWeight: FontWeight.bold),
              )),
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
final List gridText = [
  "Favorites",
  "PlayList",
];
