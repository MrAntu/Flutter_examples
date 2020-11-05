import 'package:flutter/material.dart';


/**
 * choice chip主要有两点需要注意
 * selected接受一个bool，代表当前是否被选中
 * onSelected方法会自动传入一个bool，从true开始，true->false->true交替
 */
class ChoiceChipDemo extends StatefulWidget {
  const ChoiceChipDemo({Key key}) : super(key: key);

  @override
  _ChoiceChipDemoState createState() => _ChoiceChipDemoState();
}

class _ChoiceChipDemoState extends State<ChoiceChipDemo> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('chioce chip'),
      ),
      body: Center(
        child: ChoiceChip(
          label: Text('choice chip'),
          selected: _isSelected,
          onSelected: (isSlected) {
            setState(() {
              _isSelected = isSlected;
            });
          },
        ),
      ),
    );
  }
}
