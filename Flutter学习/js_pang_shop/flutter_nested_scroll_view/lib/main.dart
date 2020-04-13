import 'package:flutter/material.dart';
import 'dart:ui';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
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

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: NestedScrollDemo()
    );
  }
}


class NestedScrollDemo extends StatefulWidget {
  @override
  _NestedScrollDemoState createState() => _NestedScrollDemoState();
}

class _NestedScrollDemoState extends State<NestedScrollDemo> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: false,
              title: Text(
                "首页",
                style: TextStyle(
                    color: Colors.black
                ),
              ),
              backgroundColor: Colors.transparent,
              bottom: TabBar(
                controller: _tabController,
                labelColor: Colors.black,
                tabs: <Widget>[
                  Tab(text: "商品",),
                  Tab(text: "评价",),
                  Tab(text: "商家",),
                ],
              ),
            )
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            ListView.builder(
              itemExtent: 100,
              itemCount: 100,
              itemBuilder: (context, index) {
                return Container(
                  child: Text("${index}"),
                );
              },
            ),
            ListView.builder(
              itemExtent: 100,
              itemCount: 100,
              itemBuilder: (context, index) {
                return Container(
                  child: Text("${index}"),
                );
              },
            ),
            ListView.builder(
              itemExtent: 100,
              itemCount: 100,
              itemBuilder: (context, index) {
                return Container(
                  child: Text("${index}"),
                );
              },
            )
          ],
        )
    );
  }
}


