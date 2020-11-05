import 'package:flutter/material.dart';
import 'dart:async';
/**
 * 这个demo展示了如何使用一个简单的overlay
 *
 * overlay组件能够让我们在当前页面上层覆盖一层新的组件
 * 通过 Overlay.of(context) 我们能够获得最近的root的OverlayState
 * 通过 overlayState.insert(overlayEntry)我们能够在当前页面上覆盖一层widget
 * 通过 overlayEntry.remove()能够移除掉覆盖层的overlayEntry.
 * 当add多个overlayEntry的时候，先被add的会在下面，后被add的会在上面
 *
 * 虽然我们一般都用[WidgetsApp]or[MaterialApp]中[Navigator]创建出来的Overlay
 * 但是你也可以使用Overlay小部件，自定义Overlay。
 */

class OverlayDemo extends StatefulWidget {
  const OverlayDemo({Key key}) : super(key: key);

  @override
  _OverlayDemoState createState() => _OverlayDemoState();
}

class _OverlayDemoState extends State<OverlayDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Overlay demo',
          style: TextStyle(
            fontSize: 36
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showOverlay(context);
        },
        child: Icon(Icons.fiber_smart_record),
      ),
    );
  }

  showOverlay(BuildContext context) async {

    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(builder: (context) {
      return Center(
        child: Container(
          width: 100,
          height: 100,
          color: Colors.pinkAccent,
        ),
      );
    });
    OverlayEntry overlayEntry2 = OverlayEntry(builder: (context) {
      return Center(
        child: Container(
          height: 50,
          width: 100,
          color: Colors.tealAccent,
        ),
      );
    });

    overlayState.insert(overlayEntry);
    overlayState.insert(overlayEntry2);

    await Future.delayed(Duration(seconds: 2));
    overlayEntry.remove();
    overlayEntry2.remove();
  }
}
