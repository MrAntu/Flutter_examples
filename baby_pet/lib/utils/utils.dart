import 'package:flutter/material.dart';

class Utils {
  static String getImgPath(String name, {String format: 'png'}) {
    return 'resource/images/$name.$format';
  }
}
