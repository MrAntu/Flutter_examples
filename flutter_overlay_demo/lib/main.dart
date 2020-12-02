import 'package:flutter/material.dart';
import 'demo1.dart';
import 'demo2.dart';
import 'toast.dart';
import 'dialog_demo.dart';
import 'bottom_sheet.dart';
import 'bottom_sheet_corner.dart';
import 'shoppoing_detail.dart';
import 'loading_demo.dart';
import 'custom_appBar.dart';
import 'activity_alert.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Demo1()));
                  },
                  child: Text('demo1')),
              RaisedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Demo2()));
                  },
                  child: Text('demo2')),
              RaisedButton(
                  onPressed: () {
                    Toast.show(context, "水电费就开始京东方");
                  },
                  child: Text('toast')),
              RaisedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DialogDemo(
                              title: "qweqwe",
                            )));
                  },
                  child: Text('alert')),
              RaisedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BottomSheetDemo()));
                  },
                  child: Text('bottom_sheet')),
              RaisedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BottomSheetCorner()));
                  },
                  child: Text('bottom_sheet_常见圆角样式')),
              RaisedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoadingDemo()));
                  },
                  child: Text('loading封装')),
              RaisedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ShoppingDetail()));
                  },
                  child: Text('shopping_detail')),
              RaisedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CustomAppBar()));
                  },
                  child: Text('自定义导航栏')),
              RaisedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ActivityAlert()));
                  },
                  child: Text('活动弹窗样式')),
            ],
          ),
        ),
      ),
    );
  }
}
