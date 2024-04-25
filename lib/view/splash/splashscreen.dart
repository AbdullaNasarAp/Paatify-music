import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paatify/controller/constant/const.dart';
import 'package:paatify/controller/provider/splash_controller.dart';
import 'package:paatify/view/onboard_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../widgets/bottom_nav.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SplashController>(
      builder: (context, splashController, child) {
        return FutureBuilder(
          future: splashController.checkIfNameExists(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return AnimatedSplashScreen(
                splashIconSize: MediaQuery.of(context).size.height / 1.1,
                splash: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Center(
                        child: SvgPicture.asset("assets/image/logo.svg"),
                      ),
                    ),
                    text(text: 'Endless Music'),
                  ],
                ),
                backgroundColor: HexColor("151515"),
                nextScreen: splashController.nameExists
                    ? BottomScreens()
                    : const OnboardingScreen(),
                duration: 2000,
                splashTransition: SplashTransition.fadeTransition,
                pageTransitionType: PageTransitionType.rightToLeft,
                animationDuration: const Duration(seconds: 1),
              );
            } else {
              return splashController.nameExists
                  ? BottomScreens()
                  : const OnboardingScreen();
            }
          },
        );
      },
    );
  }
}
