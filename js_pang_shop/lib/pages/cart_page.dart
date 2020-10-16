import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  WebViewController _controller;
  String _title = "hellp";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${_title}"),
        ),
        body:
        Container(
          height: 5000,
          child: WebView(
            initialUrl: "https://flutterchina.club/",
            //JS执行模式 是否允许JS执行
            javascriptMode: JavascriptMode.unrestricted,
          ),
        )
    );
  }
}





