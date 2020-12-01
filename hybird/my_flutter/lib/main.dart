import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_boost/flutter_boost.dart';
import 'simple_page_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 注册路由
    FlutterBoost.singleton.registerPageBuilders(<String, PageBuilder>{
      'first':
          (String pageName, Map<String, dynamic> params, String uniqueId) =>
              FirstRouteWidget(),
      'second':
          (String pageName, Map<String, dynamic> params, String uniqueId) =>
              SecondRouteWidget(),
      'embeded':
          (String pageName, Map<String, dynamic> params, String uniqueId) =>
              EmbeddedFirstRouteWidget(),
    });
    // 监听路由跳转
    FlutterBoost.singleton.addBoostNavigatorObserver(BoostNavigatorObserver());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Boost example',
      builder: FlutterBoost.init(postPush: _onRoutePushed),
      home: Container(
        color: Colors.white,
      ),
    );
  }

  void _onRoutePushed(
    String pageName,
    String uniqueId,
    Map<String, dynamic> params,
    Route<dynamic> route,
    Future<dynamic> _,
  ) {
    print("123123123");
  }
}

class BoostNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    print('flutterboost#didPush');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    print('flutterboost#didPop');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic> previousRoute) {
    print('flutterboost#didRemove');
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    print('flutterboost#didReplace');
  }
}
