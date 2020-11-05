import 'package:flutter/material.dart';

/**
 * AnimationContainer使用要点
 * 必须传入Duration告诉动画的播放时间
 * 当animationContainer接收到一个新的值的时候
 * 会根据老值进行补间动画
 * 例如开始宽高为100，然后给了新值0并setState后
 * AnimationContainer会让宽高从100逐渐变化到0
 * 其中变化曲线由Curve决定，默认为Curves.linear
 */

class AnimatedContainerDemo extends StatefulWidget {
  const AnimatedContainerDemo({Key key}) : super(key: key);

  @override
  _AnimatedContainerDemoState createState() => _AnimatedContainerDemoState();
}

class _AnimatedContainerDemoState extends State<AnimatedContainerDemo> {
  double _value = 255.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
          onTap: () {
            _value = _value == 255.0 ? 80.0 : 255.0;
            setState(() {

            });
          },
          child: AnimatedContainer(
            curve: Curves.decelerate,
            duration: Duration(milliseconds: 300),
            width: _value,
            height: _value,
            child: FlutterLogo(),
          ),
      ),
    );
  }
}