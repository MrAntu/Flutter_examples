import 'package:flutter/material.dart';

class ActionChipDemo extends StatefulWidget {
  const ActionChipDemo({Key key}) : super(key: key);

  @override
  _ActionChipDemoState createState() => _ActionChipDemoState();
}

class _ActionChipDemoState extends State<ActionChipDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('action chip demo'),),
      body: Builder(
        builder: (context) {
          return Center(
            child: ActionChip(
              onPressed: () {
                setState(() {
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text('ON TAP')));
                });
              },
              label: Text('action chip'),
            ),
          );
        },
      ),
    );
  }
}
