import 'package:flutter/material.dart';

class Demo2 extends StatefulWidget {
  const Demo2({Key key}) : super(key: key);

  @override
  _Demo2State createState() => _Demo2State();
}

class _Demo2State extends State<Demo2> {
  final _buttonKey = GlobalKey();
  final _layerLink = LayerLink();
  OverlayEntry _overlayEntry;

  @override
  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("demo2"),
      ),
      body: ListView(
        children: [
          Container(
            constraints: BoxConstraints.expand(height: size.height),
            alignment: Alignment.center,
            child: ListTile(
              title: CompositedTransformTarget(
                link: _layerLink,
                child: RaisedButton(
                  color: Colors.amberAccent,
                  key: _buttonKey,
                  onPressed: () {
                    if (_overlayEntry != null) {
                      _overlayEntry.remove();
                      _overlayEntry = null;
                      return;
                    }
                    final buttomSize = (_buttonKey.currentContext
                            .findRenderObject() as RenderBox)
                        .size;
                    _overlayEntry = OverlayEntry(
                        builder: (context) => Positioned(
                              width: buttomSize.width,
                              height: 300,
                              child: CompositedTransformFollower(
                                link: _layerLink,
                                showWhenUnlinked: false,
                                offset: Offset(0, buttomSize.height),
                                child: Container(
                                  color: Colors.blue,
                                ),
                              ),
                            ));
                    Overlay.of(context).insert(_overlayEntry);
                  },
                ),
              ),
            ),
          ),
          FractionallySizedBox(
            widthFactor: 1,
            child: Container(
              color: Colors.black12,
              height: 500,
            ),
          )
        ],
      ),
    );
  }
}
