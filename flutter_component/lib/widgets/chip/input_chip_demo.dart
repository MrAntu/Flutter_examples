import 'package:flutter/material.dart';

class InputChipDemo extends StatefulWidget {
  const InputChipDemo({Key key}) : super(key: key);

  @override
  _InputChipDemoState createState() => _InputChipDemoState();
}

class _InputChipDemoState extends State<InputChipDemo> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('filter chip demo'),
      ),
      body: Center(
        child: InputChip(
          label: Text('filter chip'),
          avatar: CircleAvatar(
            backgroundColor: Colors.grey.shade800,
            child: Text('AB'),
          ),
          onPressed: () {
            print('I am the one thing in life.');
          },
          onDeleted: (){},
        ),
      ),
    );
  }
}
