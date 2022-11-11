import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:paatify/controller/getsongs.dart';
import 'package:paatify/model/database.dart/playlistdb.dart';
import 'package:paatify/view/settings/aboutus.dart';
import 'package:paatify/view/settings/sharefile.dart';
import 'package:paatify/view/settings/termandpolicy.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    {
      return Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.black87,
          title: const Center(
            child: Text(
              "Settings",
              style: TextStyle(fontSize: 25),
            ),
          ),
        ),
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const SizedBox(height: 100),
              SettingsTile(
                ontap: () {
                  _email();
                },
                text1: "FeedBack",
                icon: FontAwesomeIcons.solidMessage,
              ),
              SettingsTile(
                text1: "Share This App ",
                icon: FontAwesomeIcons.share,
                ontap: () {
                  shareFile(context);
                },
              ),
              SettingsTile(
                  text1: "Privacy&Policy",
                  icon: FontAwesomeIcons.lock,
                  ontap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TermsAndPolicy(),
                      ),
                    );
                  }),
              SettingsTile(
                text1: "Rate This App",
                icon: FontAwesomeIcons.star,
                ontap: () {},
              ),
              SettingsTile(
                  text1: "Reset App",
                  icon: FontAwesomeIcons.arrowRotateLeft,
                  ontap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                20.0,
                              ),
                            ),
                            title: const Text('Reset App'),
                            content: const Text(
                              'Are you sure you want to reset the app?',
                            ),
                            actions: [
                              Column(
                                children: [
                                  Center(
                                    child: Lottie.asset(
                                      "assets/lf30_editor_q2gqmhce.json",
                                      width: 100,
                                      height: 100,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    child: const Text('Cancel'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Reset'),
                                    onPressed: () {
                                      PlayListDB.resetAPP(
                                        context,
                                      );
                                      GetSongs.player.stop();
                                    },
                                  ),
                                ],
                              ),
                            ],
                          );
                        });
                  }),
              SettingsTile(
                  text1: "About ",
                  icon: FontAwesomeIcons.userGear,
                  ontap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AboutUs(),
                      ),
                    );
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'v.1.0.0',
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }
  }

  Future<void> _email() async {
    // ignore: deprecated_member_use
    if (await launch('mailto:abdulla034nasat@gamil.com')) {
      throw "Try Again";
    }
  }
}

class SettingsTile extends StatelessWidget {
  String text1;
  IconData icon;
  final void Function() ontap;

  SettingsTile({
    super.key,
    required this.text1,
    required this.icon,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white24,
        ),
        height: 70,
        width: double.infinity,
        child: ListTile(
          iconColor: Colors.white,
          textColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: FaIcon(icon),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              text1,
              style: const TextStyle(
                fontSize: 17,
              ),
            ),
          ),
          onTap: ontap,
        ),
      ),
    );
  }
}
