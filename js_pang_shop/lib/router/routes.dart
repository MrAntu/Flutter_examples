import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'route_handler.dart';


class Routes {
  static String root = '/';
  static String detailsPage = '/detail';

  static void configureRoutes(Router router) {
    // 没找到路由判断
    router.notFoundHandler = Handler(
      handlerFunc: (context, params) {
        print("Erro ====> ROUTE WAS NOT FONUND!!!!!");
        return Text("");
      }
    );

    router.define(root, handler: rootHandler);
    router.define(detailsPage, handler: detailsHandler);
  }
}