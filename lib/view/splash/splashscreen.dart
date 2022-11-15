import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:paatify/controller/constant/const.dart';
import 'package:page_transition/page_transition.dart';
import '../widgets/bottom_nav.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashIconSize: 300,
      splash: SizedBox(
        child: Center(
          child: Image.asset(
            logo,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      nextScreen: BottomScreens(),
      duration: 2000,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.rightToLeft,
      animationDuration: const Duration(seconds: 1),
    );
  }
}
