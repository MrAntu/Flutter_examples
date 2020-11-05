import 'package:flutter/material.dart';


/**
 * 普通chip
 * 可以自定义样式
 */

class ChipDemo extends StatefulWidget {
  const ChipDemo({Key key}) : super(key: key);

  @override
  _ChipDemoState createState() => _ChipDemoState();
}

class _ChipDemoState extends State<ChipDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('chip demo'),
      ),
      body: Center(
        child: Chip(
          label: Text('chip'),
          avatar: CircleAvatar(
            backgroundColor: Colors.grey.shade800,
            child: Text('01'),
          ),
        ),
      ),
    );
  }
}
