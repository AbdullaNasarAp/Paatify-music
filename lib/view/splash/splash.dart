import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  final String title;

  const CustomTextWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 25.0,
        fontFamily: 'Segoe UI',
      ),
    );
  }
}
