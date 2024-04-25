import 'package:flutter/material.dart';
import 'package:paatify/controller/constant/const.dart';

class CustomTextWidget extends StatelessWidget {
  final String title;

  const CustomTextWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return text(
      text: title,
      ftWeight: FontWeight.w900,
      fontSize: 17.0,
    );
  }
}
