import 'package:flutter/material.dart';

class BottumNavigationBarProvider with ChangeNotifier {
  int _currentIndex = 0;
  get currentIndex => _currentIndex;
  set currentIndex(index) {
    _currentIndex = index;
    notifyListeners();
  }
}
