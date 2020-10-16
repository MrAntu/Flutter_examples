import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
class RxDartDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("RxDartDemo"),),
      body: RxDartHome(),
    );
  }
}

class RxDartHome extends StatefulWidget {
  @override
  _RxDartHomeState createState() => _RxDartHomeState();
}

class _RxDartHomeState extends State<RxDartHome> {
  PublishSubject<String> _textSubject;

  @override
  void dispose() {
    _textSubject.close();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 先监听，才能接受信息
    PublishSubject<String> _pub = PublishSubject<String>();
    _pub.listen((data) {
      print(data);
    });
    _pub.add("hello");

    // 先发消息，再监听都能接受，接受前发的信息只能接受最后一次发送的，
    //监听后的，每次发送都能接受
    BehaviorSubject<String> _behavior = BehaviorSubject<String>();
    _behavior.add("aaa");
    _behavior.add("bbb");
    _behavior.listen((data) => debugPrint("behavior-- ${data}") );
    _behavior.add("ccc");
    _behavior.add("dddd");

    // 先发消息，再监听都能接受，接受前后发的信息都能接受
    // 还有一个大功能，可以限制每次最大接受的数量
    //设置maxsize，监听前的消息，只接受最新的限制数量，监听后的发送消息都能接受
    //ReplaySubject<String> _replay = ReplaySubject<String>(maxSize: 1);
    ReplaySubject<String> _replay = ReplaySubject<String>();
    _replay.add("qqq");
    _replay.add("wwww");
    _replay.add("eee");
    _replay.listen((data) => print("_replay -- ${data}"));
    _replay.add("rrrr");
    _replay.add("tttt");

    // 初始化
    _textSubject = PublishSubject<String>();
    _textSubject.listen((data) => print("${data}"));

  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: "Title",
        filled: true
      ),
      onChanged: (value) {
        _textSubject.add("change-- ${value}");
      },
      onSubmitted: (value) {
        _textSubject.add("submit-- ${value}");
      },
    );
  }
}

