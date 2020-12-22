import 'package:baby_pet/utils/route/routes.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'route/application.dart';
export 'route/routes.dart';

class RouteUtil {
  static void pop<T>(BuildContext context, [T result]) {
    Application.router.pop(context, result);
  }

  static void pushMainRoot(BuildContext context) {
    pushAndRemoveUntil(
      context,
      Routes.home,
    );
  }

  static void pushToRoot(BuildContext context) {}

  static void push<T>(BuildContext context, String path, [T params]) {
    Application.router.navigateTo(context, path,
        transition: TransitionType.cupertino,
        routeSettings: RouteSettings(arguments: params));
  }

  static void pushAndRemoveUntil<T>(BuildContext context, String path,
      [T params]) {
    Application.router.navigateTo(context, path,
        transition: TransitionType.cupertino,
        clearStack: true,
        routeSettings: RouteSettings(arguments: params));
  }

  static void pushReplacement<T>(BuildContext context, String path,
      [T params]) {
    Application.router.navigateTo(context, path,
        transition: TransitionType.cupertino,
        replace: true,
        routeSettings: RouteSettings(arguments: params));
  }
}
