import 'package:flutter/material.dart';

const logo = 'assets/image/logo.svg';
const ground = "assets/image/SplashScreen.png";
const music = "assets/image/download1 1.png";
const family = 'LexendZetta-Regular';
const misi = "assets/image/J-Balvin-Bad-Bunny-Oasis 5.png";

const imag1 = "assets/image/grid.png";
const imag2 = "assets/image/playlistimg.png";
// const imag3 = "assets/image/300_album_80039 3.png";
// const imag4 = "assets/image/Component 1.png";

class HexColor extends Color {
  static int _getColorFromHeXColor(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHeXColor(hexColor));
}

Widget text({
  required String text,
  double fontSize = 16.0,
  Color color = Colors.white,
  TextAlign textAlign = TextAlign.start,
  String ftfamily = family,
  FontWeight ftWeight = FontWeight.normal,
  int mLines = 1,
  TextOverflow oflow = TextOverflow.ellipsis,
}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: mLines,
    overflow: oflow,
    style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontFamily: ftfamily,
        fontWeight: ftWeight),
  );
}
