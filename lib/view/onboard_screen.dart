import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paatify/controller/constant/const.dart';
import 'package:paatify/controller/provider/onboard_controller.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   Provider.of<OnboardController>(context, listen: false);
    // });
    var size2 = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            height: size2.height / 1,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/image/onboard_image.png",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset(
                    logo,
                    width: 204.92,
                    height: 46.71,
                    alignment: Alignment.topLeft,
                  ),
                  SizedBox(
                    height: size2.height / 3,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Consumer<OnboardController>(
                      builder: (context, value, child) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            text(
                              text: """Enjoy Your Favorite  Music""",
                              fontSize: 36,
                              ftWeight: FontWeight.bold,
                            ),
                            SizedBox(
                              height: size2.height / 12,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.0),
                                  color: HexColor("78B68D").withOpacity(0.53)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: TextFormField(
                                  style: const TextStyle(
                                      fontFamily: family,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  controller: value.nameController,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Enter Your Name",
                                    hintStyle: TextStyle(
                                        fontFamily: family,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size2.height / 12,
                            ),
                            InkWell(
                              onTap: () {
                                value.saveName(context);
                              },
                              child: Container(
                                width: size2.width / 1,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.0),
                                    color:
                                        HexColor("78B68D").withOpacity(0.53)),
                                child: Center(
                                  child: text(text: "Get Start"),
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
