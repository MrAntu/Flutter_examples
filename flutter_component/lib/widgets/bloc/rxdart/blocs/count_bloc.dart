import 'package:flutter/material.dart';

abstract class CountBloc {
  Stream<int> get stream;
  int get value;
  void increment();
  void dispose();
}