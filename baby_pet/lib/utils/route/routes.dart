import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'route_handlers.dart';

class Routes {
  static String main = '/main';
  static String home = '/home';
  static String login = '/login';
  static String setting = '/setting';
  static String grassDetail = '/grassDetail';
  static String petAdd = '/petAdd';
  static String findDetail = '/findDetail';

  static final RouteFactory generateRoute = (setting) {
    return null;
  };

  static final RouteFactory unknownRoute = (setting) {
    return null;
  };

  static void configureRoutes(FluroRouter router) {
    // 没找到路由判断
    router.notFoundHandler = Handler(handlerFunc: (context, params) {
      print("Erro ====> ROUTE WAS NOT FONUND!!!!!");
      return Text("sdfsdf");
    });

    router.define(main, handler: mainHandler);
    router.define(home, handler: homeHandler);
    router.define(login, handler: loginHandler);
    router.define(setting, handler: settingHandler);
    router.define(grassDetail, handler: grassDetailHandler);
    router.define(petAdd, handler: petAddHandler);
    router.define(findDetail, handler: findDetailHandler);
  }
}
