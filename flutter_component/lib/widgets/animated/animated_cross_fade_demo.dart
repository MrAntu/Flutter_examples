import 'package:flutter/material.dart';

// AnimationCrossFade能够让我们在两个不同的Widget中进行淡化过渡
class AnimatedCrossFadeDemo extends StatefulWidget {
  const AnimatedCrossFadeDemo({Key key}) : super(key: key);

  @override
  _AnimatedCrossFadeDemoState createState() => _AnimatedCrossFadeDemoState();
}

class _AnimatedCrossFadeDemoState extends State<AnimatedCrossFadeDemo> {
  bool _first = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          _first = !_first;
          setState(() {

          });
        },
        child: AnimatedCrossFade(
          duration: Duration(milliseconds: 300),
          firstChild: FlutterLogo(
            style: FlutterLogoStyle.horizontal,
            size: 200,
          ),
          secondChild: FlutterLogo(
            style: FlutterLogoStyle.stacked,
            size: 200,
          ),
          crossFadeState: _first ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        ),
      ),
    );
  }
}
