import 'package:flutter/material.dart';
import 'splash_home_demo.dart';
class SplashScreenDemo extends StatefulWidget {
  const SplashScreenDemo({Key key}) : super(key: key);

  @override
  _SplashScreenDemoState createState() => _SplashScreenDemoState();
}

class _SplashScreenDemoState extends State<SplashScreenDemo> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this, duration:  Duration(milliseconds: 2500));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => SplashHomePage() ),
                (route) {
                  return route == null;
                });
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
        opacity: _animation,
        child: Image.asset(
            'images/photo.jpg',
          scale: 2,
          fit: BoxFit.cover,
        ),
    );
  }
}
