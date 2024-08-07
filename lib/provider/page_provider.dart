import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class PageProvider extends ChangeNotifier {
  int _pageNow = 0;

  // Getters
  int get pageNow => _pageNow;

  // Setters
  void setPageNow(int value) {
    _pageNow = value;
    notifyListeners();
  }

}