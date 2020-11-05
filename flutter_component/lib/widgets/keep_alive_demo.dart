import 'package:flutter/material.dart';
/**
 * 实现原理，使用AutomaticKeepAliveClientMixin，并重写wantKeepAlive方法，让状态不被回收掉。
 */

class KeepAliveDemo extends StatefulWidget {
  const KeepAliveDemo({Key key}) : super(key: key);

  @override
  _KeepAliveDemoState createState() => _KeepAliveDemoState();
}

class _KeepAliveDemoState extends State<KeepAliveDemo> with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('keep alive demo'),
        bottom: TabBar(
          controller: _controller,
          tabs: [
            Tab(icon: Icon(Icons.directions_car),),
            Tab(icon: Icon(Icons.directions_transit),),
            Tab(icon: Icon(Icons.directions_bike),),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          KeepAlivePage(),
          KeepAlivePage(),
          KeepAlivePage(),

        ],
      ),
    );
  }
}


class KeepAlivePage extends StatefulWidget {
  const KeepAlivePage({Key key}) : super(key: key);

  @override
  _KeepAlivePageState createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<KeepAlivePage> with AutomaticKeepAliveClientMixin {
  int _count = 0;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  void _incrementCounter() {
    setState(() {
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You have pushed the button this many times:',
            ),
            Text('${_count}',
              style: Theme.of(context).textTheme.display1,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: Icon(Icons.add),
      ),
    );
  }


}
