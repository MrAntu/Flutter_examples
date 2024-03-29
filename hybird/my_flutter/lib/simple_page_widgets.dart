import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:flutter/cupertino.dart';

class FirstRouteWidget extends StatefulWidget {
  const FirstRouteWidget({Key key}) : super(key: key);

  @override
  _FirstRouteWidgetState createState() => _FirstRouteWidgetState();
}

class _FirstRouteWidgetState extends State<FirstRouteWidget> {
  // flutter 侧MethodChannel配置，channel name需要和native侧一致
  static const MethodChannel _methodChannel =
      MethodChannel('flutter_native_channel');
  static const BasicMessageChannel _messageChannel = BasicMessageChannel(
      "flutter_native_message_channel", StandardMessageCodec());

  String _systemVersion = '';
  String _text = '';
  int number;
  Future<String> _getPlatformVersion() async {
    try {
      final String result =
          await _methodChannel.invokeMethod('getPlatformVersion');
      print('getPlatformVersion:' + result);
      setState(() {
        _systemVersion = result;
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  _connectBasicWithSend() async {
    _text = await _messageChannel.send("flutter发送的消息");
    // 刷新
    setState(() {});
  }

  _receiveMessage() {
    _messageChannel.setMessageHandler((message) {
      print(message);
      _text = message;
      if (this.mounted) {
        setState(() {});
      }
      return Future.value('flutter收到信息');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _receiveMessage();
    // 监听native的消息
    _methodChannel.setMethodCallHandler((call) {
      print(call.toString());
      String backResult = "gobackSuccess";
      if (call.method == 'goback') {
        print("goback");
      } else {
        backResult = "gobackError";
      }
      number = call.arguments['number'];
      if (this.mounted) {
        setState(() {});
      }
      return Future.value(backResult);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RaisedButton(
            child: Text('Open native page1sd'),
            onPressed: () {
              FlutterBoost.singleton
                  .open('native')
                  .then((Map<dynamic, dynamic> value) {
                print(
                    'call me when page is finished. did recieve second route result $value');
              });
            },
          ),
          RaisedButton(
            child: Text('Open second route111'),
            onPressed: () {
              FlutterBoost.singleton
                  .open('second')
                  .then((Map<dynamic, dynamic> value) {
                print(
                    'call me when page is finished. did recieve second route result $value');
              });
            },
          ),
          RaisedButton(
            child: Text('Present second route'),
            onPressed: () {
              FlutterBoost.singleton.open('second',
                  urlParams: {'present': true},
                  exts: {'animated': true}).then((Map<dynamic, dynamic> value) {
                print(
                    'call me when page is finished. did recieve second route result $value');
              });
            },
          ),
          RaisedButton(
            child:
                Text('Get system version by method channel:' + _systemVersion),
            onPressed: () => _getPlatformVersion(),
          ),
          RaisedButton(
            child: Text('测试basic message channel:' + _text),
            onPressed: () => _connectBasicWithSend(),
          ),
          Text("native参数 number: ${number}")
        ],
      ),
    ));
  }
}

class SecondRouteWidget extends StatefulWidget {
  const SecondRouteWidget({Key key}) : super(key: key);

  @override
  _SecondRouteWidgetState createState() => _SecondRouteWidgetState();
}

class _SecondRouteWidgetState extends State<SecondRouteWidget> {
  // flutter 侧MethodChannel配置，channel name需要和native侧一致
  static const MethodChannel _methodChannel =
      MethodChannel('flutter_native_channel');

  String _systemVersion = '';

  Future<String> _getPlatformVersion() async {
    try {
      final String result =
          await _methodChannel.invokeMethod('getPlatformVersion');
      print('getPlatformVersion:' + result);
      setState(() {
        _systemVersion = result;
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: Column(
          children: [
            RaisedButton(
              onPressed: () {
                // Navigate back to first route when tapped.

                final BoostContainerSettings settings =
                    BoostContainer.of(context).settings;
                FlutterBoost.singleton.close(
                  settings.uniqueId,
                  result: <String, dynamic>{'result': 'data from second'},
                );
              },
              child: const Text('Go back with result!'),
            ),
            RaisedButton(
              child: Text(
                  'Get system version by method channel:' + _systemVersion),
              onPressed: () => _getPlatformVersion(),
            ),
          ],
        ),
      ),
    );
  }
}

class EmbeddedFirstRouteWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EmbeddedFirstRouteWidgetState();
}

class _EmbeddedFirstRouteWidgetState extends State<EmbeddedFirstRouteWidget> {
  @override
  Widget build(BuildContext context) {
    print('_EmbededFirstRouteWidgetState build called!');
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: const Text('Open second route2'),
          onPressed: () {
            print('open second page!');
            FlutterBoost.singleton
                .open('second')
                .then((Map<dynamic, dynamic> value) {
              print(
                  'call me when page is finished. did recieve second route result $value');
            });
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    print('[XDEBUG]:_EmbededFirstRouteWidgetState disposing~');
    super.dispose();
  }
}
