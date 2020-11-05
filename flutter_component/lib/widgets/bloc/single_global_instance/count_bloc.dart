import 'package:flutter/material.dart';
import 'dart:async';

class SingleCountBlc {
  int _count = 0;
  var _countController = StreamController<int>.broadcast();

  Stream<int> get stream => _countController.stream;
  int get value => _count;

  increment() {
    _countController.add(++_count);
  }


  dispose() {
    _countController.close();
  }
}

SingleCountBlc bloc = SingleCountBlc();

