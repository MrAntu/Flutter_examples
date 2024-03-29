import 'package:flutter/material.dart';

class BottomNavigationBarDemo extends StatefulWidget {
  @override
  _BottomNavigationBarDemoState createState() => _BottomNavigationBarDemoState();
}

class _BottomNavigationBarDemoState extends State<BottomNavigationBarDemo> {
  int _currentIndex = 0;

  void _onTapHandler(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: _onTapHandler,
      type: BottomNavigationBarType.fixed, //设置类型，大于 3个item，会不显示出来
      fixedColor: Colors.black,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            title: Text("explore")
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.history),
            title: Text("history")
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text("list")
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text("person")
        ),
      ],
    );
  }
}
