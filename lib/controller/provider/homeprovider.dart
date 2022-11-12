import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeProvider with ChangeNotifier {
  void requestPermission() async {
    await Permission.storage.request();
    notifyListeners();
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
