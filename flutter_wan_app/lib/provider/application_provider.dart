import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ApplicationProvider extends ChangeNotifier {
  var _changeLanguage = BehaviorSubject<int>();
  BehaviorSubject<int> get changeLanguage => _changeLanguage;

  sendEvent(int value) {
    _changeLanguage.add(value);
    notifyListeners();
  }

  @override
  void dispose() {
    _changeLanguage.close();
    // TODO: implement dispose
    super.dispose();
  }
}
