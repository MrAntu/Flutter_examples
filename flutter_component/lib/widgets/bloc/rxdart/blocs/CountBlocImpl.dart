import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'count_bloc.dart';

class CountBlocImpl implements CountBloc {
  int _count = 0;
  var _subject = BehaviorSubject<int>();

  @override
  void dispose() {
    // TODO: implement dispose
    _subject.close();
  }

  @override
  void increment() {
    // TODO: implement increment
    ++_count;
    _subject.add(_count);
  }

  @override
  // TODO: implement stream
  Stream<int> get stream => _subject.stream;

  @override
  // TODO: implement value
  int get value => _count;

}