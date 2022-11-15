import 'package:flutter/material.dart';
import 'package:paatify/controller/constant/const.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: [
            Image.asset(
              logo,
              height: 100,
              width: 100,
            ),
            const SizedBox(
              height: 100,
            ),
            const Center(
              child: Text(
                """
Welcome to Paatify Endless Music, 

your number one source for all things Music. We're dedicated to providing you the best of Music, with a focus on dependability. customer service,.

We're working to turn our passion for music into a booming Music Player. We hope you enjoy our Music as much as we enjoy offering them to you.


Sincerely,

Abdulla Nasar

""",
                style: TextStyle(fontSize: 15),
              ),
            )
          ],
        ),
      )),
    );
  }
}
