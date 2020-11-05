import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class RightBackDemo extends StatefulWidget {
  const RightBackDemo({Key key}) : super(key: key);

  @override
  _RightBackDemoState createState() => _RightBackDemoState();
}

class _RightBackDemoState extends State<RightBackDemo> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Demo'
        ),
      ),
      child: Center(
        child: Container(
          height: 100,
          width: 100,
          color: CupertinoColors.black,
          child: CupertinoButton(
            child: Icon(CupertinoIcons.add),
            onPressed: () {
              Navigator.of(context)
                  .push(CupertinoPageRoute(builder: (context) {
                    return RightBackDemo();
              }));
            },
          ),
        ),
      ),
    );
  }
}
