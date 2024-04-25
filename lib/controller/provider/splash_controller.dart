import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends ChangeNotifier {
  bool _nameExists = false;
  String userNames = '';
  String firstName = '';

  bool get nameExists => _nameExists;

  Future<void> checkIfNameExists() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userName = prefs.getString('userName');
    userNames = userName ?? 'Bro';
    _nameExists = userName != null && userName.isNotEmpty;

    log("$userName");
    notifyListeners();
  }

  String extractFirstName(String fullName) {
    List<String> nameParts = fullName.split(' ');
    if (nameParts.isNotEmpty) {
      return nameParts.first;
    } else {
      return fullName;
    }
  }
}
