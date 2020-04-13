import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart';

class DetailWeb extends StatefulWidget {
  @override
  _DetailWebState createState() => _DetailWebState();
}

class _DetailWebState extends State<DetailWeb> {
  double _height = 400;
  WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        child: WebView(
          initialUrl: "https://flutterchina.club/",
          javascriptMode: JavascriptMode.unrestricted,
          gestureRecognizers: Set()..add(Factory<VerticalDragGestureRecognizer>(()=>VerticalDragGestureRecognizer())),
          onWebViewCreated: (controller) {
            _controller = controller;
          },
          onPageFinished: (url) {
            //调用JS得到实际高度 ,安卓超过5500
//            _controller.evaluateJavascript("document.body.scrollHeight;").then((value) {
//              print("${value}");
////              setState(() {
////                print("高度${double.parse(value)}");
////                _height = double.parse(value);
////              });
//            });

          },
        )
    );
  }
}

