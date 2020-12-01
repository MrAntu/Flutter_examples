import 'package:flutter/material.dart';

class Demo1 extends StatefulWidget {
  const Demo1({Key key}) : super(key: key);

  @override
  _Demo1State createState() => _Demo1State();
}

class _Demo1State extends State<Demo1> {
  OverlayEntry _overlayEntry;
  int _current = 0;
  final buttonRowKey = GlobalKey();

  @override
  void dispose() {
    // TODO: implement dispose
    _overlayEntry?.remove();
    _overlayEntry = null;
    _current = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('demo1'),
        ),
        body: _child());
  }

  _child() {
    return Column(
      children: [
        Row(
          key: buttonRowKey,
          children: List.generate(3, (index) {
            return RaisedButton(
              onPressed: () {
                final i = index + 1;
                // 点击当前按钮，移除overlay
                if (i == _current) {
                  _overlayEntry?.remove();
                  _overlayEntry = null;
                  _current = 0;
                  return;
                }
                _current = i;
                _overlayEntry?.remove();
                // 获取按钮的位置
                final box =
                    buttonRowKey.currentContext.findRenderObject() as RenderBox;
                final dy = box.localToGlobal(Offset(0, box.size.height)).dy;
                _overlayEntry = OverlayEntry(
                    builder: (context) => Positioned.fill(
                          top: dy,
                          child: Stack(
                            children: [
                              Container(
                                color: Colors.red,
                              ),
                              Material(
                                color: Colors.transparent,
                                child: Column(
                                  children: [
                                    Container(
                                      color: Colors.green,
                                      alignment: Alignment.center,
                                      constraints:
                                          BoxConstraints.expand(height: 500),
                                      child: Text("menu$i"),
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          _overlayEntry.remove();
                                          _overlayEntry = null;
                                          _current = 0;
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ));
                Overlay.of(context).insert(_overlayEntry);
              },
              child: Text('menu${index}'),
            );
          }),
        )
      ],
    );
  }
}
