import 'package:flutter/material.dart';
import 'package:xiecheng_app/widget/webView.dart';
class MyPage extends StatefulWidget {
  MyPage({Key key}) : super(key: key);

  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WebView(
          url: 'https://m.ctrip.com/webapp/myctrip/',
          hideAppBar: true,
          backForbid: true,
          statusBarColor: '4c5bca',
        )
    );
  }
}