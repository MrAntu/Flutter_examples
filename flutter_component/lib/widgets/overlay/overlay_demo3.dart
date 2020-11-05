import 'package:flutter/material.dart';
import 'dart:async';


class OverlayDemo3 extends StatefulWidget {
  const OverlayDemo3({Key key}) : super(key: key);

  @override
  _OverlayDemo3State createState() => _OverlayDemo3State();
}

class _OverlayDemo3State extends State<OverlayDemo3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Render demo'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(10),
            child: MyContainer(),
          );
        },

      ),
    );
  }
}


class MyContainer extends StatefulWidget {
  const MyContainer({Key key}) : super(key: key);

  @override
  _MyContainerState createState() => _MyContainerState();
}

class _MyContainerState extends State<MyContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: openOverlay,
      child: Container(
        alignment: Alignment.center,
        height: 200,
        color: Colors.black.withOpacity(0.2),
      ),
    );
  }

  void openOverlay() {
    OverlayState overlayState = Overlay.of(context);
    final RenderBox box = context.findRenderObject();
    final Offset target = box.localToGlobal(box.size.center(Offset.zero));
    final height = 100.0;
    final width = 100.0;

    OverlayEntry overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        top: target.dy - height / 2,
        left:  target.dx - width / 2,
        child: Container(
          alignment: Alignment.center,
          height: height,
          width: width,
          color: Colors.redAccent,
          child: Material(
            child: Text(
                '${target.toString()}'
            ),
          ),
        ),
      ) ;
    });

    overlayState.insert(overlayEntry);
    Future.delayed(Duration(seconds: 1)).then((value) => overlayEntry.remove());

  }
}
