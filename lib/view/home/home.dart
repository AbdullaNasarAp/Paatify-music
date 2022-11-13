import 'package:flutter/material.dart';

//Custom Text
class TExt extends StatelessWidget {
  final String teXt;
  const TExt({
    Key? key,
    required this.teXt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      teXt,
      style: const TextStyle(
        fontFamily: 'Segoe UI',
        fontSize: 18,
        fontWeight: FontWeight.w300,
      ),
      maxLines: 1,
    );
  }
}

//Custom SubText
class Sub extends StatelessWidget {
  final String sub;
  const Sub({
    Key? key,
    required this.sub,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      sub,
      style: const TextStyle(
          fontFamily: 'Segoe UI', fontSize: 15, fontWeight: FontWeight.w300),
      maxLines: 1,
    );
  }
}
