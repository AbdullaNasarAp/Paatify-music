import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:paatify/controller/constant/const.dart';
import 'package:paatify/view/home/homescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardController extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  Future<void> saveName(BuildContext context) async {
    String name = nameController.text.trim();

    if (name.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userName', name);
      print(name);
      log(name);
      Future.delayed(
        const Duration(microseconds: 300),
        () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
              (route) => false);
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: text(text: 'Error'),
          content: text(text: 'Please enter your name.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: text(text: 'OK'),
            ),
          ],
        ),
      );
    }
    notifyListeners();
  }
}
