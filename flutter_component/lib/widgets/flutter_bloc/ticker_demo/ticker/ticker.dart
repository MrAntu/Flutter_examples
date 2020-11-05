import 'package:flutter/material.dart';

class Ticker {
  Stream<int> ticker() {
    return Stream.periodic(Duration(seconds: 1), (x) => x).take(10);
  }
}
