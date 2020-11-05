import 'package:flutter/material.dart';
import '../common/common.dart';

class RouteUtil {
  static void goMain(BuildContext context) {
//    pushReplacementNamed(context, BaseConstant.routeMain);
    pushNamedAndRemoveUntil(context, BaseConstant.routeMain);
  }

  static void pushReplacementNamed(BuildContext context, String pageName) {
    Navigator.of(context).pushReplacementNamed(pageName);
  }

  static void pushNamedAndRemoveUntil(BuildContext context, String pageName) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(pageName, (route) => route == null);
  }
}
