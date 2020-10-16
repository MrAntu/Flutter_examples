import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomTabberIndexProvider extends ChangeNotifier {
  int currentIndex = 0;

  changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

}
